[My(221048) Github Repository Link](https://github.com/xbarto0c/Digital-electronics-1):

| **c** | **b** |**a** | **f(c,b,a)** |
| :-: | :-: | :-: | :-: |
| 0 | 0 | 0 | 1 |
| 0 | 0 | 1 | 1 |
| 0 | 1 | 0 | 0 |
| 0 | 1 | 1 | 0 |
| 1 | 0 | 0 | 0 |
| 1 | 0 | 1 | 1 |
| 1 | 1 | 0 | 0 |
| 1 | 1 | 1 | 0 |

### Morgan's Laws Verification Code
```VHDL
library ieee;               
use ieee.std_logic_1164.all;

------------------------------------------------------------------------
-- Entity declaration for basic gates
------------------------------------------------------------------------
entity gates is
    port(
        a_i    : in  std_logic;        
        b_i    : in  std_logic;        
        c_i    : in  std_logic;
        fun_o  :     out std_logic;    
        fun_NAND_o : out std_logic;         
        fun_NOR_o :  out std_logic         
    );
end entity gates;

------------------------------------------------------------------------
-- Architecture body for basic gates
------------------------------------------------------------------------
architecture dataflow of gates is
begin
    fun_o  <= (not(b_i) and a_i) or (not(c_i) and not(b_i));
    fun_NAND_o <= not(not((not(b_i) and a_i)) and not(not(c_i) and not(b_i)));
    fun_NOR_o <= not(b_i or not(a_i)) or not(c_i or b_i);

end architecture dataflow;

```
![Morgan's Laws Truth table](/Labs/01-gates/images/Function_original_values.jpg)
[My EDA De Morgan Law's code](https://www.edaplayground.com/x/mjq3)

### Distributive Laws Verification Code
```VHDL
library ieee;               
use ieee.std_logic_1164.all;

------------------------------------------------------------------------
-- Entity declaration for basic gates
------------------------------------------------------------------------
entity gates is
    port(
        a_i    : in  std_logic;        
        b_i    : in  std_logic;        
        c_i    : in  std_logic;
        fun_1_o  : 			  out std_logic;    
        fun_distrib_law_1_o : out std_logic;
        fun_2_o  : 			  out std_logic;    
        fun_distrib_law_2_o : out std_logic 
    );
end entity gates;

------------------------------------------------------------------------
-- Architecture body for basic gates
------------------------------------------------------------------------
architecture dataflow of gates is
begin
    fun_1_o  <= (a_i and b_i) or (a_i and c_i);
    fun_distrib_law_1_o <= a_i and (b_i or c_i);
    fun_2_o  <= (a_i or b_i) and (a_i or c_i);
    fun_distrib_law_2_o <= a_i or (b_i and c_i);

end architecture dataflow;

```

![Distributive Laws Truth table](/Labs/01-gates/images/Distributive_laws_proof.jpg)
[My EDA Distributive Laws Code](https://www.edaplayground.com/x/nqNp)