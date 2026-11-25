------------------------------------------------------------------------
-- University  : University of Alberta
-- Course      : ECE 410
-- Project     : Lab 3
-- File        : program_counter_tb.vhdl
-- Authors     : Andrew Letts and Zachary Ren
-- Date        : November 19, 2026
------------------------------------------------------------------------
-- Description : Testbench for the program counter.
------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

entity program_counter_tb is
end program_counter_tb;

architecture Behavioral of program_counter_tb is
    signal clock            :       std_logic := '0';
    signal pc_next, pc_out  :       std_logic_vector (31 DOWNTO 0) := (others => '0');
begin

    clock <= not clock after 2 ns;
    DUT: ENTITY work.program_counter(behavioral)
        PORT MAP (
            clock => clock,
            pc_next => pc_next,
            pc_out => pc_out
        );

    process
    begin
        wait for 2 ns;
        for i in 0 to 10 loop
            pc_next <= std_logic_vector(TO_UNSIGNED(i, 32));
            wait for 8 ns;
        end loop;
    wait;
    end process;
        

end Behavioral;
