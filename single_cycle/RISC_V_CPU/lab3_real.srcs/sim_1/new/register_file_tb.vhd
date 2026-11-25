----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/19/2026 05:17:31 PM
-- Design Name: 
-- Module Name: register_file_tb - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;


entity register_file_tb is
end register_file_tb;

architecture Behavioral of register_file_tb is
    signal clock, rd_we                 : STD_LOGIC := '0';
    signal rs1_addr, rs2_addr, rd_addr  : STD_LOGIC_VECTOR(4 DOWNTO 0) := (others => '0');
    signal rd_data, rs1_data, rs2_data  : STD_LOGIC_VECTOR(31 DOWNTO 0) := (others => '0');

begin

    DUT: ENTITY work.register_file(behavioral) PORT MAP (
        clock => clock,
        rs1_addr => rs1_addr,
        rs2_addr => rs2_addr,
        rd_addr => rd_addr,
        rd_data => rd_data,
        rs1_data => rs1_data,
        rs2_data => rs2_data,
        rd_we => rd_we
    );
    
    clock <= not clock after 2 ns;
    
    process
    begin
    
    wait for 1 ns;
    
    -- Test - Write to two addresses
    rd_we <= '1';
    rd_addr <= "11110";
    rd_data <= x"12345678";
    wait for 4 ns;
    
    rd_addr <= "10001";
    rd_data <= x"87654321";
    wait for 4 ns;
    
    -- Test Reads
    rd_we <= '0';
    rs1_addr <= "11110";
    rs2_addr <= "10001";
    
    wait;
    end process;


end Behavioral;
