# Kernel
bcc -ansi -c -o kernel.o kernel.c
as86 kernel.asm -o kernel_asm.o
ld86 -o kernel -d kernel.o kernel_asm.o

# Shell
bcc -ansi -c -o shell.o shell.c
as86 lib.asm -o lib.o
ld86 -o shell -d shell.o lib.o

# loadFile
gcc -o loadFile loadFile.c

dd if=/dev/zero of=floppya.img bs=512 count=2880
dd if=bootload of=floppya.img bs=512 count=1 conv=notrunc
dd if=kernel of=floppya.img bs=512 conv=notrunc seek=3
dd if=map.img of=floppya.img bs=512 count=1 seek=1 conv=notrunc
dd if=dir.img of=floppya.img bs=512 count=1 seek=2 conv=notrunc
dd if=message.txt of=floppya.img bs=512 count=1 seek=30 conv=notrunc

./loadFile message.txt
#./loadFile tstprg
#./loadFile tstpr2

#./loadFile shell
