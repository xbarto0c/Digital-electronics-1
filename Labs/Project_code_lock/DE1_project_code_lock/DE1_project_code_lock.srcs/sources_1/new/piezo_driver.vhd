------------------------------------------------------------------------
-- piezo_driver - module made to drive a PIEZZO speaker
--
-- Baránek Michal, Bartoò Jan, Baøina Tadeáš, Bekeè Alexander 2021
------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity piezo_driver is
    Port (
        clk     : in std_logic;
        mode_i  : in std_logic_vector(2 - 1 downto 0);
        piezo_o : out std_logic
    );
end piezo_driver;

architecture Behavioral of piezo_driver is
    signal s_tone : std_logic;
    signal s_beep : std_logic;
    signal s_beep_clk : std_logic;
begin
    clock_divider_0 : entity work.clock_divider
        Generic map(
            g_CYCLES => 2 -- previously 100000
        )
        Port map(
            clk => clk,
            rst => '0',
            clk_out => s_tone            
        );
        
    clock_divider_1 : entity work.clock_divider
        Generic map(
            g_CYCLES => 10 -- previously 50000000
        )
        Port map(
            clk => clk,
            rst => '0',
            clk_out => s_beep_clk            
        );
        
    mux_0 : entity work.mux_2to1
        Port map(
            dat_i => s_tone,
            pre_i => '0',
            sel_i => s_beep_clk,
            mux_o => s_beep
        );


            piezo_o <= s_beep when (mode_i = "01") else
               s_tone when (mode_i = "10") else
               '0'    when (mode_i = "00");

end Behavioral;
