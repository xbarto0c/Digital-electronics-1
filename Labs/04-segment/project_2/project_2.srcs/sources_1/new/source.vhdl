----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.03.2021 00:49:43
-- Design Name: 
-- Module Name: source - Behavioral
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity source is
--  Port ( );
port(
        LED           : out  std_logic_vector(8 - 1 downto 0);
        SW			  : in  std_logic_vector(4 - 1 downto 0);
        AN            : out  std_logic_vector(8 - 1 downto 0)
    );
end source;

architecture Behavioral of source is
begin
    AN <= b"1111_0111";

    -- Display input value
    LED(3 downto 0) <= SW; -- do 4 spodních bitù SW
    -- Turn LED(4) on if input value is equal to 0, ie "0000"
    LED(4) <= '1' when SW = "0000" else '0';
    -- Turn LED(5) on if input value is greater than 9
    LED(5) <= '1' when (SW > "1001") else '0';
    -- Turn LED(6) on if input value is odd, ie 1, 3, 5, ...
    LED(6) <= '1' when (SW = "0001" or SW = "0011" or SW = "0101" or 
                        SW = "0111" or SW = "1001" or SW = "1011" or 
                        SW = "1101" or SW = "1111") 
                  else '0';
    -- Turn LED(7) on if input value is a power of two, ie 1, 2, 4, or 8
    LED(7) <= '1' when (SW = "0001" or SW = "0010" or SW = "0100" or 
                        SW = "1000") 
                  else '0';
end architecture Behavioral;
