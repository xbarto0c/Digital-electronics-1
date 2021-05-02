library ieee;
use ieee.std_logic_1164.all;

entity tb_keyboard_decoder is
    -- Entity of testbench is always empty
end entity tb_keyboard_decoder;

------------------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------------------
architecture testbench of tb_keyboard_decoder is
    
    signal s_clk         :  STD_LOGIC;
    signal s_btn_1       :  STD_LOGIC;   -- Button 1                   
    signal s_btn_2       :  STD_LOGIC;   -- Button 2                   
    signal s_btn_3       :  STD_LOGIC;   -- Button 3                   
    signal s_btn_4       :  STD_LOGIC;   -- Button 4                   
    signal s_btn_5       :  STD_LOGIC;   -- Button 5                   
    signal s_btn_6       :  STD_LOGIC;   -- Button 6                   
    signal s_btn_7       :  STD_LOGIC;   -- Button 7                   
    signal s_btn_8       :  STD_LOGIC;   -- Button 8                   
    signal s_btn_9       :  STD_LOGIC;   -- Button 9                   
    signal s_btn_0       :  STD_LOGIC;   -- Button 0                   
    signal s_btn_star    :  STD_LOGIC;   -- Button *                   
    signal s_btn_hash    :  STD_LOGIC;   -- Button #                   
                                                             
    signal s_decoder_out : STD_LOGIC_VECTOR(4 - 1 downto 0);  -- Output
    
begin
    -- Connecting testbench signals with driver_7seg_4digits entity
    -- (Unit Under Test)
    --- WRITE YOUR CODE HERE
    uut_keyboard_decoder : entity work.keyboard_decoder 
        port map(
            
            clk          => s_clk,    
            btn_1        => s_btn_1,      
            btn_2        => s_btn_2,      
            btn_3        => s_btn_3,      
            btn_4        => s_btn_4,      
            btn_5        => s_btn_5,      
            btn_6        => s_btn_6,      
            btn_7        => s_btn_7,      
            btn_8        => s_btn_8,      
            btn_9        => s_btn_9,      
            btn_0        => s_btn_0,      
            btn_star     => s_btn_star,   
            btn_hash     => s_btn_hash,   
    
            decoder_out  => s_decoder_out
       );
    p_clk : process
    begin
        while now < 10000 ns loop
            s_clk <= '0';
            wait for 10 ns / 2;
            s_clk <= '1';
            wait for 10 ns / 2;
        end loop;
        wait;
    end process p_clk;
    --------------------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------------------
    p_stimulus : process
    begin
        report "Stimulus process started" severity note;
        wait for 100 ns;
        s_btn_1  <= '0';
        s_btn_2  <= '0';
        s_btn_3  <= '0';
        s_btn_4  <= '0';
        s_btn_5  <= '0';
        s_btn_6  <= '0';
        s_btn_7  <= '0';
        s_btn_8  <= '0';
        s_btn_9  <= '0';
        s_btn_0  <= '0';
        s_btn_star  <= '0';
        s_btn_hash  <= '0';
        wait for 10 ns;
        
        s_btn_1  <= '1';
        wait for 10 ns;
        
        s_btn_1  <= '0';
        s_btn_2  <= '1';
        wait for 10 ns;
        
        s_btn_2  <= '0';
        s_btn_3  <= '1';
        wait for 10 ns;
        
        s_btn_3  <= '0';
        s_btn_4  <= '1';
        wait for 10 ns;
        
        s_btn_4  <= '0';
        s_btn_5  <= '1';
        wait for 10 ns;
        
        s_btn_5  <= '0';
        s_btn_6  <= '1';
        wait for 10 ns;
        
        s_btn_6  <= '0';
        s_btn_7  <= '1';
        wait for 10 ns;
        
        s_btn_7  <= '0';
        s_btn_8  <= '1';
        wait for 10 ns;
        
        s_btn_8  <= '0';
        s_btn_9  <= '1';
        wait for 10 ns;
        
        s_btn_9  <= '0';
        s_btn_0  <= '1';
        wait for 10 ns;
        
        s_btn_0  <= '0';
        s_btn_star  <= '1';
        wait for 10 ns;
        
        s_btn_star  <= '0';
        s_btn_hash  <= '1';
        wait for 10 ns;
        
        s_btn_hash  <= '0';
        s_btn_1  <= '1';
        s_btn_3  <= '1';
        wait for 10 ns;
                
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;

end architecture testbench;