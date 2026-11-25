------------------------------------------------------------------------
-- University  : University of Alberta
-- Course      : ECE 410
-- Project     : Lab 3
-- File        : single_cycle_riscv.vhdl
-- Authors     : Antonio Alejandro Andara Lara
-- Date        : 23-Oct-2025
------------------------------------------------------------------------
-- Description  : Top-level RISC-V CPU combining single-cycle datapath and control logic.
--                Executes basic load, store, and arithmetic instructions.
------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY single_cycle_riscv IS
    PORT (
        clock     : IN STD_LOGIC;
        out_data : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE Structural OF single_cycle_riscv IS
    SIGNAL zero_flag, negative_flag, borrow_flag    : STD_LOGIC                     := '0';
    SIGNAL pc, pc_next                              : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
    SIGNAL instruction, imm_ext, alu_result         : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
    SIGNAL rs1_data, rs2_data, rd_data              : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
    SIGNAL data_mem_we                              : STD_LOGIC;
    SIGNAL reg_file_we                              : STD_LOGIC;
    SIGNAL buffer_en                                : STD_LOGIC;
    SIGNAL imm_bit                                  : STD_LOGIC;
    SIGNAL alu_mux_ctrl, result_mux_ctrl            : STD_LOGIC;
    SIGNAL funct3                                   : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL extend_ctrl                              : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL alu_ctrl                                 : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL opcode                                   : STD_LOGIC_VECTOR(6 DOWNTO 0);
    SIGNAL branch_en                                : STD_LOGIC;

BEGIN

    datapath : ENTITY work.lw_sw_datapath(structural)
        PORT MAP(
            clock => clock,
            data_mem_we => data_mem_we,
            reg_file_we => reg_file_we,
            alu_mux_ctrl => alu_mux_ctrl,
            result_mux_ctrl => result_mux_ctrl,
            buffer_en => buffer_en,
            extend_ctrl => extend_ctrl,
            alu_ctrl => alu_ctrl,
            opcode => opcode,
            funct3 => funct3,
            imm_bit => imm_bit,
            zero_flag => zero_flag,
            negative_flag => negative_flag,
            borrow_flag => borrow_flag,
            out_data   => out_data,
            branch_en => branch_en
        );

    control_unit : ENTITY work.controller(behavioral)
        PORT MAP(
            opcode => opcode,
            funct3 => funct3,
            imm_bit => imm_bit,
            zero_flag => zero_flag,
            negative_flag => negative_flag,
            borrow_flag => borrow_flag,
            alu_mux_ctrl => alu_mux_ctrl,
            result_mux_ctrl => result_mux_ctrl,
            data_mem_we => data_mem_we,
            reg_file_we => reg_file_we,
            buffer_en => buffer_en,
            extend_ctrl => extend_ctrl,
            alu_ctrl => alu_ctrl,
            branch_en => branch_en
        );
END Structural;
