------------------------------------------------------------------------
--
-- Traffic light controller using FSM.
-- Nexys A7-50T, Vivado v2020.1.1, EDA Playground
--
-- Copyright (c) 2020-Present Tomas Fryza
-- Dept. of Radio Electronics, Brno University of Technology, Czechia
-- This work is licensed under the terms of the MIT license.
--
-- This code is inspired by:
-- [1] LBEbooks, Lesson 92 - Example 62: Traffic Light Controller
--     https://www.youtube.com/watch?v=6_Rotnw1hFM
-- [2] David Williams, Implementing a Finite State Machine in VHDL
--     https://www.allaboutcircuits.com/technical-articles/implementing-a-finite-state-machine-in-vhdl/
-- [3] VHDLwhiz, One-process vs two-process vs three-process state machine
--     https://vhdlwhiz.com/n-process-state-machine/
--
------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

------------------------------------------------------------------------
-- Entity declaration for traffic light controller
------------------------------------------------------------------------
entity door_lock_core is
    port(
        clk       : in  std_logic;
        reset     : in  std_logic; -- synchronní reset
        btn_i     : in  std_logic_vector( 4 - 1 downto 0);
        
        RGB_o     : out std_logic_vector( 3 - 1 downto 0);
        piezzo_o  : out std_logic_vector( 2 - 1 downto 0);
        relay_o   : out std_logic  
    );
end entity door_lock_core;

------------------------------------------------------------------------
-- Architecture declaration for traffic light controller
------------------------------------------------------------------------
architecture Behavioral of door_lock_core is

    -- Define the states
    type   t_state is (IDLE, D_OPEN,  ALARM,
                       ENTRY_PASSWORD, WRONG_PASSWORD, ENTRY_PASSWORD_NEW, NEW_PASSWORD); -- definice stavù
    -- Define the signal that uses different states
    signal            s_state           : t_state; -- signál používající stavy z t_state
    -- Internal clock enable
    signal            s_en              : std_logic; -- dìlení signálu
    -- Local delay counter
    signal            s_cnt             : unsigned(11 - 1 downto 0);
      
    signal            display_o         :  std_logic_vector(16 - 1 downto 0);
    shared variable   display_pos       : std_logic_vector(2 - 1 downto 0);
    shared variable   current_password  : std_logic_vector(16 - 1 downto 0);
    shared variable   entered_password  : std_logic_vector(16 - 1 downto 0);
    shared variable   set_new_password  : std_logic;
    shared variable   counter           : unsigned (2 - 1 downto 0);
    shared variable   RGB_LED_ON        : integer;

    -- Specific values for local counter
    constant c_ENTRY_TIME_20SEC                  : unsigned(11 - 1 downto 0) := b"000_0101_0000"; -- èekání
    constant c_DOOR_OPEN_TIME_3SEC               : unsigned(11 - 1 downto 0) := b"000_0000_1100"; -- èekání
    constant c_ALARM_ENGAGED_TIME_300SEC         : unsigned(11 - 1 downto 0) := b"100_1011_0000"; -- èekání
    constant c_WRONG_PASSWORD_BLINK_TIME_1SEC    : unsigned(11 - 1 downto 0) := b"000_0000_0100"; -- èekání
    constant c_ZERO                              : unsigned(11 - 1 downto 0) := b"000_0000_0000";

