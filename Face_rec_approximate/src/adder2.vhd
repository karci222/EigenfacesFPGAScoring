LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;


ENTITY adder2 is
	PORT (opp_a, opp_b: in std_logic_vector(20 downto 0); 
			cin: in std_logic;
			result: out std_logic_vector(20 downto 0));
END adder2;



-- LOA size of 8 bits
ARCHITECTURE behaviour_9 OF adder2 IS
	signal res1: std_logic_vector(7 downto 0);
	signal res2: std_logic_vector(20 downto 8);
	signal res2_temp: std_logic_vector(20 downto 0);
	
COMPONENT full_adder IS
  port(op_a, op_b, c_in: in std_logic;
		sum, cout: out std_logic);
END COMPONENT;

SIGNAL c20, c19, c18, c17, c16, c15, c14, c13, c12, c11, c10, c9, c8, c7, c6, c5, c4, c3, c2, c1, c0: std_logic;

BEGIN
	bit20: full_adder port map(opp_a(20), opp_b(20), c19, res2(20), c20);
	bit19: full_adder port map(opp_a(19), opp_b(19), c18, res2(19), c19);
	bit18: full_adder port map(opp_a(18), opp_b(18), c17, res2(18), c18);
	bit17: full_adder port map(opp_a(17), opp_b(17), c16, res2(17), c17);
	bit16: full_adder port map(opp_a(16), opp_b(16), c15, res2(16), c16);
	bit15: full_adder port map(opp_a(15), opp_b(15), c14, res2(15), c15);
	bit14: full_adder port map(opp_a(14), opp_b(14), c13, res2(14), c14);
	bit13: full_adder port map(opp_a(13), opp_b(13), c12, res2(13), c13);
	bit12: full_adder port map(opp_a(12), opp_b(12), c11, res2(12), c12);
	bit11: full_adder port map(opp_a(11), opp_b(11), c10, res2(11), c11);
	bit10: full_adder port map(opp_a(10), opp_b(10), c9,  res2(10), c10);
	bit9:  full_adder port map(opp_a(9),  opp_b(9),  c8,  res2(9),  c9);
	bit8:  full_adder port map(opp_a(8),  opp_b(8),  c7,  res2(8),  c8);
	c7 <= opp_a(7) and opp_b(7);
	res1(7) <= opp_a(7) or opp_b(7);
	res1(6) <= opp_a(6) or opp_b(6);
	res1(5) <= opp_a(5) or opp_b(5);
	res1(4) <= opp_a(4) or opp_b(4);
	res1(3) <= opp_a(3) or opp_b(3);
	res1(2) <= opp_a(2) or opp_b(2);
	res1(1) <= opp_a(1) or opp_b(1);
	res1(0) <= opp_a(0) or opp_b(0);
	
	
	
	result <= res2 & res1;
END behaviour_9;

-- LOA size of 7 bits
ARCHITECTURE behaviour_1 OF adder2 IS
	signal res1: std_logic_vector(6 downto 0);
	signal res2: std_logic_vector(20 downto 7);
	signal res2_temp: std_logic_vector(20 downto 0);
	
COMPONENT full_adder IS
  port(op_a, op_b, c_in: in std_logic;
		sum, cout: out std_logic);
END COMPONENT;

SIGNAL c20, c19, c18, c17, c16, c15, c14, c13, c12, c11, c10, c9, c8, c7, c6, c5, c4, c3, c2, c1, c0: std_logic;

