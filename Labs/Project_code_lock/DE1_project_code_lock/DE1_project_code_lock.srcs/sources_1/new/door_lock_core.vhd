------------------------------------------------------------------------
-- door_lock_core - main module of door lock terminal
--
-- Bar�nek Michal, Barto� Jan, Ba�ina Tade�, Beke� Alexander 2021
------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

------------------------------------------------------------------------
-- Entity declaration for core of the door lock terminal
------------------------------------------------------------------------

entity door_lock_core is
    port(
        clk       : in  std_logic; -- Clock Signal
        reset     : in  std_logic; -- Synchronous Reset
        btn_i     : in  std_logic_vector( 4 - 1 downto 0);
        
        RGB_o     : out std_logic_vector( 3 - 1 downto 0);
        relay_o   : out std_logic;
        buzzer_o  : out std_logic;
        display_o : out std_logic_vector(16 - 1 downto 0)
    );
end entity door_lock_core;

------------------------------------------------------------------------
-- Architecture declaration for traffic light controller
------------------------------------------------------------------------
architecture Behavioral of door_lock_core is

    -- Define the states
    type   t_state is (IDLE, D_OPEN,  ALARM,
                       ENTRY_PASSWORD, WRONG_PASSWORD, ENTRY_PASSWORD_NEW, NEW_PASSWORD); 
    -- Define the signal that uses different states
    signal            s_state           : t_state; 
    -- Internal clock enable
    signal            s_en              : std_logic; -- signal division
    -- Local delay counter
    signal            s_cnt             : unsigned(11 - 1 downto 0) := b"000_0000_0000";
    
    signal            piezzo_o          : std_logic_vector( 2 - 1 downto 0);
      
    --signal            display_o       : std_logic_vector(16 - 1 downto 0);
    shared variable   display_pos       : integer;
    shared variable   current_password  : std_logic_vector(16 - 1 downto 0);
    shared variable   entered_password  : std_logic_vector(16 - 1 downto 0);
    shared variable   set_new_password  : std_logic;
    shared variable   counter           : integer;

    -- Specific values for local counter
    constant c_ENTRY_TIME_20SEC                  : unsigned(11 - 1 downto 0) := b"000_0101_0000"; 
    constant c_DOOR_OPEN_TIME_3SEC               : unsigned(11 - 1 downto 0) := b"000_0000_1100"; 
    constant c_ALARM_ENGAGED_TIME_300SEC         : unsigned(11 - 1 downto 0) := b"000_1011_0000"; --changed for the sake of simulation, otherwise ther would be b"100_1011_0000" 
    constant c_WRONG_PASSWORD_BLINK_TIME_1SEC    : unsigned(11 - 1 downto 0) := b"000_0000_0100"; 
    constant c_ZERO                              : unsigned(11 - 1 downto 0) := b"000_0000_0000"; 

