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

entity tb_t_ff_rst is
--  Port ( );
end tb_t_ff_rst;

architecture Behavioral of tb_t_ff_rst is
           constant c_CLK_100MHZ_PERIOD : time  := 10 ns; 
           
           signal s_rst : STD_LOGIC;
           signal s_clk : STD_LOGIC;
           signal s_t : STD_LOGIC;
           signal s_q : STD_LOGIC;
           signal s_q_bar : STD_LOGIC;

begin
    uut_t_ff_rst : entity work.t_ff_rst
        port map(
            rst =>  s_rst,
            clk => s_clk, 
            t => s_t, 
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
         p_reset : process --mohlo by b�t i v procesu latche, ne s hodinov�m sign�lem
            begin
                s_rst <= '0';
                wait for 8ns;
                s_rst <= '1';
                wait for 36ns;
                s_rst <= '0';
                
                wait for 51ns;
                s_rst <= '1';
                wait for 37ns;
                
                s_rst <= '0';
                
                wait for 148ns;
                s_rst <= '1';
                wait;
        end process p_reset;
        p_t_ff_rst : process
            begin
                report "Stimulus process started" severity note;
                s_t <= '0';
                
                --d sekvence
                wait for 13ns;
                s_t <= '1';
                wait for 10ns;
                s_t <= '0';
                wait for 10ns;
                s_t <= '1';
                wait for 10ns;
                s_t <= '0';
                wait for 10ns;
                s_t <= '1';

                
                wait for 3ns;
                assert(s_q = '0' and s_q_bar = '1')
                report "Error at s_t = 1" severity error; -- zde nebo v �asovan��m separ�tn�m procesu
                --d sekvence
                wait for 10ns;
                s_t <= '1';
                assert(s_q = '1' and s_q_bar = '0')
                report "Error at s_t = 0" severity error;
                wait for 10ns;
                s_t <= '0';
                wait for 10ns;
                s_t <= '1';
                wait for 10ns;
                s_t <= '0';
                wait for 10ns;
                s_t <= '1';
                wait for 10ns;
                s_t <= '0';
                --d sekvence
                wait for 10ns;
                s_t <= '1';
                wait for 10ns;
                s_t <= '0';
                wait for 10ns;
                s_t <= '1';
                wait for 10ns;
                s_t <= '0';
                wait for 10ns;
                s_t <= '1';
                wait for 10ns;
                s_t <= '0';
                
                wait for 10ns;
                s_t <= '1';
                wait for 10ns;
                s_t <= '0';
                wait for 10ns;
                s_t <= '1';
                wait for 10ns;
                s_t <= '0';
                wait for 10ns;
                s_t <= '1';
                wait for 10ns;
                s_t <= '0';
                
                
                
                report "Stimulus process finished" severity note;
                wait; 
            end process p_t_ff_rst;

end Behavioral;
