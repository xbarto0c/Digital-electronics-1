-- Multiplexer 2-to-1

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_2to1 is
    Port(
        dat_i : in  std_logic; -- Bit from parallel input
        pre_i : in  std_logic; -- Bit from previous D Flip Flop
        sel_i : in  std_logic; -- Input selection
        mux_o : out std_logic  -- Output of the multiplexer
    );
end mux_2to1;

architecture Behavioral of mux_2to1 is
begin
    mux_o <= dat_i when (sel_i = '0') else
             pre_i;
end architecture Behavioral;
