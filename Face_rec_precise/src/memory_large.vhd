----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/03/2018 04:39:29 PM
-- Design Name: 
-- Module Name: memory_large - Behavioral
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

entity memory_large is
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
end memory_large;

architecture Behavioral of memory_large is
    type ram_t is array(2**15 downto 0) of std_logic_vector(31 downto 0);
    shared variable RAM: ram_t;
begin
    process(clk)
		
    begin
        if rising_edge(CLK) then
            if we_1 = '1' and en_1 = '1' then
                RAM(to_integer(unsigned(ADDR_1))) := DI_1;
             elsif en_1 = '1' then
                DO_1 <= RAM(to_integer(unsigned(ADDR_1)));
             end if;
        end if;
    end process;
    
    process(clk)
		variable m_line: line;
		variable str: string(1 to 19) :="Writing memory at: ";
        begin
            if rising_edge(CLK) then
                if we_2 = '1' and en_2 = '1' then
					write(m_line, str);
					writeline(output, m_line);
					write(m_line, to_integer(unsigned(ADDR_2)));
					writeline(output, m_line);
                    RAM(to_integer(unsigned(ADDR_2))) := DI_2;
                 elsif en_2 = '1' then
                    DO_2 <= RAM(to_integer(unsigned(ADDR_2)));
                 end if;
            end if;
        end process;
end Behavioral;
