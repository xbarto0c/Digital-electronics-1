library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------------------
-- Entity declaration for testbench
------------------------------------------------------------------------
entity tb_mux_2to1 is
    -- Entity of testbench is always empty
end entity tb_mux_2to1;

------------------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------------------
architecture testbench of tb_mux_2to1 is

    -- Local signals
    signal s_a       : std_logic;
    signal s_b       : std_logic;
    signal s_sel     : std_logic;
   
    signal s_f       : std_logic;


begin
    -- Connecting testbench signals with comparator_4bit entity (Unit Under Test)
    uut_mux_2to1 : entity work.mux_2to1
        port map(
            dat_i           => s_a,
            pre_i           => s_b,
            sel_i           => s_sel,
            
            mux_o           => s_f           
        );

    --------------------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------------------
    p_stimulus : process
    begin
        -- Report a note at the begining of stimulus process
        report "Stimulus process started" severity note;


        -- First test values
        s_a <= '0'; s_b <= '1';
        s_sel <= '0'; wait for 100 ns;
        
        s_a <= '0';s_b <= '1';
        s_sel <= '1'; wait for 100 ns;

        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;

end architecture testbench;
