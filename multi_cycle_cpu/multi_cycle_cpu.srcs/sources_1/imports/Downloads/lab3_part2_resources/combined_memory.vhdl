------------------------------------------------------------------------
-- University  : University of Alberta
-- Course      : ECE 410
-- Project     : Lab 3
-- File        : data_memory.vhdl
-- Authors     : Antonio Alejandro Andara Lara
-- Date        : 23-Oct-2025
------------------------------------------------------------------------
-- Description  : 1 KB data memory with 32-bit read/write interface.
--                Supports synchronous writes and asynchronous reads.
------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY combined_mem IS
    PORT (
        clock      : IN STD_LOGIC;
        write_en   : IN STD_LOGIC;
        address    : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        write_data : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        data       : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE rtl OF combined_mem IS

    -- Byte-addressable RAM
    TYPE memory_data IS ARRAY (0 TO 1023) OF STD_LOGIC_VECTOR(7 DOWNTO 0);

    SIGNAL RAM : memory_data := (
        --------------------------------------------------
        -- PROGRAM
        --------------------------------------------------
        0 => x"83", 1 => x"23", 2 => x"00", 3 => x"10",     -- lw x7, 256(x0)
        4 => x"03", 5 => x"24", 6 => x"40", 7 => x"10",     -- lw x8, 260(x0)
        8 => x"33", 9 => x"03", 10 => x"73", 11 => x"00",   -- add x6, x6, x7
        12 => x"23", 13 => x"24", 14 => x"60", 15 => x"10", -- sw x6, 264(x0)
        16 => x"63", 17 => x"04", 18 => x"83", 19 => x"00", -- beq x6, x8, 8
        20 => x"E3", 21 => x"0A", 22 => x"00", 23 => x"FE", -- beq x0, x0, -12
        24 => x"03", 25 => x"25", 26 => x"80", 27 => x"10", -- lw x10, 264(x0)

        --------------------------------------------------
        -- DATA
        --------------------------------------------------
        256 => x"01", 257 => x"00", 258 => x"00", 259 => x"00", -- x"00000001"
        260 => x"05", 261 => x"00", 262 => x"00", 263 => x"00", -- x"00000005"
        OTHERS => (OTHERS => '0')
    );
    SIGNAL addr_int : INTEGER := 0;

BEGIN
    addr_int <= to_integer(unsigned(address(9 DOWNTO 0))); -- Address conversion fits 1 KB

    PROCESS (clock)
    BEGIN
        IF rising_edge(clock) AND write_en = '1' THEN
            RAM(addr_int)     <= write_data(7 DOWNTO 0);
            RAM(addr_int + 1) <= write_data(15 DOWNTO 8);
            RAM(addr_int + 2) <= write_data(23 DOWNTO 16);
            RAM(addr_int + 3) <= write_data(31 DOWNTO 24);
        END IF;
    END PROCESS;

    -- read 4 consecutive bytes form one 32-bit word
    data <= RAM(addr_int + 3) &
            RAM(addr_int + 2) &
            RAM(addr_int + 1) &
            RAM(addr_int);

END ARCHITECTURE rtl;
