----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/18/2026 12:31:38 PM
-- Design Name: 
-- Module Name: extension_unit - Behavioral
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

entity extension_unit is
  Port ( 
    imm_val : in std_logic_vector(31 downto 7);
    imm_sel : in std_logic_vector(2 downto 0);
    extended_instr : out std_logic_vector(31 downto 0)
  );
end extension_unit;

architecture Behavioral of extension_unit is
begin
    process(imm_val, imm_sel) is
    begin
    
    case imm_sel is
        -- I-type
        when "010" =>
            extended_instr <= (31 downto 12 => imm_val(31)) & imm_val(31 downto 20);
        -- S-type
        when "100" =>
            extended_instr <= (31 downto 12 => imm_val(31)) & imm_val(31 downto 25) & imm_val(11 downto 7);
        -- B-type
        when "101" =>
            extended_instr <= (31 downto 13 => imm_val(31)) & imm_val(31) & imm_val(7) & imm_val(30 downto 25) & imm_val(11 downto 8) & '0';
        -- U-type
        when "011" =>
            extended_instr <= imm_val(31 downto 12) & (11 downto 0 => '0');
        -- J-type
        when "110" =>  
            extended_instr <= (31 downto 21 => imm_val(31)) & imm_val(31) & imm_val(19 downto 12) & imm_val(20) & imm_val(30 downto 21) & '0';
        -- otherwise
        when others =>
            extended_instr <= (others => '0');
    end case;
    end process;


end Behavioral;
