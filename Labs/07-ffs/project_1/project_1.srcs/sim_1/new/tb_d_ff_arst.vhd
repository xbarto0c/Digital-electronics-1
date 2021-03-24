----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.03.2021 13:54:39
-- Design Name: 
-- Module Name: tb_d_ff_arst - Behavioral
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

entity tb_d_ff_arst is
--  Port ( );
end tb_d_ff_arst;

architecture Behavioral of tb_d_ff_arst is
           constant c_CLK_100MHZ_PERIOD : time  := 10 ns; 
           
           signal s_arst : STD_LOGIC;
           signal s_clk : STD_LOGIC;
           signal s_d : STD_LOGIC;
           signal s_q : STD_LOGIC;
           signal s_q_bar : STD_LOGIC;

begin
    uut_d_latch : entity work.d_ff_arst
        port map(
            arst =>  s_arst,
            clk => s_clk, 
            d => s_d, 
            q => s_q, 
            q_bar => s_q_bar  
        );
        p_clk_gen : process
        begin
            while now < 750 ns loop         -- 75 periods of 100MHz clock
                s_clk <= '0';
                wait for c_CLK_100MHZ_PERIOD / 2;
                s_clk <= '1';
                wait for c_CLK_100MHZ_PERIOD / 2;
            end loop; 
            wait; 
        end process p_clk_gen;
         p_reset : process --mohlo by být i v procesu latche, ne s hodinovým signálem
            begin
                s_arst <= '0';
                wait for 58ns;
                s_arst <= '1';
                wait for 15ns;
                s_arst <= '0';
                
                wait for 108ns;
                s_arst <= '1';
                wait;
        end process p_reset;
        p_d_latch : process
            begin
                report "Stimulus process started" severity note;
                s_d <= '0';
                
                --d sekvence
                wait for 13ns;
                s_d <= '1';
                wait for 10ns;
                s_d <= '0';
                wait for 10ns;
                s_d <= '1';
                wait for 10ns;
                s_d <= '0';
                wait for 10ns;
                s_d <= '1';

                
                wait for 3ns;
                assert(s_q = '0' and s_q_bar = '1')
                report "Error wole" severity error; -- zde nebo v èasovanéém separátním procesu
                --pøidat asserty a smazat Error wole !!!
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
