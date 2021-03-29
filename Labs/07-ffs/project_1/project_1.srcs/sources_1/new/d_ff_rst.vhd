----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.03.2021 13:49:54
-- Design Name: 
-- Module Name: d_ff_arst - Behavioral
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

entity d_ff_rst is
    Port ( 
           rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           d : in STD_LOGIC;
           q : out STD_LOGIC;
           q_bar : out STD_LOGIC);
--  Port ( );
end d_ff_rst;

architecture Behavioral of d_ff_rst is

begin
    p_d_ff_rst : process (clk) -- arst resetuje hned, ne�ek� na hodiny
    begin
        if rising_edge(clk) then -- arst znamen� aktivn� v jedni�ce, arstn by bylo v nule
            if (rst = '1') then
                q <= '0';
                q_bar <= '1';
            else
                q <= d;
                q_bar <= not d;
            end if;
        end if;
    end process p_d_ff_rst;

end Behavioral;
