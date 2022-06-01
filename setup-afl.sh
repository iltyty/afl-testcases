wget http://lcamtuf.coredump.cx/afl.tgz
tar xfz afl.tgz
rm afl.tgz
afl_dir=`find . -type d -iname "afl-*" | sort | head -1`
cd ${afl_dir}
make
echo "Provide sudo password for sudo make install"
sudo make install
PATH="$PATH:`pwd`/${afl_dir}"

