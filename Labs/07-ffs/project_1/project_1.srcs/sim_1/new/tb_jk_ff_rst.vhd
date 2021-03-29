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

entity tb_jk_ff_rst is
--  Port ( );
end tb_jk_ff_rst;

architecture Behavioral of tb_jk_ff_rst is
           constant c_CLK_100MHZ_PERIOD : time  := 10 ns; 
           
           signal s_rst : STD_LOGIC;
           signal s_clk : STD_LOGIC;
           signal s_j : STD_LOGIC;
           signal s_k : STD_LOGIC;
           signal s_q : STD_LOGIC;
           signal s_q_bar : STD_LOGIC;

begin
    uut_jk_ff_rst : entity work.jk_ff_rst
        port map(
            rst =>  s_rst,
            clk => s_clk, 
            j => s_j, 
            k => s_k, 
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
                s_rst <= '0';
                wait for 83ns;
                s_rst <= '1';
                wait for 15ns;
                s_rst <= '0';
                
                wait for 108ns;
                s_rst <= '1';
                wait;
        end process p_reset;
        p_jk_ff_rst : process
            begin
                report "Stimulus process started" severity note;
                s_j <= '0';
                s_k <= '0';
                
                --d sekvence
                wait for 13ns;
                s_j <= '0';
                s_k <= '1';
                wait for 10ns;
                s_j <= '1';
                s_k <= '0';
                wait for 10ns;
                s_j <= '1';
                s_k <= '1';
                wait for 10ns;
                s_j <= '0';
                s_k <= '0';
                wait for 10ns;
               

                
                wait for 3ns;
                assert(s_q = '0' and s_q_bar = '1')
                report "Error at s_j = 0 and s_k = 0" severity error; -- zde nebo v èasovanéém separátním procesu

                --d sekvence
                wait for 13ns;
                s_j <= '0';
                s_k <= '1';
                assert(s_q = '1' and s_q_bar = '0')
                report "Error at s_j = 0 and s_k = 1" severity error;
                wait for 10ns;
                s_j <= '1';
                s_k <= '0';
                wait for 10ns;
                s_j <= '1';
                s_k <= '1';
                wait for 10ns;
                s_j <= '0';
                s_k <= '0';
                wait for 10ns;
                

                
                wait for 3ns;
                --d sekvence
                wait for 13ns;
                s_j <= '0';
                s_k <= '1';
                wait for 10ns;
                s_j <= '1';
                s_k <= '0';
                wait for 10ns;
                s_j <= '1';
                s_k <= '1';
                wait for 10ns;
                s_j <= '0';
                s_k <= '0';
                wait for 10ns;
            
                wait for 3ns;
                
                
                report "Stimulus process finished" severity note;
                wait; 
            end process p_jk_ff_rst;

end Behavioral;