BEGIN
	bit20: full_adder port map(opp_a(20), opp_b(20), c19, res2(20), c20);
	bit19: full_adder port map(opp_a(19), opp_b(19), c18, res2(19), c19);
	bit18: full_adder port map(opp_a(18), opp_b(18), c17, res2(18), c18);
	bit17: full_adder port map(opp_a(17), opp_b(17), c16, res2(17), c17);
	bit16: full_adder port map(opp_a(16), opp_b(16), c15, res2(16), c16);
	bit15: full_adder port map(opp_a(15), opp_b(15), c14, res2(15), c15);
	bit14: full_adder port map(opp_a(14), opp_b(14), c13, res2(14), c14);
	bit13: full_adder port map(opp_a(13), opp_b(13), c12, res2(13), c13);
	bit12: full_adder port map(opp_a(12), opp_b(12), c11, res2(12), c12);
	bit11: full_adder port map(opp_a(11), opp_b(11), c10, res2(11), c11);
	bit10: full_adder port map(opp_a(10), opp_b(10), c9,  res2(10), c10);
	bit9:  full_adder port map(opp_a(9),  opp_b(9),  c8,  res2(9),  c9);
	bit8:  full_adder port map(opp_a(8),  opp_b(8),  c7,  res2(8),  c8);
	bit7:  full_adder port map(opp_a(7),  opp_b(7),  c6,  res2(7),  c7);
	c6 <= opp_a(6) and opp_b(6);
	res1(6) <= opp_a(6) or opp_b(6);
	res1(5) <= opp_a(5) or opp_b(5);
	res1(4) <= opp_a(4) or opp_b(4);
	res1(3) <= opp_a(3) or opp_b(3);
	res1(2) <= opp_a(2) or opp_b(2);
	res1(1) <= opp_a(1) or opp_b(1);
	res1(0) <= opp_a(0) or opp_b(0);
	
	
	
	result <= res2 & res1;
END behaviour_1;

-- LOA size of 6 bits
ARCHITECTURE behaviour_2 OF adder2 IS
	signal res1: std_logic_vector(5 downto 0);
	signal res2: std_logic_vector(20 downto 6);
	signal res2_temp: std_logic_vector(20 downto 0);
	
COMPONENT full_adder IS
  port(op_a, op_b, c_in: in std_logic;
		sum, cout: out std_logic);
END COMPONENT;

SIGNAL c20, c19, c18, c17, c16, c15, c14, c13, c12, c11, c10, c9, c8, c7, c6, c5, c4, c3, c2, c1, c0: std_logic;

BEGIN
	bit20: full_adder port map(opp_a(20), opp_b(20), c19, res2(20), c20);
	bit19: full_adder port map(opp_a(19), opp_b(19), c18, res2(19), c19);
	bit18: full_adder port map(opp_a(18), opp_b(18), c17, res2(18), c18);
	bit17: full_adder port map(opp_a(17), opp_b(17), c16, res2(17), c17);
	bit16: full_adder port map(opp_a(16), opp_b(16), c15, res2(16), c16);
	bit15: full_adder port map(opp_a(15), opp_b(15), c14, res2(15), c15);
	bit14: full_adder port map(opp_a(14), opp_b(14), c13, res2(14), c14);
	bit13: full_adder port map(opp_a(13), opp_b(13), c12, res2(13), c13);
	bit12: full_adder port map(opp_a(12), opp_b(12), c11, res2(12), c12);
	bit11: full_adder port map(opp_a(11), opp_b(11), c10, res2(11), c11);
	bit10: full_adder port map(opp_a(10), opp_b(10), c9,  res2(10), c10);
	bit9:  full_adder port map(opp_a(9),  opp_b(9),  c8,  res2(9),  c9);
	bit8:  full_adder port map(opp_a(8),  opp_b(8),  c7,  res2(8),  c8);
	bit7:  full_adder port map(opp_a(7),  opp_b(7),  c6,  res2(7),  c7);
	bit6:  full_adder port map(opp_a(6),  opp_b(6),  c5,  res2(6),  c6);
	c5 <= opp_a(5);
	res1(5) <= opp_b(5);
	res1(4) <= opp_b(4);
	res1(3) <= opp_b(3);
	res1(2) <= opp_b(2);
	res1(1) <= opp_b(1);
	res1(0) <= opp_b(0);
	
	result <= res2 & res1;
END behaviour_2;

-- LOA size of 5 bits
ARCHITECTURE behaviour_3 OF adder2 IS
	signal res1: std_logic_vector(4 downto 0);
	signal res2: std_logic_vector(20 downto 5);
	signal res2_temp: std_logic_vector(20 downto 0);
	
