# Digital-electronics-1
###### Header six example
*Text written in italics*
**Strongly emphasized text**
**Text with combined _emphasis_**
~~Strokethrough text~~

1. First thing in an ordered list
2. Second thing in an ordered list
3. Third thing in an ordered list

* First thing in an unordered list
+ Second thing in an unordered list
- Third thing in an unordered list

First column | Second column
------------ | -------------
First row cell 1 | First row cell 2
Second row cell 1 | Second row cell 2

# Listing of VHDL source code
```VHDL 
-- (this is a VHDL comment)
/*
    this is a block comment (VHDL-2008)
*/
-- import std_logic from the IEEE library
library IEEE;
use IEEE.std_logic_1164.all;

-- this is the entity
entity ANDGATE is
  port ( 
    I1 : in std_logic;
    I2 : in std_logic;
    O  : out std_logic);
end entity ANDGATE;

-- this is the architecture
architecture RTL of ANDGATE is
begin
  O <= I1 and I2;
end architecture RTL;
```
