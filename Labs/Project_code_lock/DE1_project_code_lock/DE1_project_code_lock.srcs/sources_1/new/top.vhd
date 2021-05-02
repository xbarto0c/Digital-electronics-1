----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.03.2021 00:02:03
-- Design Name: 
-- Module Name: top - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
    Port ( 
           CLK100MHZ : in  STD_LOGIC;
           BTNC      : in  STD_LOGIC;
           PB1       : in  STD_LOGIC;
           PB2       : in  STD_LOGIC;
           PB3       : in  STD_LOGIC;
           PB4       : in  STD_LOGIC;
           PB5       : in  STD_LOGIC;
           PB6       : in  STD_LOGIC;
           PB7       : in  STD_LOGIC;
           PB8       : in  STD_LOGIC;
           PB9       : in  STD_LOGIC;
           PB0       : in  STD_LOGIC;
           PBC       : in  STD_LOGIC;
           PBH       : in  STD_LOGIC;
           RGB       : out STD_LOGIC_VECTOR (3 - 1 downto 0);
           BTN       : in  STD_LOGIC_VECTOR (4 - 1 downto 0);
           CA        : out STD_LOGIC;
           CB        : out STD_LOGIC;
           CC        : out STD_LOGIC;
           CD        : out STD_LOGIC;
           CE        : out STD_LOGIC;
           CF        : out STD_LOGIC;
           CG        : out STD_LOGIC;
           CDP       : out STD_LOGIC;
           A         : out STD_LOGIC_VECTOR (4 - 1 downto 0);
           REL       : out STD_LOGIC;
           BUZZ      : out STD_LOGIC
          );
end top;

architecture Behavioral of top is
    signal display_o : std_logic_vector(16 - 1 downto 0);
    signal btn_i     : std_logic_vector(4  - 1 downto 0);
begin

    --------------------------------------------------------------------
    -- Instance (copy) of driver_7seg_4digits entity
    driver_seg_4 : entity work.driver_7seg_4digits
        port map(
            clk        => CLK100MHZ,
            reset      => BTNC,
            dp_i       => "1111",
            data0_i    => display_o(3 downto 0),
            data1_i    => display_o(7 downto 4),
            data2_i    => display_o(11 downto 8),
            data3_i    => display_o(15 downto 12),
            seg_o(6)   => CA,
            seg_o(5)   => CB,
            seg_o(4)   => CC,
            seg_o(3)   => CD,
            seg_o(2)   => CE,
            seg_o(1)   => CF,
            seg_o(0)   => CG,
            dp_o       => CDP,
            dig_o(3)   => A(3),
            dig_o(2)   => A(2),
            dig_o(1)   => A(1),
            dig_o(0)   => A(0)
            
        );   
    door_lock_code : entity work.door_lock_core
        port map(
            clk        => CLK100MHZ,
            reset      => BTNC,
            RGB_o(2)   => RGB(2),
            RGB_o(1)   => RGB(1),
            RGB_o(0)   => RGB(0),
            relay_o    => REL,
            btn_i      => btn_i,
            buzzer_o   => BUZZ
        );   
    keyboard_decoder0 : entity work.keyboard_decoder
        port map(
            clk         => CLK100MHZ,
            decoder_out => btn_i,
            btn_1       => PB1,
            btn_2       => PB2,
            btn_3       => PB3,
            btn_4       => PB4,
            btn_5       => PB5,
            btn_6       => PB6,
            btn_7       => PB7,
            btn_8       => PB8,
            btn_9       => PB9,
            btn_0       => PB0,
            btn_star    => PBC,
            btn_hash    => PBH
        );

end architecture Behavioral;