COMPONENT full_adder IS
  port(op_a, op_b, c_in: in std_logic;
		sum, cout: out std_logic);
END COMPONENT;

SIGNAL c20, c19, c18, c17, c16, c15, c14, c13, c12, c11, c10, c9, c8, c7, c6, c5, c4, c3, c2, c1, c0: std_logic;

BEGIN
	bit20: full_adder port map(opp_a(20), opp_b(20), c19, res2(20), c20);
	bit19: full_adder port map(opp_a(19), opp_b(19), c18, res2(19), c19);
	bit18: full_adder port map(opp_a(18), opp_b(18), c17, res2(18), c18);
	bit17: full_adder port map(opp_a(17), opp_b(17), c16, res2(17), c17);
	bit16: full_adder port map(opp_a(16), opp_b(16), c15, res2(16), c16);
	bit15: full_adder port map(opp_a(15), opp_b(15), c14, res2(15), c15);
	bit14: full_adder port map(opp_a(14), opp_b(14), c13, res2(14), c14);
	bit13: full_adder port map(opp_a(13), opp_b(13), c12, res2(13), c13);
	bit12: full_adder port map(opp_a(12), opp_b(12), c11, res2(12), c12);
	bit11: full_adder port map(opp_a(11), opp_b(11), c10, res2(11), c11);
	bit10: full_adder port map(opp_a(10), opp_b(10), c9,  res2(10), c10);
	bit9:  full_adder port map(opp_a(9),  opp_b(9),  c8,  res2(9),  c9);
	bit8:  full_adder port map(opp_a(8),  opp_b(8),  c7,  res2(8),  c8);
	bit7:  full_adder port map(opp_a(7),  opp_b(7),  c6,  res2(7),  c7);
	bit6:  full_adder port map(opp_a(6),  opp_b(6),  c5,  res2(6),  c6);
	bit5:  full_adder port map(opp_a(5),  opp_b(5),  c4,  res2(5),  c5);
	c4 <= opp_a(4) and opp_b(4);
	res1(4) <= opp_a(4) or opp_b(4);
	res1(3) <= opp_a(3) or opp_b(3);
	res1(2) <= opp_a(2) or opp_b(2);
	res1(1) <= opp_a(1) or opp_b(1);
	res1(0) <= opp_a(0) or opp_b(0);
	
	result <= res2 & res1;
END behaviour_3;


-- LOA size of 4 bits
ARCHITECTURE behaviour_4 OF adder2 IS
	signal res1: std_logic_vector(3 downto 0);
	signal res2: std_logic_vector(20 downto 4);
	signal res2_temp: std_logic_vector(20 downto 0);
	
COMPONENT full_adder IS
  port(op_a, op_b, c_in: in std_logic;
		sum, cout: out std_logic);
END COMPONENT;

SIGNAL c20, c19, c18, c17, c16, c15, c14, c13, c12, c11, c10, c9, c8, c7, c6, c5, c4, c3, c2, c1, c0: std_logic;

