# script to help generation of MMI file
set all_rom_blocks [get_cells -hierarchical -filter { PRIMITIVE_TYPE =~ BMEM.bram.*  &&  NAME =~  "*u_ahb_rom*" }]
puts "# Block ram description"
puts "---"
puts "bram:"
foreach block $all_rom_blocks {
    puts "- NAME:  [get_property NAME $block]"
    puts "  SITE: [get_property SITE $block]"
    puts "  READ_WIDTH_A: [get_property READ_WIDTH_A $block]"
}
