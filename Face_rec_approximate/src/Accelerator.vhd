LIBRARY ieee;
USE STD.textio.all;
USE ieee.std_logic_1164.ALL;
use IEEE.numeric_std.all;

ENTITY accelerator IS
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
END accelerator;

ARCHITECTURE behavioural of accelerator IS
	COMPONENT adder2 is
	PORT (opp_a, opp_b: in std_logic_vector(20 downto 0); 
			cin: in std_logic;
			result: out std_logic_vector(20 downto 0));
	END COMPONENT;

	COMPONENT adder1 is
	PORT (opp_a, opp_b: in std_logic_vector(8 downto 0); 
			cin: in std_logic;
			result: out std_logic_vector(8 downto 0));
	END COMPONENT;
	
	type state_t is (start, address_preload_ghost, read_ghost, read_sample, compute_error, pre_finish, finish);
	SIGNAL err_out, err_out_next: unsigned(20 downto 0);
	SIGNAL state, state_next: state_t := start;
	SIGNAL ghost, ghost_next: std_logic_vector(31 downto 0);
	SIGNAL sample, sample_next: std_logic_vector(31 downto 0);
	SIGNAL address1, address1_next, address2, address2_next: unsigned(14 downto 0);
	SIGNAL ina1, inb1, ina2, inb2, ina3, inb3, ina4, inb4: std_logic_vector(8 downto 0);
	SIGNAL in2a1, in2b1, in2a2, in2b2, in2a3, in2b3, in2a4, in2b4: std_logic_vector(20 downto 0);
	SIGNAL diff1, diff2, diff3, diff4, diff1_n, diff2_n, diff3_n, diff4_n: std_logic_vector(8 downto 0);
	SIGNAL j, j_next: unsigned(15 downto 0);
	SIGNAL err1, err2, err3, err4, err1_next,err2_next, err3_next, err4_next: std_logic_vector(20 downto 0);
	SIGNAL result1, result2, result3, result4: std_logic_vector(20 downto 0);
