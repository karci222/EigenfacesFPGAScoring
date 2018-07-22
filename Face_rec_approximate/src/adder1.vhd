LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;


ENTITY adder1 is
	PORT (opp_a, opp_b: in std_logic_vector(8 downto 0); 
			cin: in std_logic;
			result: out std_logic_vector(8 downto 0));
END adder1;


-- LOA size of 6 bits
ARCHITECTURE behaviour_2 OF adder1 IS
	signal res1: std_logic_vector(5 downto 0);
	signal res2: std_logic_vector(8 downto 6);
	signal res2_temp: std_logic_vector(8 downto 0);
	
COMPONENT full_adder IS
  port(op_a, op_b, c_in: in std_logic;
		sum, cout: out std_logic);
END COMPONENT;

SIGNAL c8, c7, c6, c5, c4, c3, c2, c1, c0: std_logic;

BEGIN
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
ARCHITECTURE behaviour_3 OF adder1 IS
	signal res1: std_logic_vector(4 downto 0);
	signal res2: std_logic_vector(8 downto 5);
	signal res2_temp: std_logic_vector(8 downto 0);
	
COMPONENT full_adder IS
  port(op_a, op_b, c_in: in std_logic;
		sum, cout: out std_logic);
END COMPONENT;

SIGNAL c8, c7, c6, c5, c4, c3, c2, c1, c0: std_logic;

BEGIN
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
ARCHITECTURE behaviour_4 OF adder1 IS
	signal res1: std_logic_vector(3 downto 0);
	signal res2: std_logic_vector(8 downto 4);
	signal res2_temp: std_logic_vector(8 downto 0);
	
COMPONENT full_adder IS
  port(op_a, op_b, c_in: in std_logic;
		sum, cout: out std_logic);
END COMPONENT;

SIGNAL c8, c7, c6, c5, c4, c3, c2, c1, c0: std_logic;

BEGIN
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
ARCHITECTURE behaviour_5 OF adder1 IS
	signal res1: std_logic_vector(2 downto 0);
	signal res2: std_logic_vector(8 downto 3);
	signal res2_temp: std_logic_vector(8 downto 0);
	
COMPONENT full_adder IS
  port(op_a, op_b, c_in: in std_logic;
		sum, cout: out std_logic);
END COMPONENT;

SIGNAL c8, c7, c6, c5, c4, c3, c2, c1, c0: std_logic;

BEGIN
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
ARCHITECTURE behaviour_6 OF adder1 IS
	signal res1: std_logic_vector(1 downto 0);
	signal res2: std_logic_vector(8 downto 2);
	signal res2_temp: std_logic_vector(8 downto 0);
	
COMPONENT full_adder IS
  port(op_a, op_b, c_in: in std_logic;
		sum, cout: out std_logic);
END COMPONENT;

SIGNAL c8, c7, c6, c5, c4, c3, c2, c1, c0: std_logic;

BEGIN
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
ARCHITECTURE behaviour_7 OF adder1 IS
	signal res1: std_logic;
	signal res2: std_logic_vector(8 downto 1);
	signal res2_temp: std_logic_vector(8 downto 0);
	
COMPONENT full_adder IS
  port(op_a, op_b, c_in: in std_logic;
		sum, cout: out std_logic);
END COMPONENT;

SIGNAL c8, c7, c6, c5, c4, c3, c2, c1, c0: std_logic;

BEGIN
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
