LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;


ENTITY full_adder IS
  port(op_a, op_b, c_in: in std_logic;
		sum, cout: out std_logic);
END full_adder;

ARCHITECTURE beh_full_adder OF full_adder IS
  
BEGIN
	sum <= op_a xor op_b xor c_in;
	cout <= (op_a and op_b) or (c_in and op_a) or (c_in and op_b);
END beh_full_adder;