begin

    --------------------------------------------------------------------
    -- Instance (copy) of clock_enable entity generates an enable pulse
    -- every 250 ms (4 Hz). Remember that the frequency of the clock 
    -- signal is 100 MHz.
    
    -- JUST FOR SHORTER/FASTER SIMULATION
   clk_en0 : entity work.clock_enable
       generic map(
                   g_MAX => 4       -- g_MAX = 250 ms / (1/100 MHz)
        )
        port map(
            clk   => clk,
            reset => reset,
            ce_o  => s_en
        );
   driver_7seg_4digits0 : entity work.driver_7seg_4digits
        port map(
            data0_i => display_o(3 downto 0),
            data1_i => display_o(7 downto 4),
            data2_i => display_o(11 downto 8),
            data3_i => display_o(15 downto 12),
            dp_i    => "1111",
            clk     => clk, 
            reset   => reset
        );
   --piezzo0 : entity work.piezzo_driver
    --    port map(
    --        data0_i => display_o(3 downto 0),
   --         data1_i => display_o(7 downto 4),
    --        data2_i => display_o(11 downto 8),
    --        data3_i => display_o(15 downto 12),
    --        dp_i    => "1111",
    --        clk     => clk, 
    --        reset   => reset
    --    );

    --------------------------------------------------------------------
    -- p_traffic_fsm:
    -- The sequential process with synchronous reset and clock_enable 
    -- entirely controls the s_state signal by CASE statement.
    --------------------------------------------------------------------
    p_door_lock_core : process(clk) -- ovládání stavù
    begin
        if rising_edge(clk) then
            if (reset = '1') then       -- Synchronous reset
                s_state <= IDLE ;      -- Set initial state
                s_cnt   <= c_ZERO;      -- Clear all bits

            elsif (s_en = '1') then
                -- Every 250 ms, CASE checks the value of the s_state 
                -- variable and changes to the next state according 
                -- to the delay value.
                case s_state is

                    -- If the current state is STOP1, then wait 1 sec
                    -- and move to the next GO_WAIT state.
                    when IDLE =>
                        -- Count up to c_DELAY_1SEC
                        if (btn_i = "1100") then
                            s_state <= ENTRY_PASSWORD_NEW;
                        elsif (btn_i = "1010") then
                            -- Move to the next state
                            s_state <= ENTRY_PASSWORD;
                        else
                            s_state <= IDLE;
                        end if;

                    when D_OPEN =>
                    
                        if (s_cnt < c_DOOR_OPEN_TIME_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= IDLE;
                            -- Reset local counter value
                            s_cnt   <= c_ZERO;
                        end if;
                        
                    when ALARM =>
                    
                        if (s_cnt < c_ALARM_ENGAGED_TIME_300SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= IDLE;
                            -- Reset local counter value
                            s_cnt   <= c_ZERO;
                        end if;
                    when ENTRY_PASSWORD =>
                    
                        if (s_cnt < c_ENTRY_TIME_20SEC) then
                            s_cnt <= s_cnt + 1;
                            if (btn_i /= "0000" and btn_i /= "1010" and btn_i /= "1100") then 
                                case display_pos is
                                    when "00" =>
                                        display_o(3 downto 0) <= btn_i;
                                        entered_password(15 downto 12) := btn_i;
                                        display_pos := "01";
                                    when "01" =>
                                        display_o(7 downto 4) <= btn_i;
                                        entered_password(11 downto 8) := btn_i;
                                        display_pos := "10";
                                    when "10" =>
                                        display_o(11 downto 8) <= btn_i;
                                        entered_password(7 downto 4) := btn_i;
                                        display_pos := "11";
                                    when "11" =>
                                        display_o(15 downto 12) <= btn_i;
                                        entered_password(3 downto 0) := btn_i;
                                        if (entered_password = current_password) then
                                            s_state <= D_OPEN;
                                        elsif (entered_password /= current_password) then
                                            s_state <= WRONG_PASSWORD;
                                        end if;
                                        display_pos := "00";
                                end case;
                           end if;
                        else
                            -- Move to the next state
                            s_state <= IDLE;
                            -- Reset local counter value
                            s_cnt   <= c_ZERO;
                        end if;
                        
                    when WRONG_PASSWORD =>
                    
                        if (s_cnt < c_WRONG_PASSWORD_BLINK_TIME_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            if (counter > 2) then 
                                s_state <= ALARM;
                            elsif (set_new_password = '1') then
                                s_state <= ENTRY_PASSWORD_NEW;
                            else
                                s_state <= ENTRY_PASSWORD;
                                -- Reset local counter value
                                s_cnt   <= c_ZERO;
                            end if;
                        end if;   
                        
                    when ENTRY_PASSWORD_NEW =>
                    
                        if (s_cnt < c_ENTRY_TIME_20SEC) then
                            s_cnt <= s_cnt + 1;
                            if (btn_i /= "0000" and btn_i /= "1010" and btn_i /= "1100") then
                                case display_pos is
                                    when "00" =>
                                        display_o(3 downto 0) <= btn_i;
                                        entered_password(15 downto 12) := btn_i;
                                        display_pos := "01";
                                    when "01" =>
                                        display_o(7 downto 4) <= btn_i;
                                        entered_password(11 downto 8) := btn_i;
                                        display_pos := "01";
                                    when "10" =>
                                        display_o(11 downto 8) <= btn_i;
                                        entered_password(7 downto 4) := btn_i;
                                        display_pos := "01";
                                    when "11" =>
                                        display_o(15 downto 12) <= btn_i;
                                        entered_password(3 downto 0) := btn_i;
                                        if (entered_password = current_password) then
                                            s_state <= NEW_PASSWORD;
                                        elsif (entered_password /= current_password) then
                                            s_state <= WRONG_PASSWORD;
                                        end if;
                                        display_pos := "01";
                                end case;
                           end if;
                        else
                            -- Move to the next state
                            s_state <= IDLE;
                            -- Reset local counter value
                            s_cnt   <= c_ZERO;
                        end if;
                    -- It is a good programming practice to use the 
                    -- OTHERS clause, even if all CASE choices have 
                    -- been made. 
                    when NEW_PASSWORD =>
                            -- Move to the next state
                            current_password := entered_password;
                            s_state <= D_OPEN;
                            -- Reset local counter value
                    when others => 
                        s_state <= IDLE;

                end case;
            end if; -- Synchronous reset
        end if; -- Rising edge
    end process p_door_lock_core;
    
    
    p_output_fsm : process(s_state) -- ovládání výstupù
    begin
        case s_state is
            when IDLE =>
                RGB_o <= "001";   -- Red (RGB = 100)
                
            when WRONG_PASSWORD =>
            if (s_cnt < c_WRONG_PASSWORD_BLINK_TIME_1SEC) then
                s_cnt <= s_cnt + 1;
            else
                if(RGB_LED_ON = 1) then
                    RGB_o <= "111";   -- RED (RGB = 100)
                    RGB_LED_ON := 0;
                else
                    RGB_o <= "011";
                    RGB_LED_ON := 1;
                end if;
                s_cnt <= c_ZERO;
            end if;    
            when ALARM =>
                RGB_o <= "011";   -- Blue (RGB = 001)
                PIEZZO_o <= "01";
          
            when D_OPEN =>
                RGB_o <= "101";   -- Blue (RGB = 001)
                PIEZZO_o <= "10";
                
            when others =>
                RGB_o <= "111";   -- Blue (RGB = 001)
                PIEZZO_o <= "00";
        end case;
    end process p_output_fsm;

end architecture Behavioral;