BEGIN
	bit20: full_adder port map(opp_a(20), opp_b(20), c19, res2(20), c20);
	bit19: full_adder port map(opp_a(19), opp_b(19), c18, res2(19), c19);
	bit18: full_adder port map(opp_a(18), opp_b(18), c17, res2(18), c18);
	bit17: full_adder port map(opp_a(17), opp_b(17), c16, res2(17), c17);
	bit16: full_adder port map(opp_a(16), opp_b(16), c15, res2(16), c16);
	bit15: full_adder port map(opp_a(15), opp_b(15), c14, res2(15), c15);
	bit14: full_adder port map(opp_a(14), opp_b(14), c13, res2(14), c14);
	bit13: full_adder port map(opp_a(13), opp_b(13), c12, res2(13), c13);
	bit12: full_adder port map(opp_a(12), opp_b(12), c11, res2(12), c12);
	bit11: full_adder port map(opp_a(11), opp_b(11), c10, res2(11), c11);
	bit10: full_adder port map(opp_a(10), opp_b(10), c9,  res2(10), c10);
	bit9:  full_adder port map(opp_a(9),  opp_b(9),  c8,  res2(9),  c9);
	bit8:  full_adder port map(opp_a(8),  opp_b(8),  c7,  res2(8),  c8);
	bit7:  full_adder port map(opp_a(7),  opp_b(7),  c6,  res2(7),  c7);
	bit6:  full_adder port map(opp_a(6),  opp_b(6),  c5,  res2(6),  c6);
	bit5:  full_adder port map(opp_a(5),  opp_b(5),  c4,  res2(5),  c5);
	bit4:  full_adder port map(opp_a(4),  opp_b(4),  c3,  res2(4),  c4);
	c3 <= opp_a(3) and opp_b(3);
	res1(3) <= opp_a(3) or opp_b(3);
	res1(2) <= opp_a(2) or opp_b(2);
	res1(1) <= opp_a(1) or opp_b(1);
	res1(0) <= opp_a(0) or opp_b(0);
	
	
	
	result <= res2 & res1;
END behaviour_4;

-- LOA size of 3 bits
ARCHITECTURE behaviour_5 OF adder2 IS
	signal res1: std_logic_vector(2 downto 0);
	signal res2: std_logic_vector(20 downto 3);
	signal res2_temp: std_logic_vector(20 downto 0);
	
COMPONENT full_adder IS
  port(op_a, op_b, c_in: in std_logic;
		sum, cout: out std_logic);
END COMPONENT;

SIGNAL c20, c19, c18, c17, c16, c15, c14, c13, c12, c11, c10, c9, c8, c7, c6, c5, c4, c3, c2, c1, c0: std_logic;

BEGIN
	bit20: full_adder port map(opp_a(20), opp_b(20), c19, res2(20), c20);
	bit19: full_adder port map(opp_a(19), opp_b(19), c18, res2(19), c19);
	bit18: full_adder port map(opp_a(18), opp_b(18), c17, res2(18), c18);
	bit17: full_adder port map(opp_a(17), opp_b(17), c16, res2(17), c17);
	bit16: full_adder port map(opp_a(16), opp_b(16), c15, res2(16), c16);
	bit15: full_adder port map(opp_a(15), opp_b(15), c14, res2(15), c15);
	bit14: full_adder port map(opp_a(14), opp_b(14), c13, res2(14), c14);
	bit13: full_adder port map(opp_a(13), opp_b(13), c12, res2(13), c13);
	bit12: full_adder port map(opp_a(12), opp_b(12), c11, res2(12), c12);
	bit11: full_adder port map(opp_a(11), opp_b(11), c10, res2(11), c11);
	bit10: full_adder port map(opp_a(10), opp_b(10), c9,  res2(10), c10);
	bit9:  full_adder port map(opp_a(9),  opp_b(9),  c8,  res2(9),  c9);
	bit8:  full_adder port map(opp_a(8),  opp_b(8),  c7,  res2(8),  c8);
	bit7:  full_adder port map(opp_a(7),  opp_b(7),  c6,  res2(7),  c7);
	bit6:  full_adder port map(opp_a(6),  opp_b(6),  c5,  res2(6),  c6);
	bit5:  full_adder port map(opp_a(5),  opp_b(5),  c4,  res2(5),  c5);
	bit4:  full_adder port map(opp_a(4),  opp_b(4),  c3,  res2(4),  c4);
	bit3:  full_adder port map(opp_a(3),  opp_b(3),  c2,  res2(3),  c3);
	c2 <= opp_a(2) and opp_b(2);
	res1(2) <= opp_a(2) or opp_b(2);
	res1(1) <= opp_a(1) or opp_b(1);
	res1(0) <= opp_a(0) or opp_b(0);
	
	result <= res2 & res1;
END behaviour_5;

-- LOA size of 2 bits
ARCHITECTURE behaviour_6 OF adder2 IS
	signal res1: std_logic_vector(1 downto 0);
	signal res2: std_logic_vector(20 downto 2);
	signal res2_temp: std_logic_vector(20 downto 0);
	
