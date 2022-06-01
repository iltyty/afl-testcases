WORK_DIR=/home/lulu/projects/measurement

cd ${WORK_DIR}
git clone git@github.com:iltyty/afl-testcases

cd ${WORK_DIR}/sqlite

# git clone git@github.com:sqlite/sqlite

mkdir build
cd build
../configure
sed -i -e "23c BCC = afl-gcc -g -O2" -e "31c CC = afl-gcc" Makefile
make

cp -r ${WORK_DIR}/afl-testcases/sqlite/input ..

cd ..
screen afl-fuzz -i input -o output ./build/sqlite3
