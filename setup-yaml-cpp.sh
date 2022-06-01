WORK_DIR=/home/lulu/projects/measurement

# set afl
cd ${WORK_DIR}
./setup-afl.sh

# clone yaml-cpp project
cd ${WORK_DIR}
git clone git@github.com:jbeder/yaml-cpp
cd yaml-cpp
mkdir output
mkdir build && cd build
cmake -DCMAKE_CXX_COMPILER=afl-g++ ..
make

# clone yaml-fuzz project to get test cases
cd ${WORK_DIR}
git clone git@github.com:brandonprry/yaml-fuzz
cp -r ./yaml-fuzz/min_testcases ./yaml-cpp/input

sudo sh -c "echo core > /proc/sys/kernel/core_pattern"
cd /sys/devices/system/cpu
sudo sh -c "echo performance | tee cpu*/cpufreq/scaling_governor"

sudo pacman -S screen

cd ${WORK_DIR}/yaml-cpp
ls
screen afl-fuzz -i input -o output ./build/util/parse