COMPONENT full_adder IS
  port(op_a, op_b, c_in: in std_logic;
		sum, cout: out std_logic);
END COMPONENT;

SIGNAL c20, c19, c18, c17, c16, c15, c14, c13, c12, c11, c10, c9, c8, c7, c6, c5, c4, c3, c2, c1, c0: std_logic;

BEGIN
	bit20: full_adder port map(opp_a(20), opp_b(20), c19, res2(20), c20);
	bit19: full_adder port map(opp_a(19), opp_b(19), c18, res2(19), c19);
	bit18: full_adder port map(opp_a(18), opp_b(18), c17, res2(18), c18);
	bit17: full_adder port map(opp_a(17), opp_b(17), c16, res2(17), c17);
	bit16: full_adder port map(opp_a(16), opp_b(16), c15, res2(16), c16);
	bit15: full_adder port map(opp_a(15), opp_b(15), c14, res2(15), c15);
	bit14: full_adder port map(opp_a(14), opp_b(14), c13, res2(14), c14);
	bit13: full_adder port map(opp_a(13), opp_b(13), c12, res2(13), c13);
	bit12: full_adder port map(opp_a(12), opp_b(12), c11, res2(12), c12);
	bit11: full_adder port map(opp_a(11), opp_b(11), c10, res2(11), c11);
	bit10: full_adder port map(opp_a(10), opp_b(10), c9,  res2(10), c10);
	bit9:  full_adder port map(opp_a(9),  opp_b(9),  c8,  res2(9),  c9);
	bit8:  full_adder port map(opp_a(8),  opp_b(8),  c7,  res2(8),  c8);
	bit7:  full_adder port map(opp_a(7),  opp_b(7),  c6,  res2(7),  c7);
	bit6:  full_adder port map(opp_a(6),  opp_b(6),  c5,  res2(6),  c6);
	bit5:  full_adder port map(opp_a(5),  opp_b(5),  c4,  res2(5),  c5);
	bit4:  full_adder port map(opp_a(4),  opp_b(4),  c3,  res2(4),  c4);
	bit3:  full_adder port map(opp_a(3),  opp_b(3),  c2,  res2(3),  c3);
	bit2:  full_adder port map(opp_a(2),  opp_b(2),  c1,  res2(2),  c2);
	c1 <= opp_a(1) and opp_b(1);
	res1(1) <= opp_a(1) or opp_b(1);
	res1(0) <= opp_a(0) or opp_b(0);
	
	result <= res2 & res1;
END behaviour_6;

-- LOA size of 1 bit
ARCHITECTURE behaviour_7 OF adder2 IS
	signal res1: std_logic;
	signal res2: std_logic_vector(20 downto 1);
	signal res2_temp: std_logic_vector(20 downto 0);
	
COMPONENT full_adder IS
  port(op_a, op_b, c_in: in std_logic;
		sum, cout: out std_logic);
END COMPONENT;

SIGNAL c20, c19, c18, c17, c16, c15, c14, c13, c12, c11, c10, c9, c8, c7, c6, c5, c4, c3, c2, c1, c0: std_logic;