begin

    --------------------------------------------------------------------
    -- Instance (copy) of clock_enable entity generates an enable pulse
    -- every 250 ms (4 Hz). 
   clk_en0 : entity work.clock_enable
        generic map(
            g_MAX => 1       -- for the sake of simulation, otherwise there would be 25000000
        )
        port map(
            clk   => clk,
            reset => reset,
            ce_o  => s_en
        );

   piezzo0 : entity work.piezo_driver
        port map(
            mode_i  => piezzo_o,
            clk     => clk,
            piezo_o => buzzer_o
        );

    --------------------------------------------------------------------
    -- The sequential process with synchronous reset and clock_enable 
    -- entirely controls the s_state signal by CASE statement.
    --------------------------------------------------------------------
    p_door_lock_core : process(clk) -- state control
    begin
        if rising_edge(clk) then
            if (reset = '1') then       -- Synchronous reset
                s_state <= IDLE ;      -- Set initial state
                s_cnt   <= c_ZERO;      
                counter := 0;
                current_password := "0000000000000000";
                display_pos := 0;
                display_o   <= "1011101110111011";
            else
                case s_state is

                    
                    when IDLE =>
                        
                        if (btn_i = "1100") then
                            s_state <= ENTRY_PASSWORD_NEW;
                            display_o <= "1011101110111011";
                            s_cnt   <= c_ZERO;
                        elsif (btn_i = "1010") then
                            s_state <= ENTRY_PASSWORD;
                            display_o <= "1011101110111011";
                            s_cnt   <= c_ZERO;
                        else
                            s_state <= IDLE;
                            display_o <= "1010101010101010";
                            s_cnt   <= c_ZERO;
                        end if;
                        
                        if (s_cnt < c_WRONG_PASSWORD_BLINK_TIME_1SEC) then
                            if (s_en = '1') then
                                s_cnt <= s_cnt + 1;
                            end if;
                            display_o <= "1011101110111011";
                        elsif (s_cnt < 2*c_WRONG_PASSWORD_BLINK_TIME_1SEC) then
                            if (s_en = '1') then
                                s_cnt <= s_cnt + 1;
                            end if;
                            display_o <= "1010101010101010";
                        else
                            s_cnt <= c_ZERO;
                            display_o <= "1010101010101010";
                        end if;

                    when D_OPEN =>                    
                        if (s_cnt < c_DOOR_OPEN_TIME_3SEC) then
                            if (s_en = '1') then
                                s_cnt <= s_cnt + 1;
                            end if;
                        else
                            s_state <= IDLE;
                            display_o <= "1010101010101010";
                            s_cnt   <= c_ZERO;
                        end if;
                        
                    when ALARM =>                    
                        if (s_cnt < c_ALARM_ENGAGED_TIME_300SEC) then
                            if (s_en = '1') then
                                s_cnt <= s_cnt + 1;
                            end if;
                        else
                            s_state <= IDLE;
                            display_o <= "1010101010101010";
                            s_cnt   <= c_ZERO;
                        end if;
                        
                    when ENTRY_PASSWORD =>                    
                        if (s_cnt < c_ENTRY_TIME_20SEC) then
                            if (s_en = '1') then
                                s_cnt <= s_cnt + 1;
                            end if;
                            if (btn_i /= "1101" and btn_i /= "1010" and btn_i /= "1100") then 
                                case display_pos is
                                    when 0 =>
                                        display_o(15 downto 12) <= btn_i;
                                        entered_password(15 downto 12) := btn_i;
                                        display_pos := 1;
                                    when 1 =>
                                        display_o(11 downto 8) <= btn_i;
                                        entered_password(11 downto 8) := btn_i;
                                        display_pos := 2;
                                    when 2 =>
                                        display_o(7 downto 4) <= btn_i;
                                        entered_password(7 downto 4) := btn_i;
                                        display_pos := 3;
                                    when others =>
                                        display_o(3 downto 0) <= btn_i;
                                        entered_password(3 downto 0) := btn_i;
                                        if (entered_password = current_password) then
                                            s_state <= D_OPEN;
                                            display_o <= "1011101110111011";
                                            s_cnt   <= c_ZERO;
                                        elsif (entered_password /= current_password) then
                                            s_state <= WRONG_PASSWORD;
                                            s_cnt   <= c_ZERO;
                                        end if;
                                        set_new_password := '0';
                                        display_pos := 0;
                                end case;
                           end if;
                        else
                            s_state <= IDLE;
                            display_o <= "1010101010101010";
                            s_cnt   <= c_ZERO;
                        end if;
                        
                    when WRONG_PASSWORD =>
                        if (s_cnt < c_WRONG_PASSWORD_BLINK_TIME_1SEC) then
                            if (s_en = '1') then
                                s_cnt <= s_cnt + 1;
                            end if;
                        else
                            if (counter > 2) then 
                                s_state <= ALARM;
                                s_cnt   <= c_ZERO;
                                display_o <= "1011101110111011";
                                counter := 0;
                            elsif (set_new_password = '1') then
                                s_state <= ENTRY_PASSWORD_NEW;
                                display_o <= "1011101110111011";
                                s_cnt   <= c_ZERO;
                                counter := counter + 1;
                            else
                                s_state <= ENTRY_PASSWORD;
                                display_o <= "1011101110111011";
                                counter := counter + 1;
                                s_cnt   <= c_ZERO;
                            end if;
                        end if;   
                        
                    when ENTRY_PASSWORD_NEW =>
                        if (s_cnt < c_ENTRY_TIME_20SEC) then
                            if (s_en = '1') then
                                s_cnt <= s_cnt + 1;
                            end if;
                            if (btn_i /= "1101" and btn_i /= "1010" and btn_i /= "1100") then
                                case display_pos is
                                    when 0 =>
                                        display_o(15 downto 12) <= btn_i;
                                        entered_password(15 downto 12) := btn_i;
                                        display_pos := 1;
                                    when 1 =>
                                        display_o(11 downto 8) <= btn_i;
                                        entered_password(11 downto 8) := btn_i;
                                        display_pos := 2;
                                    when 2 =>
                                        display_o(7 downto 4) <= btn_i;
                                        entered_password(7 downto 4) := btn_i;
                                        display_pos := 3;
                                    when others =>
                                        display_o(3 downto 0) <= btn_i;
                                        entered_password(3 downto 0) := btn_i;
                                        if (entered_password = current_password) then
                                            s_state <= NEW_PASSWORD;
                                            s_cnt   <= c_ZERO;
                                            display_o <= "1011101110111011";
                                        elsif (entered_password /= current_password) then
                                            s_state <= WRONG_PASSWORD;
                                            s_cnt   <= c_ZERO;
                                        end if;
                                        set_new_password := '1';
                                        display_pos := 0;
                                end case;                                    
                           end if;
                        else
                            s_state <= IDLE;
                            display_o <= "1010101010101010";
                            s_cnt   <= c_ZERO;
                        end if;
                     
                    when NEW_PASSWORD =>
                        if (s_cnt < c_ENTRY_TIME_20SEC) then
                            if (s_en = '1') then
                                s_cnt <= s_cnt + 1;
                            end if;
                            if (btn_i /= "1101" and btn_i /= "1010" and btn_i /= "1100") then
                                case display_pos is
                                    when 0 =>
                                        display_o(15 downto 12) <= btn_i;
                                        entered_password(15 downto 12) := btn_i;
                                        display_pos := 1;
                                    when 1 =>
                                        display_o(11 downto 8) <= btn_i;
                                        entered_password(11 downto 8) := btn_i;
                                        display_pos := 2;
                                    when 2 =>
                                        display_o(7 downto 4) <= btn_i;
                                        entered_password(7 downto 4) := btn_i;
                                        display_pos := 3;
                                    when others =>
                                        display_o(3 downto 0) <= btn_i;
                                        entered_password(3 downto 0) := btn_i;
                                        current_password := entered_password;
                                        s_state <= D_OPEN;
                                        display_o <= "1011101110111011";
                                        s_cnt   <= c_ZERO;
                                        set_new_password := '0';
                                        display_pos := 0;
                                end case;                                        
                           end if;
                        else
                            s_state <= IDLE;
                            display_o <= "1010101010101010";
                            s_cnt   <= c_ZERO;
                        end if;
                            
                    when others => 
                        s_state <= IDLE;
                        display_o <= "1010101010101010";
                
                end case;
            
            end if;
            
        end if;
    end process p_door_lock_core;
    
    p_output_fsm : process(s_state) -- peripherals control
    begin
        case s_state is
            when IDLE =>
                RGB_o <= "110";   -- Blue RGB = 001
                relay_o <= '0';   -- Door closed
                piezzo_o <= "00"; -- Piezo off
                
            when D_OPEN =>
                RGB_o <= "101";   -- Green RGB = 010
                relay_o <= '1';   -- Door opened
                PIEZZO_o <= "10"; -- Piezo constant

            when WRONG_PASSWORD =>
                RGB_o <= "011";   -- Red RGB = 100
                relay_o <= '0';   -- Door closed
                PIEZZO_o <= "01"; -- Piezo beeping
                
            when ALARM =>
                RGB_o <= "011";   -- Red RGB = 100
                relay_o <= '0';   -- Door closed
                PIEZZO_o <= "01"; -- Piezo beeping
                               
            when others =>
                RGB_o <= "111";   -- Off RGB = 000
                relay_o <= '0';   -- Door closed
                PIEZZO_o <= "00"; -- Piezo off
        end case;
    end process p_output_fsm;

end architecture Behavioral;