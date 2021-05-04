library ieee;
use ieee.std_logic_1164.all;

entity tb_top is
    -- Entity of testbench is always empty
end entity tb_top;

------------------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------------------
architecture testbench of tb_top is

    constant c_CLK_100MHZ_PERIOD : time    := 10 ns;  -- Clock signal period

    --Local signals
    signal   s_CLK100MHZ :  STD_LOGIC; -- Clock signal
    signal   s_BTNC      :  STD_LOGIC; -- Synchronous reset
    signal   s_PB1       :  STD_LOGIC; -- Button 1
    signal   s_PB2       :  STD_LOGIC; -- Button 2
    signal   s_PB3       :  STD_LOGIC; -- Button 3
    signal   s_PB4       :  STD_LOGIC; -- Button 4
    signal   s_PB5       :  STD_LOGIC; -- Button 5
    signal   s_PB6       :  STD_LOGIC; -- Button 6
    signal   s_PB7       :  STD_LOGIC; -- Button 7
    signal   s_PB8       :  STD_LOGIC; -- Button 8
    signal   s_PB9       :  STD_LOGIC; -- Button 9
    signal   s_PB0       :  STD_LOGIC; -- Button 0
    signal   s_PBC       :  STD_LOGIC; -- Button *
    signal   s_PBH       :  STD_LOGIC; -- Button #
    
    signal   s_RGB       :  STD_LOGIC_VECTOR (3 - 1 downto 0);
    signal   s_CA        :  STD_LOGIC;
    signal   s_CB        :  STD_LOGIC;
    signal   s_CC        :  STD_LOGIC;
    signal   s_CD        :  STD_LOGIC;
    signal   s_CE        :  STD_LOGIC;
    signal   s_CF        :  STD_LOGIC;
    signal   s_CG        :  STD_LOGIC;
    signal   s_CDP       :  STD_LOGIC;
    signal   s_A         :  STD_LOGIC_VECTOR (4 - 1 downto 0);
    signal   s_REL       :  STD_LOGIC;
    signal   s_BUZZ      :  STD_LOGIC;
    
