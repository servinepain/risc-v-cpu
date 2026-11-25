------------------------------------------------------------------------
-- University  : University of Alberta
-- Course      : ECE 410
-- Project     : Lab 3
-- File        : adder_32.vhdl
-- Authors     : Andrew Letts and Zachary Ren
-- Date        : November 19, 2026
------------------------------------------------------------------------
-- Description : Testbench for 32-bit adder (basic version, no carry or overflow)
------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

ENTITY adder_32_tb IS
END ENTITY;

architecture Behavioral of adder_32_tb is
    signal op_a, op_b   :   STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal adder_out    :   STD_LOGIC_VECTOR(31 downto 0);
 
begin

    DUT: ENTITY work.adder_32(Behavioral) 
        PORT MAP (
            op_a => op_a,
            op_b => op_b,
            sum => adder_out
        );
    
    process is
    begin
        for i in 0 to 10 loop 
            for j in 0 to 10 loop
                op_a <= std_logic_vector(TO_UNSIGNED(i, 32));
                op_b <= std_logic_vector(TO_UNSIGNED(j, 32));
                wait for 5 ns;
            end loop;
        end loop;
        
        wait;
    end process;

end Behavioral;
