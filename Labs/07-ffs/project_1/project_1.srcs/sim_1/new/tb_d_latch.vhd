----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.03.2021 13:21:23
-- Design Name: 
-- Module Name: tb_d_latch - Behavioral
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

entity tb_d_latch is
--  Port ( );
end tb_d_latch;

architecture Behavioral of tb_d_latch is
           signal s_arst : STD_LOGIC;
           signal s_en : STD_LOGIC;
           signal s_d : STD_LOGIC;
           signal s_q : STD_LOGIC;
           signal s_q_bar : STD_LOGIC;

begin
    uut_d_latch : entity work.d_latch
        port map(
            arst =>  s_arst,
            en => s_en, 
            d => s_d, 
            q => s_q, 
            q_bar => s_q_bar  
        );
         p_reset : process --mohlo by být i v procesu latche, ne s hodinovým signálem
            begin
                s_arst <= '0';
                wait for 53ns;
                s_arst <= '1';
                wait for 5ns;
                s_arst <= '0';
                
                wait for 108ns;
                s_arst <= '1';
                wait;
        end process p_reset;
        p_d_latch : process
            begin
                report "Stimulus process started" severity note;
                s_en <= '0';
                s_d <= '0';
                
                --d sekvence
                wait for 10ns;
                s_d <= '1';
                wait for 10ns;
                s_d <= '0';
                wait for 10ns;
                s_d <= '1';
                wait for 10ns;
                s_d <= '0';
                wait for 10ns;
                s_d <= '1';

                s_en <= '1';
                
                wait for 3ns;
                assert(s_q = '0' and s_q_bar = '1')
                report "Error at s_d = '1' " severity error;
                --d sekvence
                wait for 10ns;
                s_d <= '1';
                wait for 10ns;
                s_d <= '0';
                wait for 10ns;
                assert(s_q = '1' and s_q_bar = '0')
                report "Error at s_d = '0'" severity error;
                s_d <= '1';
                wait for 10ns;
                s_d <= '0';
                wait for 10ns;
                s_d <= '1';
                wait for 10ns;
                s_d <= '0';
                --d sekvence
                wait for 10ns;
                s_d <= '1';
                wait for 10ns;
                s_d <= '0';
                wait for 10ns;
                s_d <= '1';
                wait for 10ns;
                s_d <= '0';
                wait for 10ns;
                s_d <= '1';
                wait for 10ns;
                s_d <= '0';
                
                
                report "Stimulus process finished" severity note;
                wait; 
            end process p_d_latch;

end Behavioral;