begin
    uut_top : entity work.top 
        port map(
            CLK100MHZ    =>  s_CLK100MHZ,
            BTNC         =>  s_BTNC,
            PB1          =>  s_PB1,
            PB2          =>  s_PB2,
            PB3          =>  s_PB3,
            PB4          =>  s_PB4,
            PB5          =>  s_PB5,
            PB6          =>  s_PB6,
            PB7          =>  s_PB7,
            PB8          =>  s_PB8,
            PB9          =>  s_PB9,
            PB0          =>  s_PB0,
            PBC          =>  s_PBC,
            PBH          =>  s_PBH,
            RGB          =>  s_RGB,
            CA           =>  s_CA,
            CB           =>  s_CB,
            CC           =>  s_CC,
            CD           =>  s_CD,
            CE           =>  s_CE,
            CF           =>  s_CF,
            CG           =>  s_CG,
            CDP          =>  s_CDP,
            A            =>  s_A,
            REL          =>  s_REL,
            BUZZ         =>  s_BUZZ
    );
    --------------------------------------------------------------------
    -- Clock generation process
    --------------------------------------------------------------------
    p_clk_gen : process
    begin
        while now < 10000 ns loop
            s_CLK100MHZ <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_CLK100MHZ <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
    end process p_clk_gen;

    --------------------------------------------------------------------
    -- Reset generation process
    --------------------------------------------------------------------
    p_reset_gen : process
        begin
        s_BTNC <= '0';
        wait for 10 ns;
        
        -- Reset activated
        s_BTNC <= '1';
        wait for 25 ns;

        s_BTNC <= '0';
        wait;
    end process p_reset_gen;

    --------------------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------------------
    p_stimulus : process
    begin
        report "Stimulus process started" severity note;
        s_PB1 <= '0';
        s_PB2 <= '0';
        s_PB3 <= '0';
        s_PB4 <= '0';
        s_PB5 <= '0';
        s_PB6 <= '0';
        s_PB7 <= '0';
        s_PB8 <= '0';
        s_PB9 <= '0';
        s_PB0 <= '0';
        s_PBC <= '0';
        s_PBH <= '0';       
        
        wait for 100 ns;
        s_PBH    <= '1'; -- #
        wait for 10 ns;
        s_PBH    <= '0'; -- #
        wait for 30 ns;
        s_PB0    <= '1'; -- 0
        wait for 10 ns;
        s_PB0    <= '0'; -- 0
        wait for 30 ns;
        s_PB0    <= '1'; -- 0
        wait for 10 ns;
        s_PB0    <= '0'; -- 0
        wait for 30 ns;
        s_PB0    <= '1'; -- 0
        wait for 10 ns;
        s_PB0    <= '0'; -- 0
        wait for 30 ns;
        s_PB0    <= '1'; -- 0
        wait for 10 ns;
        s_PB0    <= '0'; -- 0
        wait for 40 ns;
        
        wait for 10 ns;
        s_PB1    <= '1'; -- 1
        wait for 10 ns;
        s_PB1    <= '0'; -- 1
        wait for 30 ns;
        s_PB1    <= '1'; -- 1
        wait for 10 ns;
        s_PB1    <= '0'; -- 1
        wait for 30 ns;
        s_PB1    <= '1'; -- 1
        wait for 10 ns;
        s_PB1    <= '0'; -- 1
        wait for 30 ns;
        s_PB1    <= '1'; -- 1
        wait for 10 ns;
        s_PB1    <= '0'; -- 1
        wait for 170 ns;
        
        s_PBC    <= '1'; -- *
        wait for 10 ns;
        s_PBC    <= '0'; -- *
        wait for 10 ns;
        s_PB1    <= '1'; -- 1
        wait for 10 ns;
        s_PB1    <= '0'; -- 1
        wait for 10 ns;
        s_PB1    <= '1'; -- 1
        wait for 10 ns;
        s_PB1    <= '0'; -- 1
        wait for 10 ns;
        s_PB1    <= '1'; -- 1
        wait for 10 ns;
        s_PB1    <= '0'; -- 1
        wait for 10 ns;
        s_PB1    <= '1'; -- 1
        wait for 10 ns;
        s_PB1    <= '0'; -- 1
        wait for 30 ns;
        
        s_PBC    <= '1'; -- *
        wait for 10 ns;
        s_PBC    <= '0'; -- *
        wait for 10 ns;
        s_PB0    <= '1'; -- 0
        wait for 10 ns;
        s_PB0    <= '0'; -- 0
        wait for 10 ns;
        s_PB0    <= '1'; -- 0
        wait for 10 ns;
        s_PB0    <= '0'; -- 0
        wait for 10 ns;
        s_PB0    <= '1'; -- 0
        wait for 10 ns;
        s_PB0    <= '0'; -- 0
        wait for 10 ns;
        s_PB0    <= '1'; -- 0
        wait for 10 ns;
        s_PB0    <= '0'; -- 0
        wait for 30 ns;
        
        s_PBC    <= '1'; -- *
        wait for 10 ns;
        s_PBC    <= '0'; -- *
        wait for 10 ns;
        s_PB7    <= '1'; -- 7
        wait for 10 ns;
        s_PB7    <= '0'; -- 7
        wait for 10 ns;
        s_PB2    <= '1'; -- 2
        wait for 10 ns;
        s_PB2    <= '0'; -- 2
        wait for 10 ns;
        s_PB4    <= '1'; -- 4
        wait for 10 ns;
        s_PB4    <= '0'; -- 4
        wait for 10 ns;
        s_PB8    <= '1'; -- 8
        wait for 10 ns;
        s_PB8    <= '0'; -- 8
        wait for 30 ns;
        
        s_PBC    <= '1'; -- *
        wait for 10 ns;
        s_PBC    <= '0'; -- *
        wait for 10 ns;
        s_PB3    <= '1'; -- 3
        wait for 10 ns;
        s_PB3    <= '0'; -- 3
        wait for 10 ns;
        s_PB5    <= '1'; -- 5
        wait for 10 ns;
        s_PB5    <= '0'; -- 5
        wait for 10 ns;
        s_PB0    <= '1'; -- 0
        wait for 10 ns;
        s_PB0    <= '0'; -- 0
        wait for 10 ns;
        s_PB9    <= '1'; -- 9
        wait for 10 ns;
        s_PB9    <= '0'; -- 9
        wait for 30 ns;
        
        s_PBC    <= '1'; -- *
        wait for 10 ns;
        s_PBC    <= '0'; -- *
        wait for 10 ns;
        s_PB2    <= '1'; -- 2
        wait for 10 ns;
        s_PB2    <= '0'; -- 2
        wait for 10 ns;
        s_PB0    <= '1'; -- 0
        wait for 10 ns;
        s_PB0    <= '0'; -- 0
        wait for 10 ns;
        s_PB0    <= '1'; -- 0
        wait for 10 ns;
        s_PB0    <= '0'; -- 0
        wait for 10 ns;
        s_PB1    <= '1'; -- 1
        wait for 10 ns;
        s_PB1    <= '0'; -- 1
        wait for 30 ns;
        
        s_PBC    <= '1'; -- *
        wait for 10 ns;
        s_PBC    <= '0'; -- *
        wait for 10 ns;
        s_PB3    <= '1'; -- 3
        wait for 10 ns;
        s_PB3    <= '0'; -- 3
        wait for 10 ns;
        s_PB5    <= '1'; -- 5
        wait for 10 ns;
        s_PB5    <= '0'; -- 5
        wait for 10 ns;
        s_PB0    <= '1'; -- 0
        wait for 10 ns;
        s_PB0    <= '0'; -- 0
        wait for 10 ns;
        s_PB9    <= '1'; -- 9
        wait for 10 ns;
        s_PB9    <= '0'; -- 9
        wait for 30 ns;
        
        s_PBC    <= '1'; -- *
        wait for 10 ns;
        s_PBC    <= '0'; -- *
        wait for 10 ns;
        s_PB0    <= '1'; -- 0
        wait for 10 ns;
        s_PB0    <= '0'; -- 0
        wait for 10 ns;
        s_PB0    <= '1'; -- 0
        wait for 10 ns;
        s_PB0    <= '0'; -- 0
        wait for 10 ns;
        s_PB0    <= '1'; -- 0
        wait for 10 ns;
        s_PB0    <= '0'; -- 0
        wait for 10 ns;
        s_PB0    <= '1'; -- 0
        wait for 10 ns;
        s_PB0    <= '0'; -- 0
        wait for 3000 ns;
        
        s_PBC    <= '1'; -- *
        wait for 10 ns;
        s_PBC    <= '0'; -- *
        wait for 10 ns;
        s_PB1    <= '1'; -- 1
        wait for 10 ns;
        s_PB1    <= '0'; -- 1
        wait for 10 ns;
        s_PB1    <= '1'; -- 1
        wait for 10 ns;
        s_PB1    <= '0'; -- 1
        wait for 10 ns;
        s_PB1    <= '1'; -- 1
        wait for 10 ns;
        s_PB1    <= '0'; -- 1
        wait for 10 ns;
        s_PB1    <= '1'; -- 1
        wait for 10 ns;
        s_PB1    <= '0'; -- 1
        wait for 30 ns;
        
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;

end architecture testbench;
