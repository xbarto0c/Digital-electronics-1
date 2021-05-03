library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_piezo_driver is

end tb_piezo_driver;

architecture Testbench of tb_piezo_driver is
    signal s_clk : std_logic;
    signal s_mode_i : std_logic_vector(2 - 1 downto 0);
    signal s_piezo_o : std_logic;
begin
    uut_top : entity work.piezo_driver
        Port map(
            clk => s_clk,
            mode_i => s_mode_i,
            piezo_o => s_piezo_o
        );
        
    p_clk : process
    begin
        while now < 1000000 ns loop
            s_clk <= '0';
            wait for 10 ns / 2;
            s_clk <= '1';
            wait for 10 ns / 2;
        end loop;
        wait;
    end process p_clk;
    
    p_stimulus : process
    begin
        while now < 1000000 ns loop
            s_mode_i <= "00";
            wait for 600 ns;
            s_mode_i <= "01";
            wait for 600 ns;
            s_mode_i <= "10";
            wait for 600 ns;
        end loop;
        wait;
    end process p_stimulus;

end Testbench;
