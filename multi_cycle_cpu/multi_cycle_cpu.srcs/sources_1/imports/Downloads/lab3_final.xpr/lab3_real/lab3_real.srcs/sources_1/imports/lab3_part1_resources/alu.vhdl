------------------------------------------------------------------------
-- University  : University of Alberta
-- Course      : ECE 410
-- Project     : Lab 3
-- File        : alu.vhdl
-- Authors     : Antonio Alejandro Andara Lara
-- Date        : 23-Oct-2025
------------------------------------------------------------------------
-- Description  : 32-bit ALU performing AND, OR, XOR, ADD, and SUB
--                3-bit control signal (alu_ctrl).
--                'zero_flag' = '1' when result = 0.
------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY alu IS
    PORT (
        src_a         : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        src_b         : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        alu_ctrl      : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        result        : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        zero_flag     : OUT STD_LOGIC;
        negative_flag : OUT STD_LOGIC;
        borrow_flag   : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE Behavioral OF alu IS
    SIGNAL alu_out : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
    SIGNAL src_sub_u : STD_LOGIC_VECTOR(32 DOWNTO 0) := (OTHERS => '0');
BEGIN
    result    <= alu_out;
    zero_flag <= '1' WHEN alu_out = x"00000000" ELSE '0';
    negative_flag <= '1' WHEN alu_out(31) = '1' ELSE '0';
    borrow_flag <= '1' WHEN src_sub_u(32) = '1' ELSE '0';
    src_sub_u <= STD_LOGIC_VECTOR(UNSIGNED('0' & src_a) - UNSIGNED('0' & src_b));

    WITH alu_ctrl SELECT
        alu_out <=
        src_a AND src_b                                     WHEN "001",
        src_a OR src_b                                      WHEN "010",
        src_a XOR src_b                                     WHEN "011",
        STD_LOGIC_VECTOR(UNSIGNED(src_a) + UNSIGNED(src_b)) WHEN "100",
        STD_LOGIC_VECTOR(UNSIGNED(src_a) - UNSIGNED(src_b)) WHEN "101",
        STD_LOGIC_VECTOR(SIGNED(src_a) - SIGNED(src_b)) WHEN "110",
        src_sub_u(31 downto 0) WHEN "111",
        (OTHERS => '0') WHEN OTHERS;

END Behavioral;
