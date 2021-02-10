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
```
library IEEE;
use IEEE.std_logic_1164.all;

--entita název je, definice vstupů, výstupů
entity gates is 
	port{
    	a_i{	: in std_logic;
        b_i{	: in std_logic;
        for_o{	: out std_logic;
        fand_o{	: out std_logic;
        fxor_o{	: out std_logic
        };
end entity gate;
--_i se značí vstup, _o výstup

--popis co se děje v dvojbranu
architecture dataflow of gates is--dataflow se používá, je to název
begin
	for_o <= a_i_ or b_i:-- definice funkce or
    fand_o <= a_i_ and b_i:--definice funkce and
    fxor_o <= a_i_ xor b_i:
end architecture dataflow;
```
