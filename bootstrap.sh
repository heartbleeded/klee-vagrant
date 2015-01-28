function install {
  echo installing $1
  shift
  sudo apt-get -y install "$@"
}

sudo apt-get -y update

install 'development tools' build-essential
install 'git' git
install 'deps listed on klee' g++ curl dejagnu subversion bison flex bc libcap-dev
install 'deps listed on blog post' python-minimal git bison flex bc libcap-dev build-essential libboost-all-dev ncurses-dev cmake

install 'llvm runtime' llvm-runtime clang

wget -qnc http://llvm.org/releases/2.9/llvm-gcc4.2-2.9-x86_64-linux.tar.bz2
tar -jxvf llvm-gcc4.2-2.9-x86_64-linux.tar.bz2

export C_INCLUDE_PATH=/usr/include/x86_64-linux-gnu
export CPLUS_INCLUDE_PATH=/usr/include/x86_64-linux-gnu
export PATH=$PATH:$HOME/llvm-gcc4.2-2.9-x86_64-linux/bin

echo "export C_INCLUDE_PATH=/usr/include/x86_64-linux-gnu" >> ~/.bashrc
echo "export CPLUS_INCLUDE_PATH=/usr/include/x86_64-linux-gnu" >> ~/.bashrc
echo "export PATH=$PATH:$HOME/llvm-gcc4.2-2.9-x86_64-linux/bin" >> ~/.bashrc

wget -qnc http://llvm.org/releases/2.9/llvm-2.9.tgz
tar -zxvf llvm-2.9.tgz
cd llvm-2.9

wget -qnc http://www.mail-archive.com/klee-dev@imperial.ac.uk/msg01302/unistd-llvm-2.9-jit.patch
patch -p1 < unistd-llvm-2.9-jit.patch

./configure --enable-optimized --enable-assertions
make
cd $HOME

wget -qnc http://www.doc.ic.ac.uk/~cristic/klee/stp-r940.tgz
tar xzfv stp-r940.tgz
cd stp-r940

tar xzfv stp-r940.tgz
cd stp-r940
./scripts/configure --with-prefix=`pwd`/install --with-cryptominisat2
make OPTIMIZE=-O2 CFLAGS_M32= install
sudo ldconfig
ulimit -s unlimited
cd

# git clone https://github.com/stp/stp.git
# cd stp
# mkdir build && cd build
# cmake -G 'Unix Makefiles' $HOME/stp
# make
# sudo make install
# sudo ldconfig
# ulimit -s unlimited
# cd $HOME

git clone --depth 1 --branch klee_0_9_29 https://github.com/klee/klee-uclibc.git
cd klee-uclibc/
./configure --with-llvm-config $HOME/llvm-2.9/Release+Asserts/bin/llvm-config --make-llvm-lib
make -j`nproc`
cd $HOME

git clone https://github.com/klee/klee.git
cd klee
./configure --enable-posix-runtime --with-stp=$HOME/stp-r940/install --with-llvm=$HOME/llvm-2.9/ --with-uclibc=$HOME/klee-uclibc/

make ENABLE_OPTIMIZED=1
make check
make unittests
sudo make install
cd $HOME

echo 'all set, rock on!'
