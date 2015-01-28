run: get_sign.o
	klee --emit-all-errors --libc=uclibc get_sign.o
	ls klee-last/
	./demo.sh
get_sign.o: get_sign.c
	llvm-gcc --emit-llvm -c -g get_sign.c -I/vagrant/klee/include
clean:
	rm -rf klee-out-* klee-last
