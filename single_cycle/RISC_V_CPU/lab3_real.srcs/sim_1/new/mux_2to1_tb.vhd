----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/19/2026 06:12:46 PM
-- Design Name: 
-- Module Name: mux_2to1_tb - Behavioral
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

entity mux_2to1_tb is
end mux_2to1_tb;

architecture Behavioral of mux_2to1_tb is
    signal in0, in1, out_y   : STD_LOGIC_VECTOR(31 DOWNTO 0) := (others => '0');
    signal sel               : STD_LOGIC := '0';
begin
    DUT: ENTITY work.mux_2to1(Behavioral)
        PORT MAP (
            in0 => in0,
            in1 => in1,
            out_y => out_y,
            sel => sel
        );

    process is
    begin
        in0 <= (others => '1');
        in1 <= (others => '0');
        sel <= '0';
    
        wait for 4 ns;
        sel <= '1';
        
        wait;
    end process;

end Behavioral;
