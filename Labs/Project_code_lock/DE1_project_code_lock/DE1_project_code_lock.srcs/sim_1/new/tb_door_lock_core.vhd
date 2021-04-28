------------------------------------------------------------------------
--
-- Template for 4-digit 7-segment display driver testbench.
-- Nexys A7-50T, Vivado v2020.1.1, EDA Playground
--
-- Copyright (c) 2020 Tomas Fryza
-- Dept. of Radio Electronics, Brno University of Technology, Czechia
-- This work is licensed under the terms of the MIT license.
--
------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------------------
-- Entity declaration for testbench
------------------------------------------------------------------------
entity tb_door_lock_core is
    -- Entity of testbench is always empty
end entity tb_door_lock_core;

------------------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------------------
architecture testbench of tb_door_lock_core is

    -- Local constants
    constant c_CLK_100MHZ_PERIOD : time    := 10 ns;

    --Local signals
    signal   s_clk       :   std_logic;
    signal   s_reset     :   std_logic; -- synchronní reset
    signal   s_btn_i     :   std_logic_vector( 4 - 1 downto 0);
     
    signal   s_RGB_o     :   std_logic_vector( 3 - 1 downto 0);
    signal   s_piezzo_o  :   std_logic_vector( 2 - 1 downto 0);
    signal   s_relay_o   :   std_logic; 
    
begin
    -- Connecting testbench signals with driver_7seg_4digits entity
    -- (Unit Under Test)
    --- WRITE YOUR CODE HERE
    uut_door_lock_core : entity work.door_lock_core 
    port map(
    clk       => s_clk,
    reset     => s_reset,
    
    btn_i     => s_btn_i,
    RGB_o     => s_RGB_o,
    piezzo_o  => s_piezzo_o,
    relay_o   => s_relay_o
    
    
    );
    --------------------------------------------------------------------
    -- Clock generation process
    --------------------------------------------------------------------
    p_clk_gen : process
    begin
        while now < 10000 ns loop         -- 1000 periods of 100MHz clock
            s_clk <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
    end process p_clk_gen;

    --------------------------------------------------------------------
    -- Reset generation process
    --------------------------------------------------------------------
       p_reset_gen : process
        begin
        s_reset <= '0';
        wait for 10 ns;
        
        -- Reset activated
        s_reset <= '1';
        wait for 25 ns;

        s_reset <= '0';
        wait;
    end process p_reset_gen;

    --------------------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------------------
    p_stimulus : process
    begin
        report "Stimulus process started" severity note;
        wait for 1 us;
        s_btn_i  <= "1010"; -- 0
        wait for 10 ns;
        s_btn_i  <= "0010";
        wait for 10 ns;
        s_btn_i  <= "0001"; -- 1
        wait for 10 ns;
        s_btn_i  <= "1101";
        wait for 10 ns;
        s_btn_i  <= "0010"; -- 2
        wait for 10 ns;
        s_btn_i  <= "1101";
        wait for 10 ns;
        s_btn_i  <= "0011"; -- 3
        wait for 10 ns;
        s_btn_i  <= "1101";
        wait for 10 ns;
        s_btn_i  <= "0100"; -- 4
        wait for 10 ns;
        s_btn_i  <= "1101";
        wait for 10 ns;
        s_btn_i  <= "0101"; -- 5
        wait for 10 ns;
        s_btn_i  <= "1101";
        wait for 10 ns;
        s_btn_i  <= "0110"; -- 6
        wait for 10 ns;
        s_btn_i  <= "1101";
        wait for 10 ns;
        s_btn_i  <= "0111"; -- 7
        wait for 10 ns;
        s_btn_i  <= "1101";
        wait for 10 ns;
        s_btn_i  <= "1000"; -- 8
        wait for 10 ns;
        s_btn_i  <= "1101";
        wait for 10 ns;
        s_btn_i  <= "1001"; -- 9
        wait for 10 ns;
        s_btn_i  <= "1101";
        wait for 10 ns;
        s_btn_i  <= "1010"; -- #
        wait for 10 ns;
        s_btn_i  <= "1101";
        wait for 10 ns;
        s_btn_i  <= "1100"; -- *
        wait for 10 ns;
        s_btn_i  <= "1001";
        wait for 10 ns;

        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;

end architecture testbench;
