/* RISC-V for P2 linker script, Rust version */

/* memory layout: the P2 Eval board has 512K of RAM, and 1 MB of flash
   the flash is not used yet
 */
MEMORY
{
  RAM : ORIGIN = 0x00000000, LENGTH = 512K
  FLASH : ORIGIN = 0x80000000, LENGTH = 1024K
}

/* always input this file */
INPUT(p2jit.o)

OUTPUT_FORMAT("elf32-littleriscv")

ENTRY(_start)

SECTIONS
{
  .jitinterp ORIGIN(RAM) :
  {
      KEEP(*(.jitinterp))
  } > RAM
  .text           :
  {
    *(.text .stub .text.* .gnu.linkonce.t.*)
    *(.text.unlikely .text.*_unlikely .text.unlikely.*)
    *(.text.exit .text.exit.*)
    *(.text.startup .text.startup.*)
    *(.text.hot .text.hot.*)
  } > RAM
  
  /DISCARD/ : { *(.note.GNU-stack) *(.gnu_debuglink) *(.gnu.lto_*) }
}
