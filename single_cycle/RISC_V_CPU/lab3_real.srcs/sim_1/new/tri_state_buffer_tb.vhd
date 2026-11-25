----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/19/2026 06:32:15 PM
-- Design Name: 
-- Module Name: tri_state_buffer_tb - Behavioral
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

entity tri_state_buffer_tb is
end tri_state_buffer_tb;

architecture Behavioral of tri_state_buffer_tb is
    signal output_en                    : STD_LOGIC := '0';
    signal buffer_input, buffer_output  : STD_LOGIC_VECTOR(31 DOWNTO 0) := (others => '0');
begin
    DUT: ENTITY work.tri_state_buffer(Behavioral)
        PORT MAP (
            output_en => output_en,
            buffer_input => buffer_input,
            buffer_output => buffer_output
        );
    
    test: process
    begin
        -- Test 1: buffer_output = 0 when enabled
        output_en <= '1';
        buffer_input <= (others =>'0');
        wait for 10 ns;
        
        -- Test 2: buffer_output = 1 when enabled
        output_en <= '1';
        buffer_input <= (others => '1');
        wait for 10 ns;
        
        -- Test 3: buffer_output = Z
        output_en <= '0';
        buffer_input <= (others => '1');
        wait for 10 ns;
        
        wait;
    end process;

end Behavioral;