BEGIN
	bit20: full_adder port map(opp_a(20), opp_b(20), c19, res2(20), c20);
	bit19: full_adder port map(opp_a(19), opp_b(19), c18, res2(19), c19);
	bit18: full_adder port map(opp_a(18), opp_b(18), c17, res2(18), c18);
	bit17: full_adder port map(opp_a(17), opp_b(17), c16, res2(17), c17);
	bit16: full_adder port map(opp_a(16), opp_b(16), c15, res2(16), c16);
	bit15: full_adder port map(opp_a(15), opp_b(15), c14, res2(15), c15);
	bit14: full_adder port map(opp_a(14), opp_b(14), c13, res2(14), c14);
	bit13: full_adder port map(opp_a(13), opp_b(13), c12, res2(13), c13);
	bit12: full_adder port map(opp_a(12), opp_b(12), c11, res2(12), c12);
	bit11: full_adder port map(opp_a(11), opp_b(11), c10, res2(11), c11);
	bit10: full_adder port map(opp_a(10), opp_b(10), c9,  res2(10), c10);
	bit9:  full_adder port map(opp_a(9),  opp_b(9),  c8,  res2(9),  c9);
	bit8:  full_adder port map(opp_a(8),  opp_b(8),  c7,  res2(8),  c8);
	bit7:  full_adder port map(opp_a(7),  opp_b(7),  c6,  res2(7),  c7);
	bit6:  full_adder port map(opp_a(6),  opp_b(6),  c5,  res2(6),  c6);
	bit5:  full_adder port map(opp_a(5),  opp_b(5),  c4,  res2(5),  c5);
	bit4:  full_adder port map(opp_a(4),  opp_b(4),  c3,  res2(4),  c4);
	bit3:  full_adder port map(opp_a(3),  opp_b(3),  c2,  res2(3),  c3);
	bit2:  full_adder port map(opp_a(2),  opp_b(2),  c1,  res2(2),  c2);
	bit1:  full_adder port map(opp_a(1),  opp_b(1),  c0,  res2(1),  c1);
	c0 <= opp_a(0) and opp_b(0);
	res1 <= opp_a(0) or opp_b(0);
	
	result <= res2 & res1;
END behaviour_7;

-- Exact adder
ARCHITECTURE behaviour_8 OF adder2 IS
	signal res2: std_logic_vector(20 downto 0);
	signal res2_temp: std_logic_vector(20 downto 0);
	
COMPONENT full_adder IS
  port(op_a, op_b, c_in: in std_logic;
		sum, cout: out std_logic);
END COMPONENT;

SIGNAL c20, c19, c18, c17, c16, c15, c14, c13, c12, c11, c10, c9, c8, c7, c6, c5, c4, c3, c2, c1, c0: std_logic;

BEGIN
	bit20: full_adder port map(opp_a(20), opp_b(20), c19, res2(20), c20);
	bit19: full_adder port map(opp_a(19), opp_b(19), c18, res2(19), c19);
	bit18: full_adder port map(opp_a(18), opp_b(18), c17, res2(18), c18);
	bit17: full_adder port map(opp_a(17), opp_b(17), c16, res2(17), c17);
	bit16: full_adder port map(opp_a(16), opp_b(16), c15, res2(16), c16);
	bit15: full_adder port map(opp_a(15), opp_b(15), c14, res2(15), c15);
	bit14: full_adder port map(opp_a(14), opp_b(14), c13, res2(14), c14);
	bit13: full_adder port map(opp_a(13), opp_b(13), c12, res2(13), c13);
	bit12: full_adder port map(opp_a(12), opp_b(12), c11, res2(12), c12);
	bit11: full_adder port map(opp_a(11), opp_b(11), c10, res2(11), c11);
	bit10: full_adder port map(opp_a(10), opp_b(10), c9,  res2(10), c10);
	bit9:  full_adder port map(opp_a(9),  opp_b(9),  c8,  res2(9),  c9);
	bit8:  full_adder port map(opp_a(8),  opp_b(8),  c7,  res2(8),  c8);
	bit7:  full_adder port map(opp_a(7),  opp_b(7),  c6,  res2(7),  c7);
	bit6:  full_adder port map(opp_a(6),  opp_b(6),  c5,  res2(6),  c6);
	bit5:  full_adder port map(opp_a(5),  opp_b(5),  c4,  res2(5),  c5);
	bit4:  full_adder port map(opp_a(4),  opp_b(4),  c3,  res2(4),  c4);
	bit3:  full_adder port map(opp_a(3),  opp_b(3),  c2,  res2(3),  c3);
	bit2:  full_adder port map(opp_a(2),  opp_b(2),  c1,  res2(2),  c2);
	bit1:  full_adder port map(opp_a(1),  opp_b(1),  c0,  res2(1),  c1);
	bit0:  full_adder port map(opp_a(0),  opp_b(0),  cin, res2(0),  c0);

	result <= res2 ;
END behaviour_8;