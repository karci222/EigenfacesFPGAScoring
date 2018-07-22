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
COMPONENT TensorCore IS
   PORT(a1: in std_logic_vector(63 downto 0);
		a2: in std_logic_vector(63 downto 0);
		a3: in std_logic_vector(63 downto 0);
		a4: in std_logic_vector(63 downto 0);
		b1: in std_logic_vector(63 downto 0);
		b2: in std_logic_vector(63 downto 0);
		b3: in std_logic_vector(63 downto 0);
		b4: in std_logic_vector(63 downto 0);
		c1: in std_logic_vector(127 downto 0);
		c2: in std_logic_vector(127 downto 0);
		c3: in std_logic_vector(127 downto 0);
		c4: in std_logic_vector(127 downto 0);
		d1: out std_logic_vector(127 downto 0);
		d2: out std_logic_vector(127 downto 0);
		d3: out std_logic_vector(127 downto 0);
		d4: out std_logic_vector(127 downto 0));
END COMPONENT;
	type state_t is (start, address_preload_ghost, read_ghost, read_sample, compute_error, final_error, finish);
	type ghost_t is array(3 downto 0) of std_logic_vector(31 downto 0);
	type sample_t is array(3 downto 0) of std_logic_vector(31 downto 0);
	SIGNAL err_out, err_out_next: unsigned(31 downto 0);
	SIGNAL state: state_t := start; 
	SIGNAL state_next: state_t;
	SIGNAL ghost, ghost_next: ghost_t;
	SIGNAL sample, sample_next: sample_t;
	SIGNAL err1, err2, err3, err4, err1_next, err2_next, err3_next, err4_next: std_logic_vector(127 downto 0);
	SIGNAL result1, result2, result3, result4: std_logic_vector(127 downto 0);
	SIGNAL i, i_next: unsigned(3 downto 0);
	SIGNAL j, j_next: unsigned(15 downto 0);
	SIGNAL address1, address1_next, address2, address2_next: unsigned(14 downto 0);
	SIGNAL ghost1, ghost2, ghost3, ghost4, sample1, sample2, sample3, sample4: std_logic_vector(31 downto 0);
	SIGNAL op1, op2, op3, op4, op5, op6, op7, op8, op9, op10, op11, op12, op13, op14, op15, op16: signed(8 downto 0);
	SIGNAL op1_res, op2_res, op3_res, op4_res, op5_res, op6_res, op7_res, op8_res, op9_res, op10_res, op11_res, op12_res, op13_res, op14_res, op15_res, op16_res: signed(15 downto 0);
	SIGNAL in1, in2, in3, in4: std_logic_vector(63 downto 0);
