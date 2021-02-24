----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.02.2021 13:13:03
-- Design Name: 
-- Module Name: comparator_2bit - Behavioral
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


library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------------------
-- Entity declaration for 4-bit binary comparator
------------------------------------------------------------------------
entity comparator_2bit is
    port(
        a_i           : in  std_logic_vector(2 - 1 downto 0);
        b_i			  : in  std_logic_vector(2 - 1 downto 0);
        -- vektor dvou vodicu

        B_less_A_o    : out std_logic;       -- B is less than A
        B_equals_A_o  : out std_logic;       -- B equals A
        B_greater_A_o : out std_logic       -- B is greater than A
    );
end entity comparator_2bit;

------------------------------------------------------------------------
-- Architecture body for 4-bit binary comparator
------------------------------------------------------------------------
architecture Behavioral of comparator_2bit is
begin

    B_less_A_o   <= '1' when (b_i < a_i) else '0';
    B_equals_A_o   <= '1' when (b_i = a_i) else '0';
    B_greater_A_o   <= '1' when (b_i > a_i) else '0';

end architecture Behavioral;
