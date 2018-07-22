----------------------------
-- Author: Karol Marso
-- Title: Tensor core
-- Description: ...
---------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use IEEE.numeric_std.all;

ENTITY TensorCore IS
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
END TensorCore;

ARCHITECTURE Behavioural_core of TensorCore IS
  SIGNAL opa11, opa12, opa13, opa14: std_logic_vector(15 downto 0);
  SIGNAL opa21, opa22, opa23, opa24: std_logic_vector(15 downto 0);
  SIGNAL opa31, opa32, opa33, opa34: std_logic_vector(15 downto 0);
  SIGNAL opa41, opa42, opa43, opa44: std_logic_vector(15 downto 0);
  SIGNAL opb11, opb12, opb13, opb14: std_logic_vector(15 downto 0);
  SIGNAL opb21, opb22, opb23, opb24: std_logic_vector(15 downto 0);
  SIGNAL opb31, opb32, opb33, opb34: std_logic_vector(15 downto 0);
  SIGNAL opb41, opb42, opb43, opb44: std_logic_vector(15 downto 0);
  SIGNAL opc11, opc12, opc13, opc14: std_logic_vector(31 downto 0);
  SIGNAL opc21, opc22, opc23, opc24: std_logic_vector(31 downto 0);
  SIGNAL opc31, opc32, opc33, opc34: std_logic_vector(31 downto 0);
  SIGNAL opc41, opc42, opc43, opc44: std_logic_vector(31 downto 0);
  SIGNAL opd11, opd12, opd13, opd14: std_logic_vector(31 downto 0);
  SIGNAL opd21, opd22, opd23, opd24: std_logic_vector(31 downto 0);
  SIGNAL opd31, opd32, opd33, opd34: std_logic_vector(31 downto 0);
  SIGNAL opd41, opd42, opd43, opd44: std_logic_vector(31 downto 0);
  SIGNAL d11, d12, d13, d14: std_logic_vector(31 downto 0);
  SIGNAL d21, d22, d23, d24: std_logic_vector(31 downto 0);
  SIGNAL d31, d32, d33, d34: std_logic_vector(31 downto 0);
  SIGNAL d41, d42, d43, d44: std_logic_vector(31 downto 0);
  
BEGIN
	opa11 <= a1(63 downto 48);
	opa12 <= a1(47 downto 32);
	opa13 <= a1(31 downto 16);
	opa14 <= a1(15 downto  0);

	opa21 <= a2(63 downto 48);
	opa22 <= a2(47 downto 32);
	opa23 <= a2(31 downto 16);
	opa24 <= a2(15 downto  0);

	opa31 <= a3(63 downto 48);
	opa32 <= a3(47 downto 32);
	opa33 <= a3(31 downto 16);
	opa34 <= a3(15 downto  0);

	opa41 <= a4(63 downto 48);
	opa42 <= a4(47 downto 32);
	opa43 <= a4(31 downto 16);
	opa44 <= a4(15 downto  0);

	opb11 <= b1(63 downto 48);
	opb12 <= b1(47 downto 32);
	opb13 <= b1(31 downto 16);
	opb14 <= b1(15 downto  0);

	opb21 <= b2(63 downto 48);
	opb22 <= b2(47 downto 32);
	opb23 <= b2(31 downto 16);
	opb24 <= b2(15 downto  0);

	opb31 <= b3(63 downto 48);
	opb32 <= b3(47 downto 32);
	opb33 <= b3(31 downto 16);
	opb34 <= b3(15 downto  0);

	opb41 <= b4(63 downto 48);
	opb42 <= b4(47 downto 32);
	opb43 <= b4(31 downto 16);
	opb44 <= b4(15 downto  0);

	opc11 <= c1(127 downto 96);
	opc12 <= c1(95  downto 64);
	opc13 <= c1(63  downto 32);
	opc14 <= c1(31  downto  0);
	
	opc21 <= c2(127 downto 96);
	opc22 <= c2(95  downto 64);
	opc23 <= c2(63  downto 32);
	opc24 <= c2(31  downto  0);
	
	opc31 <= c3(127 downto 96);
	opc32 <= c3(95  downto 64);
	opc33 <= c3(63  downto 32);
	opc34 <= c3(31  downto  0);
	
	opc41 <= c4(127 downto 96);
	opc42 <= c4(95  downto 64);
	opc43 <= c4(63  downto 32);
	opc44 <= c4(31  downto  0);
	
	d11 <= std_logic_vector((signed(opa11) * signed(opb11)) + signed(opc11));
	d12 <= std_logic_vector((signed(opa12) * signed(opb12)) + signed(opc12));
	d13 <= std_logic_vector((signed(opa13) * signed(opb13)) + signed(opc13));
	d14 <= std_logic_vector((signed(opa14) * signed(opb14)) + signed(opc14));
	
	d21 <= std_logic_vector((signed(opa21) * signed(opb21)) + signed(opc21));
	d22 <= std_logic_vector((signed(opa22) * signed(opb22)) + signed(opc22));
	d23 <= std_logic_vector((signed(opa23) * signed(opb23)) + signed(opc23));
	d24 <= std_logic_vector((signed(opa24) * signed(opb24)) + signed(opc24));
	
	d31 <= std_logic_vector((signed(opa31) * signed(opb31)) + signed(opc31));
	d32 <= std_logic_vector((signed(opa32) * signed(opb32)) + signed(opc32));
	d33 <= std_logic_vector((signed(opa33) * signed(opb33)) + signed(opc33));
	d34 <= std_logic_vector((signed(opa34) * signed(opb34)) + signed(opc34));
	
	d41 <= std_logic_vector((signed(opa41) * signed(opb41)) + signed(opc41));
	d42 <= std_logic_vector((signed(opa42) * signed(opb42)) + signed(opc42));
	d43 <= std_logic_vector((signed(opa43) * signed(opb43)) + signed(opc43));
	d44 <= std_logic_vector((signed(opa44) * signed(opb44)) + signed(opc44));
	
	d1 <= d11 & d12 & d13 & d14;
	d2 <= d21 & d22 & d23 & d24;
	d3 <= d31 & d32 & d33 & d34;
	d4 <= d41 & d42 & d43 & d44;
END Behavioural_core;