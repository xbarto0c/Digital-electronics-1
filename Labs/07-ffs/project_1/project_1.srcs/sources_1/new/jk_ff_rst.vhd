
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity jk_ff_rst is
     Port ( 
           rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           j : in STD_LOGIC;
           k : in STD_LOGIC;
           q : out STD_LOGIC;
           q_bar : out STD_LOGIC
           );
end jk_ff_rst;

architecture Behavioral of jk_ff_rst is
    signal s_q : std_logic; -- q nelze èíst, potøebujeme pomocný signál
begin
 p_jk_ff_rst : process (clk) 
    begin
        if rising_edge(clk) then
            if(rst = '1') then   --synchronní reset
                s_q <= '0';
            else
                if(j = '0' and k = '0') then
                    s_q <= s_q; --toggle
                elsif(j = '0' and k = '1') then
                    s_q <= '0';
                elsif(j = '1' and k = '0') then
                    s_q <= '1';
                elsif(j = '1' and k = '1') then
                    s_q <= not s_q;
                end if;
            end if;
        end if;
    end process p_jk_ff_rst;
    
    q     <= s_q;
    q_bar <= not s_q;


end Behavioral;
