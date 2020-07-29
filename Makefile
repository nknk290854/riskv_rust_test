GCC_HEAD=riscv32-unknown-elf
OBJDUMP=${GCC_HEAD}-objdump
OBJCOPY=${GCC_HEAD}-objcopy
BSP=riscv32imac-unknown-none-elf

TARGET=target/${BSP}/debug/hello
all: build lst


build:
	env CC=${GCC_HEAD}-gcc cargo build

lst:
	${OBJCOPY} -g ${TARGET} hello.img
	${OBJDUMP} -D ${TARGET} >aaa.lst

qemu:
	qemu-system-riscv32 -nographic -machine sifive_e -kernel ${TARGET}

qemu2:
	qemu-system-riscv32 -nographic -machine sifive_e -kernel ${TARGET} -S -s

gdb:
	$(GCC_HEAD)-gdb ${TARGET}

clean:
	cargo clean
