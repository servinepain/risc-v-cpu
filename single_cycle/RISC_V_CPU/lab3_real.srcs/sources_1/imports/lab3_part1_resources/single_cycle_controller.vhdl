------------------------------------------------------------------------
-- University  : University of Alberta
-- Course      : ECE 410
-- Project     : Lab 3
-- File        : single_cycle_controller.vhdl
-- Authors     : Antonio Alejandro Andara Lara
-- Date        : 23-Oct-2025
------------------------------------------------------------------------
-- Description  : Single-cycle control unit for a simple RISC-V processor.
--                Decodes alu_ctrl, funct3, and funct7 fields to generate
--                ALU, memory, and register control signals.
------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY controller IS
    PORT (
        opcode          : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
        funct3          : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        imm_bit         : IN STD_LOGIC;
        zero_flag       : IN STD_LOGIC;
        negative_flag   : IN STD_LOGIC;
        borrow_flag     : IN STD_LOGIC;
        alu_mux_ctrl    : OUT STD_LOGIC;
        result_mux_ctrl : OUT STD_LOGIC;
        data_mem_we     : OUT STD_LOGIC;
        reg_file_we     : OUT STD_LOGIC;
        buffer_en       : OUT STD_LOGIC;
        extend_ctrl     : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        alu_ctrl        : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        branch_en       : OUT STD_LOGIC
    );
END controller;

ARCHITECTURE Behavioral OF controller IS
    -- "controls" is a compact control word encoding all the main control signals.
    -- Bit mapping (from MSB to LSB):
    --   [9]   - Selects ALU B operand source (0 = register, 1 = immediate)
    --   [8]   - Selects write-back data source (0 = ALU result, 1 = memory read)
    --   [7]   - Enables register file write
    --   [6]   - Enables data memory write
    --   [5:3] - Selects immediate format depending on the instruction type (I, S, etc.)
    --   [2:0] - ALU control operation code
    --
    -- Each instruction assigns a 10-bit pattern to "controls" that defines its full
    -- control behavior in a single line using the WITH-SELECT statement below.
    SIGNAL controls     : STD_LOGIC_VECTOR(9 DOWNTO 0);

    -- added for visibility in simulation
    TYPE instruction IS (LW, SW, ADD, BEQ, BNE, BLT, BGE, BLTU, BGEU, NOP);
    SIGNAL instr : instruction := NOP;
    SIGNAL aux          : STD_LOGIC_VECTOR(10 DOWNTO 0);

    -- Instruction alu_ctrls. add new values for each instruction
    CONSTANT alu_ctrl_LW  : STD_LOGIC_VECTOR(6 DOWNTO 0)  := "0000011";
    CONSTANT alu_ctrl_SW  : STD_LOGIC_VECTOR(6 DOWNTO 0)  := "0100011";
    CONSTANT alu_ctrl_ADD : STD_LOGIC_VECTOR(6 DOWNTO 0)  := "0110011";
    CONSTANT branch_ctrl  : STD_LOGIC_VECTOR(6 DOWNTO 0)  := "1100011";

    -- Control signals per instruction
    CONSTANT CTRL_LW  : STD_LOGIC_VECTOR(9 DOWNTO 0) := "1110010100";
    CONSTANT CTRL_SW  : STD_LOGIC_VECTOR(9 DOWNTO 0) := "1101100100";
    CONSTANT CTRL_ADD : STD_LOGIC_VECTOR(9 DOWNTO 0) := "0010011100";
    CONSTANT CTRL_NOP : STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
    CONSTANT CTRL_BEQ : STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000101101";
    CONSTANT CTRL_BNE : STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000101101";
    CONSTANT CTRL_BLT : STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000101110";
    CONSTANT CTRL_BGE : STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000101110";
    CONSTANT CTRL_BLTU: STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000101111";
    CONSTANT CTRL_BGEU: STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000101111";
    
BEGIN
    buffer_en <= '1';
    aux <= imm_bit & funct3 & opcode;

    decode : PROCESS (opcode, funct3, imm_bit, zero_flag, negative_flag, borrow_flag)
    BEGIN
        controls <= CTRL_NOP; -- default assignment
        branch_en <= '0';
        
        CASE opcode IS
            WHEN alu_ctrl_LW =>
                instr <= LW;
                controls <= CTRL_LW;
            WHEN alu_ctrl_SW =>
                instr <= SW;
                controls <= CTRL_SW;
            WHEN alu_ctrl_ADD =>
                IF funct3 = "000" AND imm_bit = '0' THEN
                    instr <= ADD;
                    controls <= CTRL_ADD;
                END IF;
            WHEN branch_ctrl =>
                IF funct3 = "000" THEN
                    instr <= BEQ;
                    controls <= CTRL_BEQ;
                    branch_en <= zero_flag;
                ELSIF funct3 = "001" THEN
                    instr <= BNE;
                    controls <= CTRL_BNE;
                    branch_en <= not zero_flag;
                ELSIF funct3 = "100" THEN
                    instr <= BLT;
                    controls <= CTRL_BLT;
                    branch_en <= negative_flag;
                ELSIF funct3 = "101" THEN
                    instr <= BGE;
                    controls <= CTRL_BGE;
                    branch_en <= not negative_flag;
                ELSIF funct3 = "110" THEN
                    instr <= BLTU;
                    controls <= CTRL_BLTU;
                    branch_en <= borrow_flag;
                ELSIF funct3 = "111" THEN
                    instr <= BGEU;
                    controls <= CTRL_BGEU;
                    branch_en <= not borrow_flag;
                END IF;
                
            WHEN OTHERS =>
                instr <= NOP;
                controls <= CTRL_NOP;
        END CASE;
    END PROCESS;

    -- controller output assignments
    alu_mux_ctrl <= controls(9);
    result_mux_ctrl <= controls(8);
    reg_file_we <= controls(7);
    data_mem_we <= controls(6);
    extend_ctrl  <= controls(5 DOWNTO 3);
    alu_ctrl <= controls(2 DOWNTO 0);

END Behavioral;
