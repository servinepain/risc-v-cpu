----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/19/2026 08:21:05 PM
-- Design Name: 
-- Module Name: instruction_memory_tb - Behavioral
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

entity instruction_memory_tb is
end instruction_memory_tb;

architecture Behavioral of instruction_memory_tb is
    signal address, data : STD_LOGIC_VECTOR(31 DOWNTO 0) := (others => '0');
begin
    DUT: ENTITY work.instr_mem(rtl) PORT MAP (
        address => address,
        data => data
    );

    process 
    begin
        address(3 downto 0) <= "0000";
        wait for 4 ns;
        address(3 downto 0) <= "0100";
        wait for 4 ns;
        address(3 downto 0) <= "1000";
        wait for 4 ns;
        address(3 downto 0) <= "1100";
        wait;
    end process;
end Behavioral;
