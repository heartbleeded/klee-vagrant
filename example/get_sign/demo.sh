#!/bin/bash
export LD_LIBRARY_PATH=/vagrant/klee/Release+Asserts/lib/:$LD_LIBRARY_PATH
for file in $(ls klee-last/test*.ktest); do
  ktest-tool --write-ints $file
  # gcc -L /vagrant/klee/Release+Asserts/lib/ -I/vagrant/klee/include get_sign.c -lkleeRuntest
  # KTEST_FILE=$file ./a.out
  echo $?
done
# ktest-tool --write-ints klee-last/test000001.ktest
# ktest-tool --write-ints klee-last/test000002.ktest
# ktest-tool --write-ints klee-last/test000003.ktest
