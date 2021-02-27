## 1.Connection of 16 LEDs and switches to the Nexys A7 board: 
| Pin name: | Pin name on the board : |
| :-: | :-: |
| LED0 | H17 |
| LED1 | K15 |
| LED2 | J13 |
| LED3 | N14 |
| LED4 | R18 |
| LED5 | V17 |
| LED6 | U17 |
| LED7 | U16 |
| LED8 | V16 |
| LED9 | T15 |
| LED10 | U14 |
| LED11 | T16 |
| LED12 | V15 |
| LED13 | V14 |
| LED14 | V12 |
| LED15 | V11 |
| SW0 | J15 |
| SW1 | L16 |
| SW2 | M13 |
| SW3 | R15 |
| SW4 | R17 |
| SW5 | T18 |
| SW6 | U18 |
| SW7 | R13 |
| SW8 | T8 |
| SW9 | U8 |
| SW10 | R16 |
| SW11 | T13 |
| SW12 | H6 |
| SW13 | U12 |
| SW14 | U11 |
| SW15 | V10 |

## 2.Two-bit wide 4-to-1 multiplexer
### Multiplexer architecture code:
```VHDL
architecture Behavioral of  mux_2bit_4to1 is
begin

    f_o   <= a_i when (sel_i = "00") else 
             b_i when (sel_i = "01") else
             c_i when (sel_i = "10") else
             d_i;
end architecture Behavioral;
```

### Multiplexer stimulus process code:
```VHDL
 p_stimulus : process
    begin
        -- Report a note at the begining of stimulus process
        report "Stimulus process started" severity note;


        -- First test values
        s_a <= "00";s_b <= "01";s_c <= "11"; s_d <= "10";
        s_sel <= "00"; wait for 100 ns;
        
        s_a <= "00";s_b <= "01";s_c <= "11"; s_d <= "10";
        s_sel <= "10"; wait for 100 ns;
        
        s_a <= "00";s_b <= "01";s_c <= "11"; s_d <= "10";
        s_sel <= "01"; wait for 100 ns;
        
        s_a <= "00";s_b <= "01";s_c <= "11"; s_d <= "10";
        s_sel <= "11"; wait for 100 ns;

        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;
```
### Multiplexer simulation screenshot:
![Multiplexer simulation screenshot:](/Labs/03-vivado/images/multiplexer_simulation.jpg)

