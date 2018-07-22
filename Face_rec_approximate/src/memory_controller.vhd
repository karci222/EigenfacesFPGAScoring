----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/03/2018 04:05:24 PM
-- Design Name: 
-- Module Name: uart_sim - Behavioral_uart
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


LIBRARY ieee;
USE STD.textio.all;
USE ieee.std_logic_1164.ALL;
use IEEE.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY mem_controller IS
	PORT(
		clk: in std_logic;
		reset_ctrl: in std_logic;
		data_tx: out std_logic_vector(7 downto 0);
		data_tx_stb: out std_logic;
		data_rx: in std_logic_vector(7 downto 0);
		data_rx_stb: in std_logic;
		data_tx_ack: in std_logic;
		en: out std_logic;
		we: out std_logic;
		start_detection: out std_logic;
		detection_done: in std_logic;
		addr: out std_logic_vector(14 downto 0);
		d_out: out std_logic_vector(31 downto 0);
		d_in: in std_logic_vector(31 downto 0);
		data_rx_led: out std_logic_vector(7 downto 0);
		result: in std_logic_vector(31 downto 0);
		restart: out std_logic
	);
END mem_controller;

ARCHITECTURE behavioural of mem_controller IS
	type state_t is (START, CMD, CLR, READ_GHOST0, READ_GHOST1, READ_GHOST2, READ_GHOST3, STORE_GHOST, CHECK, CHECK0, CHECK1, CHECK2, CHECK3, -- CHECK states are for debugging purposes only
						READ_SAMPLE0, READ_SAMPLE1, READ_SAMPLE2, READ_SAMPLE3, STORE_SAMPLE, FINISH, TEST, ERROR, READ_RESULT, DETECTION_WAIT);
	SIGNAL state, state_next: state_t;					
	SIGNAL ghost, ghost_next, sample, sample_next: std_logic_vector(31 downto 0);
	SIGNAL j, j_next: unsigned(14 downto 0);
	SIGNAL check_sample: std_logic_vector(31 downto 0);
	SIGNAL error_code, error_code_next: std_logic_vector(7 downto 0);
