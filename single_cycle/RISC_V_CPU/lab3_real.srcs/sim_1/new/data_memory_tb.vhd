----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/19/2026 06:44:12 PM
-- Design Name: 
-- Module Name: data_memory_tb - Behavioral
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

entity data_memory_tb is
end data_memory_tb;

architecture Behavioral of data_memory_tb is
    signal address, write_data, data    :   STD_LOGIC_VECTOR(31 DOWNTO 0) := (others => '0');
    signal write_en, clock              :   STD_LOGIC := '0';
begin

    DUT: ENTITY work.data_mem(rtl) PORT MAP (
        address => address,
        write_data => write_data,
        data => data,
        write_en => write_en,
        clock => clock
    );
    
    clock <= not clock after 2 ns;
    
    process
    begin
        wait for 1 ns;
        write_en <= '0';
        address(3 DOWNTO 0) <= "0100";
        
        wait for 4 ns;
        address(3 DOWNTO 0) <= "1000";
        
        wait for 4 ns;
        address(3 DOWNTO 0) <= "1100";
        
        wait for 4 ns;
        write_en <= '1';
        write_data <= x"87654321";
        
        wait for 4 ns;
        write_en <= '0';
        
        wait;
    end process;   
    

end Behavioral;