BEGIN
	seq: PROCESS(clk, reset_acc)
	BEGIN
		
		if rising_edge(clk) then
			if reset_acc = '1' then 
				state <= start;
				address1 <= (others => '0');
				address2 <= to_unsigned(8192, address2'length);
				j <= to_unsigned(0, j'length);
				err1 <= (others => '0');
				err2 <= (others => '0');
				err3 <= (others => '0');
				err4 <= (others => '0');
				sample <= (others => '0');
				ghost <= (others => '0');
				err_out <= (others => '0');
			else
				err_out <= err_out_next;
				state <= state_next;
				address1 <= address1_next;
				address2 <= address2_next;
				j <= j_next;
				err1 <= err1_next;
				err2 <= err2_next;
				err3 <= err3_next;
				err4 <= err4_next;
				sample <= sample_next;
				ghost <= ghost_next;
			end if;
		end if;
	END PROCESS;
	
	cl: PROCESS(restart, err_out, d_in, result1, result2, result3, result4, address1, address2, state, j, err1, err2, err3, err4, ghost, sample, start_in)
	BEGIN
		state_next <= state;
		address1_next <= address1;
		address2_next <= address2;
		j_next <= j;
		err1_next <= err1;
		err2_next <= err2;
		err3_next <= err3;
		err4_next <= err4;
		done <= '0';
		addr <= (others => '0');
		en <= '0';
		we <= '0';
		sample_next <= sample;
		ghost_next <= ghost;
		err_out_next <= err_out;
		error <= resize(err_out, 32);
		case state is
			when start =>
				if start_in = '1' then
					err_out_next <= (others => '0');
					j_next <= to_unsigned(0, j_next'length);
					address1_next <= to_unsigned(0, address1_next'length);
					address2_next <= to_unsigned(8192, address2_next'length);
					err1_next <= (others => '0');
					err2_next <= (others => '0');
					err3_next <= (others => '0');
					err4_next <= (others => '0');
					state_next <= address_preload_ghost;
				else
					state_next <= start;
				end if;
			when address_preload_ghost =>
				addr <= std_logic_vector(address1);
				en <= '1';
				we <= '0';
				address1_next <= unsigned(unsigned(address1) + 1);
				state_next <= read_ghost;
			when read_ghost =>
				ghost_next<=d_in;
				addr <= std_logic_vector(address2);
				address2_next <= unsigned(address2 + 1);
				en <= '1';
				we <= '0';
				state_next <= read_sample;
			when read_sample =>
				sample_next<= d_in;
				en <= '1';
				we <= '0';
				state_next <= compute_error;
			when compute_error =>
				err1_next <= result1;
				err2_next <= result2;
				err3_next <= result3;
				err4_next <= result4;
				if j < 2575 then
					j_next <= j + 1;
					addr <= std_logic_vector(address1);
					address1_next <= unsigned(unsigned(address1) + 1);
					en <= '1';
					we <= '0';
					state_next <= read_ghost;
				else
					state_next <= pre_finish;
				end if;
			when pre_finish =>
				err_out_next <= unsigned(result1) + unsigned(result2) + unsigned(result3) + unsigned(result4);
				state_next <= finish;
			when finish =>
				if restart = '0' then
					done <= '1';
					state_next <= finish;
				else
					state_next <= start;
				end if;
		end case;
	END PROCESS;
	
	ina1<='0'&ghost(31 downto 24);
	ina2<='0'&ghost(23 downto 16);
	ina3<='0'&ghost(15 downto 8);
	ina4<='0'&ghost(7 downto 0);
	inb1<='1'&not(sample(31 downto 24));
	inb2<='1'&not(sample(23 downto 16));
	inb3<='1'&not(sample(15 downto  8));
	inb4<='1'&not(sample(7  downto  0));
	
	add1: entity work.adder1(behaviour_2) port map(opp_a => ina1, opp_b => inb1,  cin => '0', result =>diff1);
	add2: entity work.adder1(behaviour_2) port map(opp_a => ina2, opp_b => inb2,  cin => '0', result =>diff2);
	add3: entity work.adder1(behaviour_2) port map(opp_a => ina3, opp_b => inb3,  cin => '0', result =>diff3);
	add4: entity work.adder1(behaviour_2) port map(opp_a => ina4, opp_b => inb4,  cin => '0', result =>diff4);
	
	diff1_n <= not(diff1);
	diff2_n <= not(diff2);
	diff3_n <= not(diff3);
	diff4_n <= not(diff4);
	
	process(diff1, diff2, diff3, diff4, diff1_n, diff2_n, diff3_n, diff4_n)
	begin
		if diff1(8) = '1' then
			in2a1 <= std_logic_vector(resize(unsigned(diff1_n), 21));
		else
			in2a1 <= std_logic_vector(resize(unsigned(diff1), 21));
		end if;
		if diff2(8) = '1' then
			in2a2 <= std_logic_vector(resize(unsigned(diff2_n), 21)); 
		else
			in2a2 <= std_logic_vector(resize(unsigned(diff2), 21));
		end if;
		if diff3(8) = '1' then
			in2a3 <= std_logic_vector(resize(unsigned(diff3_n), 21)); 
		else
			in2a3 <= std_logic_vector(resize(unsigned(diff3), 21));
		end if;
		if diff4(8) = '1' then
			in2a4 <= std_logic_vector(resize(unsigned(diff4_n), 21)); 
		else
			in2a4 <= std_logic_vector(resize(unsigned(diff4), 21));
		end if;
	end process;
	
	add21: entity work.adder2(behaviour_1) port map(opp_a => in2a1, opp_b => err1, cin => '0', result => result1);
	add22: entity work.adder2(behaviour_1) port map(opp_a => in2a2, opp_b => err2, cin => '0', result => result2);
	add23: entity work.adder2(behaviour_1) port map(opp_a => in2a3, opp_b => err3, cin => '0', result => result3);
	add24: entity work.adder2(behaviour_1) port map(opp_a => in2a4, opp_b => err4, cin => '0', result => result4);
	
END behavioural;