BEGIN
	
	SEQ: process(clk, reset_ctrl)
	BEGIN
		if rising_edge(clk) then
			if reset_ctrl = '1' then
				j <= (others => '0');
				state <= START;
				ghost <= (others => '0');
				sample <= (others => '0');
				error_code <= (others => '0');
			else
			
				j <= j_next;
				state <= state_next;
				ghost <= ghost_next;
				sample <= sample_next;
				error_code <= error_code_next;
			end if;
		end if;
	END process;
	
	CL: process(state, j, ghost, sample, data_rx, data_rx_stb, d_in, data_tx_ack, error_code, result, detection_done)
	BEGIN
		addr <= std_logic_vector(j);
		en <= '0';
		we <= '0';
		d_out <= (others => '0');
		j_next <= j;
		state_next <= state;
		ghost_next <= ghost;
		sample_next <= sample;
		data_tx <= (others => '0');
		data_tx_stb <= '0';
		data_rx_led <= error_code;
		error_code_next <= error_code;
		start_detection <= '0';
		restart <='0';
		case(state) is
			when START =>
				j_next <= (others => '0');
				state_next <= CMD;
				error_code_next <= (others => '0');
			-- for debugging purposes only
			when CMD =>
				if data_rx_stb = '0' then
					state_next <= CMD;
				else
					if data_rx = x"73" then -- s - load sample
						state_next <= READ_SAMPLE0;
						j_next <= to_unsigned(8192, j_next'length);
					elsif data_rx = x"67" then -- g --load ghost
						state_next <= READ_GHOST0;
						j_next <= (others => '0');
					elsif data_rx = x"63" then -- c - check memory - for debugging on FPGA
						state_next <= CHECK;
						j_next <= to_unsigned(10767, j_next'length);
					elsif data_rx = x"72" then -- r - reset/clear memory
						state_next <= CLR;
						j_next <= to_unsigned(0, j_next'length);
					elsif data_rx = x"74" then -- t for test
						state_next <= TEST;
					elsif data_rx = x"65" then -- e to see the final error
						state_next <= READ_RESULT;
						j_next <= (others => '0');
					elsif data_rx = x"61" then  --starting signal
						start_detection <= '1';
						state_next <= DETECTION_WAIT;
					else
						state_next <= CMD;
						error_code_next <= x"EF";
					end if;
				end if;
			when DETECTION_WAIT =>
				if detection_done = '1' then
					error_code_next <=x"0B";
					state_next <= READ_RESULT;
				else
					error_code_next <= x"0A";
					state_next <= DETECTION_WAIT;
				end if;
			when ERROR =>
				error_code_next <= x"FF";
				state_next <= ERROR;
			when TEST =>
				data_tx <= x"74";
				data_tx_stb <= '1';
				if data_tx_ack = '0' then
					state_next <= TEST;
				else
					state_next <= CMD;
				end if;
			when READ_GHOST0 =>
				error_code_next<=x"11";
				if data_rx_stb = '0' then
					state_next <= READ_GHOST0;
				else
					ghost_next(7 downto 0) <= data_rx;
					state_next <= READ_GHOST1;
				end if;
			when READ_GHOST1 =>
				if data_rx_stb = '0' then
					state_next <= READ_GHOST1;
				else
					ghost_next(15 downto 8) <= data_rx;
					state_next <= READ_GHOST2;
				end if;
			when READ_GHOST2 =>
				if data_rx_stb = '0' then
					state_next <= READ_GHOST2;
				else
					ghost_next(23 downto 16) <= data_rx;
					state_next <= READ_GHOST3;
				end if;
			when READ_GHOST3 =>
				if data_rx_stb = '0' then
					state_next <= READ_GHOST3;
				else
					ghost_next(31 downto 24) <= data_rx;
					state_next <= STORE_GHOST;
				end if;	
			when STORE_GHOST =>
				we <= '1';
				en <= '1';
				addr <= std_logic_vector(j);
				d_out <= ghost;
				if j < 2575 then
					j_next <= unsigned(j + 1);
					state_next <= READ_GHOST0;
				else
					j_next <= to_unsigned(0, j_next'length);
					state_next <= CMD;
					error_code_next <= x"02";
				end if;
			when READ_SAMPLE0 =>
				if data_rx_stb = '0' then
					state_next <= READ_SAMPLE0;
				else
					sample_next(7 downto 0) <= data_rx;
					state_next <= READ_SAMPLE1;
				end if;
			when READ_SAMPLE1 =>
				if data_rx_stb = '0' then
					state_next <= READ_SAMPLE1;
				else
					sample_next(15 downto 8) <= data_rx;
					state_next <= READ_SAMPLE2;
				end if;
			when READ_SAMPLE2 =>
				if data_rx_stb = '0' then
					state_next <= READ_SAMPLE2;
				else
					sample_next(23 downto 16) <= data_rx;
					state_next <= READ_SAMPLE3;
				end if;
			when READ_SAMPLE3 =>
				if data_rx_stb = '0' then
					state_next <= READ_SAMPLE3;
				else
					sample_next(31 downto 24) <= data_rx;
					state_next <= STORE_SAMPLE;
				end if;
			when STORE_SAMPLE =>
				we <= '1';
				en <= '1';
				addr <= std_logic_vector(j);
				d_out <= sample;
				if j < 10767 then
					j_next <= unsigned(j + 1);
					state_next <= READ_SAMPLE0;
				else
					j_next <= to_unsigned(0, j_next'length);
					state_next <= CMD;
				end if;
			-- not implemented yet
			when CLR =>
				state_next <= CMD;
			-- for debugging purpose only, checks the sample
			-- sends last 4 bytes of the picture
			when CHECK =>
				addr <= std_logic_vector(j);
				en <= '1';
				state_next <= CHECK0;
			when CHECK0 =>
				addr <= std_logic_vector(j);
				en <= '1';
				data_tx <= d_in(7 downto 0);
				data_tx_stb <= '1';
				if data_tx_ack = '0' then
					state_next <= CHECK0;
				else
					state_next <= CHECK1;
				end if;
			when CHECK1 =>
				addr <= std_logic_vector(j);
				en <= '1';
				data_tx <= d_in(15 downto 8);
				data_tx_stb <= '1';
				if data_tx_ack = '0' then
					state_next <= CHECK1;
				else
					state_next <= CHECK2;
				end if;
			when CHECK2 =>
				addr <= std_logic_vector(j);
				en <= '1';
				data_tx <= d_in(23 downto 16);
				data_tx_stb <= '1';
				if data_tx_ack = '0' then
					state_next <= CHECK2;
				else
					state_next <= CHECK3;
				end if;
			when CHECK3 =>
				addr <= std_logic_vector(j);
				en <= '1';
				data_tx <= d_in(31 downto 24);
				data_tx_stb <= '1';
				if data_tx_ack = '0' then
					state_next <= CHECK3;
				else
					state_next <= CMD;
				end if;
			when READ_RESULT =>
				error_code_next <= x"88";
				if j = 0 then
					data_tx <= result(7 downto 0);
					data_tx_stb <= '1';
					if data_tx_ack = '0' then
						state_next <= READ_RESULT;
					elsif
						j_next <= unsigned(j + 1);
						state_next <= READ_RESULT;
					end if;
				elsif j = 1 then
					data_tx <= result(15 downto 8);
					data_tx_stb <= '1';
					if data_tx_ack = '0' then
						state_next <= READ_RESULT;
					else
						j_next <= unsigned(j + 1);
						state_next <= READ_RESULT;
					end if;
				elsif j = 2 then
					data_tx <= result(23 downto 16);
					data_tx_stb <= '1';
					if data_tx_ack = '0' then
						state_next <= READ_RESULT;
					else
						j_next <= unsigned(j + 1);
						state_next <= READ_RESULT;
					end if;
				elsif j = 3 then
					data_tx <= result(31 downto 24);
					data_tx_stb <= '1';
					restart <= '1';
					if data_tx_ack = '0' then
						state_next <= READ_RESULT;
					else
						j_next <= (others => '0');
						restart <= '1';
						state_next <= CMD;
					end if;
				else
					state_next <= ERROR;
				end if;
			when FINISH =>
				state_next <= FINISH;
		end case;
	END process;
END behavioural;