ENTRY(Reset_handler)

MEMORY
{
    FLASH(rx):ORIGIN =0x08000000,LENGTH =256K
    SRAM(rwx):ORIGIN =0x20000000,LENGTH =64K
    
}

SECTIONS
{
    .text :
    {
        *(.isr_vector)
        *(.text)
        *(.text.*)
        *(.rodata)
        *(.rodata.*)
        . = ALIGN(4);
        _etext = .; /* linker symbol storing the value of end address of text */
    }> FLASH
    
    _la_data = LOADADDR(.data);
    .data :
    {
        _sdata = .; /* linker symbol storing the value of start address of data */
        *(.data)
        *(.data.*)
        . = ALIGN(4);
        _edata = .;
    }> SRAM AT> FLASH
    
    .bss :
    {
        _sbss = .;
        __bss_start__ = _sbss;
        *(.bss)
        *(.bss.*)
        *(COMMON)
        . = ALIGN(4);
        _ebss = .;
        __bss_end__ = _ebss;
        . = ALIGN(4);
        end = .;
        __end__ = .;
    }> SRAM
}
