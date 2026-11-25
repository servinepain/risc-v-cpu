----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/19/2026 07:33:37 PM
-- Design Name: 
-- Module Name: alu_tb - Behavioral
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity alu_tb is
end alu_tb;

architecture Behavioral of alu_tb is
    signal src_a, src_b, result     :  STD_LOGIC_VECTOR(31 DOWNTO 0) := (others => '0');
    signal alu_ctrl                  :  STD_LOGIC_VECTOR(2 DOWNTO 0) := "000";
    signal zero_flag                 :  STD_LOGIC := '0';
begin
    DUT: ENTITY work.alu(Behavioral) PORT MAP (
        src_a => src_a,
        src_b => src_b,
        alu_ctrl => alu_ctrl,
        result => result,
        zero_flag => zero_flag
       );
       
    process
    begin
        -- Test: AND
        alu_ctrl <= "001";
        src_a <= (others => '0');
        src_b <= (others => '0');
        wait for 5 ns;
        
        src_a <= (others => '0');
        src_b <= (others => '1');
        wait for 5 ns;
        
        src_a <= (others => '1');
        src_b <= (others => '1');
        wait for 5 ns;
        
        -- Test: OR
        alu_ctrl <= "010";
        src_a <= (others => '0');
        src_b <= (others => '0');
        wait for 5 ns;
        
        src_a <= (others => '0');
        src_b <= (others => '1');
        wait for 5 ns;
        
        src_a <= (others => '1');
        src_b <= (others => '1');
        wait for 5 ns;
        
        -- Test: XOR
        alu_ctrl <= "011";
        src_a <= (others => '0');
        src_b <= (others => '0');
        wait for 5 ns;
        
        src_a <= (others => '0');
        src_b <= (others => '1');
        wait for 5 ns;
        
        src_a <= (others => '1');
        src_b <= (others => '1');
        wait for 5 ns;
        
        src_a <= (others => '0');
        src_b <= (others => '0');
        
        -- Test: addition
        alu_ctrl <= "100";
        src_a(3 downto 0) <= "1111";
        src_b(3 downto 0) <= "0111";
        wait for 5 ns;
        
        -- Test: subtraction
        alu_ctrl <= "101";
        src_a(3 downto 0) <= "1111";
        src_b(3 downto 0) <= "0111";
        wait for 5 ns;
        
        -- Test: others
        alu_ctrl <= "111";
        wait;
    end process;

end Behavioral;
