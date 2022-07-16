WANGY WANGY GENERATOR IN ASSEMBLY

Sebuah program copypasta wangy-wangy waifu yang dibuat dalam bahasa assembly.
Credit line wangy : https://nakaramatya.github.io/wangytools.github.io/#

Program akan menghasilkan sebuah file copypasta sesuai nama yang diinput.
File yang dihasilkan program tidak auto overwrite sehingga harus dihapus terlebih dahulu jika ingin generate file baru
file yang di generate memiliki nama "wangy_generated.txt"

program dirun di linux menggunakan nasm

CARA RUN PROGRAM
1. nasm -f elf64 -g -F dwarf -o wangy.o wangy.asm
2. ld -o wangy wangy.o
3. ./wangy