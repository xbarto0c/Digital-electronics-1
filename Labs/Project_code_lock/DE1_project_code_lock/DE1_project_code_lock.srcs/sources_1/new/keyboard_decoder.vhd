-- Keyboard decoder (0-9,*,#)

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity keyboard_decoder is
    Port (  
        clk         : in  STD_LOGIC;
        btn_1       : in  STD_LOGIC;   -- Button 1
        btn_2       : in  STD_LOGIC;   -- Button 2
        btn_3       : in  STD_LOGIC;   -- Button 3
        btn_4       : in  STD_LOGIC;   -- Button 4
        btn_5       : in  STD_LOGIC;   -- Button 5
        btn_6       : in  STD_LOGIC;   -- Button 6
        btn_7       : in  STD_LOGIC;   -- Button 7
        btn_8       : in  STD_LOGIC;   -- Button 8
        btn_9       : in  STD_LOGIC;   -- Button 9
        btn_0       : in  STD_LOGIC;   -- Button 0
        btn_star    : in  STD_LOGIC;   -- Button *
        btn_hash    : in  STD_LOGIC;   -- Button #
         
        decoder_out : out STD_LOGIC_VECTOR(4 - 1 downto 0)  -- Output    
    );
end keyboard_decoder;

architecture Behavioral of keyboard_decoder is

    signal s_btn_in : STD_LOGIC_VECTOR(12 - 1 downto 0);
    
begin

    p_keyboard_decoder : process(clk)
    begin
        if rising_edge(clk) then 
        
            s_btn_in(11) <= btn_1;
            s_btn_in(10) <= btn_2;
            s_btn_in(9)  <= btn_3;
            s_btn_in(8)  <= btn_4;
            s_btn_in(7)  <= btn_5;
            s_btn_in(6)  <= btn_6;
            s_btn_in(5)  <= btn_7;
            s_btn_in(4)  <= btn_8;
            s_btn_in(3)  <= btn_9;
            s_btn_in(2)  <= btn_star;
            s_btn_in(1)  <= btn_0;
            s_btn_in(0)  <= btn_hash;
            
            case s_btn_in is
                when "100000000000" => decoder_out <= "0001"; -- Button 1 pressed
                when "010000000000" => decoder_out <= "0010"; -- Button 2 pressed
                when "001000000000" => decoder_out <= "0011"; -- Button 3 pressed
                when "000100000000" => decoder_out <= "0100"; -- Button 4 pressed
                when "000010000000" => decoder_out <= "0101"; -- Button 5 pressed
                when "000001000000" => decoder_out <= "0110"; -- Button 6 pressed
                when "000000100000" => decoder_out <= "0111"; -- Button 7 pressed
                when "000000010000" => decoder_out <= "1000"; -- Button 8 pressed
                when "000000001000" => decoder_out <= "1001"; -- Button 9 pressed
                when "000000000100" => decoder_out <= "1010"; -- Button * pressed
                when "000000000010" => decoder_out <= "0000"; -- Button 0 pressed
                when "000000000001" => decoder_out <= "1100"; -- Button # pressed
                when "000000000000" => decoder_out <= "1101"; -- Less than one button pressed
                when others         => decoder_out <= "1101"; -- More than one button pressed
            end case;
         end if;
    end process p_keyboard_decoder;
end architecture Behavioral;
