----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/08/2018 04:05:09 PM
-- Design Name: 
-- Module Name: top - Behavioral
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


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is
    port (  
        clock_y3                :   in      std_logic;
        user_reset              :   in      std_logic;
		--user_start				: 	in		std_logic;
        usb_rs232_rxd           :   in      std_logic;
        usb_rs232_txd           :   out     std_logic;
		done					:	out		std_logic;
		start_out				:	out		std_logic;
		data_rx_led: out std_logic_vector(7 downto 0)
    );
end top;


architecture Behavioral of top is
COMPONENT memory_large is
    Port ( CLK : in STD_LOGIC;
           WE_1 : in STD_LOGIC;
           EN_1 : in STD_LOGIC;
           WE_2 : in STD_LOGIC;
           EN_2 : in STD_LOGIC;
           ADDR_1 : in STD_LOGIC_VECTOR (14 downto 0);
           DI_1 : in STD_LOGIC_VECTOR (31 downto 0);
           DO_1 : out STD_LOGIC_VECTOR (31 downto 0);
           ADDR_2 : in STD_LOGIC_VECTOR (14 downto 0);
           DI_2 : in STD_LOGIC_VECTOR (31 downto 0);
           DO_2 : out STD_LOGIC_VECTOR (31 downto 0));
end COMPONENT;

COMPONENT uart is
    generic (
        baud                : positive;
        clock_frequency     : positive
    );
    port (  
        clock               :   in  std_logic;
        reset               :   in  std_logic;    
        data_stream_in      :   in  std_logic_vector(7 downto 0);
        data_stream_in_stb  :   in  std_logic;
        data_stream_in_ack  :   out std_logic;
        data_stream_out     :   out std_logic_vector(7 downto 0);
        data_stream_out_stb :   out std_logic;
        tx                  :   out std_logic;
        rx                  :   in  std_logic
    );
end COMPONENT;

COMPONENT mem_controller IS
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
END COMPONENT;

COMPONENT accelerator IS
	PORT(
		d_in: in std_logic_vector(31 downto 0);
		addr: out std_logic_vector(14 downto 0);
		we: out std_logic;
		en: out std_logic;
		done: out std_logic;
		start_in: in std_logic;
		reset_acc: in std_logic;
		restart: in std_logic;
		clk: in std_logic;
		error: out unsigned (31 downto 0)
	);
END COMPONENT;

	SIGNAL EN_1_INT, WE_1_INT, EN_2_INT, WE_2_INT: std_logic;
	SIGNAL ADDR_1_INT, ADDR_2_INT, ADDR_2_INT_2: std_logic_vector(14 downto 0);
	SIGNAL DATA_TX_INT, DATA_RX_INT: std_logic_vector(7 downto 0);
	SIGNAL DATA_TX_STB_INT, DATA_RX_STB_INT, DATA_TX_ACK_INT: std_logic;
	
	SIGNAL DI_1_INT, DI_2_INT, DO_1_INT, DO_2_INT: std_logic_vector(31 downto 0);
	SIGNAL DONE_INT: std_logic;
	
	SIGNAL ERROR_OUT: std_logic_vector(31 downto 0); 
	SIGNAL ERROR_OUT_NEXT: unsigned(31 downto 0);
	
	SIGNAL restart_int: std_logic;
	
	--synchronized inputs
	SIGNAL reset_sync1, reset_sync2, reset_sync3, reset_sync, start_int: std_logic;
begin
	memory1: memory_large port map(clk => clock_y3, WE_1 => WE_1_INT, EN_1 => EN_1_INT, WE_2 => WE_2_INT, EN_2 => EN_2_INT, ADDR_1 => ADDR_1_INT, DI_1 => DI_1_INT,
									DO_1 => DO_1_INT, ADDR_2 => ADDR_2_INT, DI_2 => (others => '0'), DO_2 => DO_2_INT);
	uart1: uart generic map(baud => 115200, clock_frequency =>positive(100_000_000))
				port map(clock => clock_y3, reset => reset_sync1, data_stream_in => DATA_TX_INT, data_stream_in_stb => DATA_TX_STB_INT, data_stream_in_ack => DATA_TX_ACK_INT, 
					data_stream_out => DATA_RX_INT,	data_stream_out_stb => DATA_RX_STB_INT, tx => usb_rs232_txd, rx => usb_rs232_rxd);
	mem_controller1: mem_controller port map(clk => clock_y3, reset_ctrl => reset_sync2, data_tx => DATA_TX_INT, data_tx_stb => DATA_TX_STB_INT, data_tx_ack => DATA_TX_ACK_INT,
											 data_rx => DATA_RX_INT, data_rx_stb => DATA_RX_STB_INT, en => EN_1_INT, we => WE_1_INT, addr => ADDR_1_INT, 
											 d_out => DI_1_INT, d_in => DO_1_INT, data_rx_led => data_rx_led, result => ERROR_OUT, detection_done => DONE_INT, start_detection => start_int, restart => restart_int);
	accelerator1: accelerator port map(clk => clock_y3, reset_acc => reset_sync3, start_in => start_int, d_in => DO_2_INT, addr => ADDR_2_INT, 	
										we => WE_2_INT, en => EN_2_INT, done => DONE_INT, error => ERROR_OUT_NEXT, restart => restart_int);
	
	store_error: process(clock_y3, DONE_INT)
	begin
		if rising_edge(clock_y3) and DONE_INT = '1' then
			ERROR_OUT <= std_logic_vector(ERROR_OUT_NEXT);
		end if;
	end process;
	
	done <= DONE_INT;
	start_out <= start_int;
	
	debounce: process(clock_y3)
	begin
		if rising_edge(clock_y3) then
			reset_sync <= user_reset;
			reset_sync1 <= reset_sync;
			reset_sync2 <= reset_sync;
			reset_sync3 <= reset_sync;
			--start_sync <= user_start;
		end if;
	end process;
end Behavioral;
