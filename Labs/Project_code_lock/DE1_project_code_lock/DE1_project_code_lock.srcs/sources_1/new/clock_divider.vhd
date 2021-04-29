library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity clock_divider is
    Generic (
        g_CYCLES : natural := 100000
    );    
    Port (
        clk     : in std_logic;
        rst   : in std_logic;
        clk_out : out std_logic
    );
end clock_divider;

architecture Behavioral of clock_divider is
    signal cnt : integer := 1;
    signal tmp : std_logic := '0';
begin
    p_clock_divider : process(clk,rst)
    begin
        if rising_edge(clk) then
            if (rst = '1') then
                cnt <= 1;
                tmp <= '0';
            else
                cnt <= cnt + 1;
                if (cnt = g_CYCLES) then
                    tmp <= NOT tmp;
                    cnt <= 1;
                end if;
            end if;
        end if;
        clk_out <= tmp;
    end process;
end architecture Behavioral;