BEGIN
	seq: PROCESS(clk, reset_acc)
	BEGIN
		
		if rising_edge(clk) then
			if reset_acc = '1' then 
				state <= start;
				address1 <= (others => '0');
				address2 <= to_unsigned(8192, address2'length);
				i <= to_unsigned(0, i'length);
				j <= to_unsigned(0, j'length);
				err1 <= (others => '0');
				err2 <= (others => '0');
				err3 <= (others => '0');
				err4 <= (others => '0');
				sample(0) <= (others => '0');
				sample(1) <= (others => '0');
				sample(2) <= (others => '0');
				sample(3) <= (others => '0');
				ghost(0) <= (others => '0');
				ghost(1) <= (others => '0');
				ghost(2) <= (others => '0');
				ghost(3) <= (others => '0');
				err_out <= (others => '0');
			else
				err_out <= err_out_next;
				state <= state_next;
				address1 <= address1_next;
				address2 <= address2_next;
				i <= i_next;
				j <= j_next;
				err1 <= err1_next;
				err2 <= err2_next;
				err3 <= err3_next;
				err4 <= err4_next;
				sample(0) <= sample_next(0);
				sample(1) <= sample_next(1);
				sample(2) <= sample_next(2);
				sample(3) <= sample_next(3);
				ghost(0) <= ghost_next(0);
				ghost(1) <= ghost_next(1);
				ghost(2) <= ghost_next(2);
				ghost(3) <= ghost_next(3);
			end if;
		end if;
	END PROCESS;
	
	cl: PROCESS(err_out, d_in, result1, result2, result3, result4, address1, address2, state, i, j, err1, err2, err3, err4, ghost1, ghost2, ghost3, ghost4, ghost, sample, start_in, restart)
	BEGIN
		state_next <= state;
		address1_next <= address1;
		address2_next <= address2;
		i_next <= i;
		j_next <= j;
		err1_next <= err1;
		err2_next <= err2;
		err3_next <= err3;
		err4_next <= err4;
		done <= '0';
		addr <= (others => '0');
		en <= '0';
		we <= '0';
		sample_next(0) <= sample(0);
		sample_next(1) <= sample(1);
		sample_next(2) <= sample(2);
		sample_next(3) <= sample(3);
		ghost_next(0) <= ghost(0);
		ghost_next(1) <= ghost(1);
		ghost_next(2) <= ghost(2);
		ghost_next(3) <= ghost(3);
		err_out_next <= err_out;
		error <= err_out;
		case state is
			when start =>
				if start_in = '1' then
					err_out_next <= (others => '0');
					j_next <= to_unsigned(0, j_next'length);
					address1_next <= (others => '0');
					address2_next <= to_unsigned(8192, address2_next'length);
					i_next <= to_unsigned(0, i_next'length);
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
				i_next <= to_unsigned(0, i_next'length);
				address1_next <= unsigned(unsigned(address1) + 1);
				state_next <= read_ghost;
			when read_ghost =>
				if i < 3 then
					ghost_next(to_integer(i)) <= d_in;
					addr <= std_logic_vector(address1);
					address1_next <= unsigned(unsigned(address1) + 1);
					en <= '1';
					we <= '0';
					i_next <= unsigned(unsigned(i) + 1);
					state_next <= read_ghost;
				else
					addr <= std_logic_vector(address2);
					address2_next <= unsigned(unsigned(address2) + 1);
					en <= '1';
					we <= '0';
					i_next <= (others => '0');
					ghost_next(to_integer(i)) <= d_in;
					state_next <=read_sample;
				end if;
			when read_sample =>
				if i < 3 then
					sample_next(to_integer(i)) <= d_in;
					addr <= std_logic_vector(address2);
					address2_next <= unsigned(unsigned(address2) + 1);
					en <= '1';
					we <= '0';
					i_next <= unsigned(unsigned(i) + 1);
					state_next <= read_sample;
				else
					sample_next(to_integer(i)) <= d_in;
					i_next <= (others => '0');
					state_next <= compute_error;
				end if;
			when compute_error =>
				
				err1_next <= result1;
				err2_next <= result2;
				err3_next <= result3;
				err4_next <= result4;
				if j < 643 then
					j_next <= j + 1;
					addr <= std_logic_vector(address1);
					address1_next <= unsigned(unsigned(address1) + 1);
					en <= '1';
					we <= '0';
					state_next <= read_ghost;
				else
					i_next <= (others => '0');
					state_next <= final_error;
				end if;
			when final_error =>
				err_out_next <= unsigned((unsigned(err1(127 downto 96)) + 
						 unsigned(err1(95 downto  64)) + 
						 unsigned(err1(63 downto  32)) + 
						 unsigned(err1(31 downto   0)) + 
						 unsigned(err2(127 downto 96)) + 
						 unsigned(err2(95 downto  64)) + 
						 unsigned(err2(63 downto  32)) + 
						 unsigned(err2(31 downto   0)) + 
						 unsigned(err3(127 downto 96)) + 
						 unsigned(err3(95 downto  64)) + 
						 unsigned(err3(63 downto  32)) + 
						 unsigned(err3(31 downto   0)) + 
						 unsigned(err4(127 downto 96)) + 
						 unsigned(err4(95 downto  64)) + 
						 unsigned(err4(63 downto  32)) + 
						 unsigned(err4(31 downto   0))));
				done <= '1';
				state_next <= finish;
			when finish	=>	
				if restart = '0' then
					done <= '1';
					state_next <= finish;
				else
					i_next <= (others => '0');
					state_next <= start;
				end if;
		end case;
	END PROCESS;
	
	in1 <= std_logic_vector(op1_res) & std_logic_vector(op2_res) & std_logic_vector(op3_res) & std_logic_vector(op4_res);
	in2 <= std_logic_vector(op5_res) & std_logic_vector(op6_res) & std_logic_vector(op7_res) & std_logic_vector(op8_res);
	in3 <= std_logic_vector(op9_res) & std_logic_vector(op10_res) & std_logic_vector(op11_res) & std_logic_vector(op12_res);
	in4 <= std_logic_vector(op13_res) & std_logic_vector(op14_res) & std_logic_vector(op15_res) & std_logic_vector(op16_res);
	
	

	ghost1 <= ghost(0);
	ghost2 <= ghost(1);
	ghost3 <= ghost(2);
	ghost4 <= ghost(3);
	sample1 <= sample(0);
	sample2 <= sample(1);
	sample3 <= sample(2);
	sample4 <= sample(3);
	
	op1 <= signed('0'& ghost1(31 downto 24)) - signed('0' & sample1(31 downto 24));
	op2 <= signed('0'& ghost1(23 downto 16)) - signed('0' & sample1(23 downto 16));
	op3 <= signed('0'& ghost1(15 downto  8)) - signed('0' & sample1(15 downto  8));
	op4 <= signed('0'& ghost1(7 downto   0)) - signed('0' & sample1(7 downto   0));
	
	op5 <= signed('0'& ghost2(31 downto 24)) - signed('0' & sample2(31 downto 24));
	op6 <= signed('0'& ghost2(23 downto 16)) - signed('0' & sample2(23 downto 16));
	op7 <= signed('0'& ghost2(15 downto  8)) - signed('0' & sample2(15 downto  8));
	op8 <= signed('0'& ghost2(7 downto   0)) - signed('0' & sample2(7 downto   0));
	
	op9 <= signed('0'& ghost3(31 downto 24)) - signed('0' & sample3(31 downto 24));
	op10 <= signed('0'& ghost3(23 downto 16)) - signed('0' & sample3(23 downto 16));
	op11 <= signed('0'& ghost3(15 downto  8)) - signed('0' & sample3(15 downto  8));
	op12 <= signed('0'& ghost3(7 downto   0)) - signed('0' & sample3(7 downto   0));
	
	op13 <= signed('0'& ghost4(31 downto 24)) - signed('0' & sample4(31 downto 24));
	op14 <= signed('0'& ghost4(23 downto 16)) - signed('0' & sample4(23 downto 16));
	op15 <= signed('0'& ghost4(15 downto  8)) - signed('0' & sample4(15 downto  8));
	op16 <= signed('0'& ghost4(7 downto   0)) - signed('0' & sample4(7 downto   0));
	
	op1_res <= resize(op1, 16);
	op2_res <= resize(op2, 16);
	op3_res <= resize(op3, 16);
	op4_res <= resize(op4, 16);
	op5_res <= resize(op5, 16);
	op6_res <= resize(op6, 16);
	op7_res <= resize(op7, 16);
	op8_res <= resize(op8, 16);
	op9_res <= resize(op9, 16);
	op10_res <= resize(op10, 16);
	op11_res <= resize(op11, 16);
	op12_res <= resize(op12, 16);
	op13_res <= resize(op13, 16);
	op14_res <= resize(op14, 16);
	op15_res <= resize(op15, 16);
	op16_res <= resize(op16, 16);
					
	tensor_core_1: TensorCore port map(a1 => in1,
									   a2 => in2,
									   a3 => in3,
									   a4 => in4,
									   b1 => in1,
									   b2 => in2,
									   b3 => in3,
									   b4 => in4,
									   c1 => err1,
									   c2 => err2,
									   c3 => err3,
									   c4 => err4,
									   d1 => result1,
									   d2 => result2,
									   d3 => result3,
									   d4 => result4);
END behavioural;