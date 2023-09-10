mkdir -p ~/f1tenth_ws/src
cd f1tenth_ws/

sudo apt-get update
rosdep install -r --from-paths src --ignore-src --rosdistro=${ROS_DISTRO} -y

sudo pip install cython
cd src

git clone http://github.com/kctess5/range_libc

pip install 2to3
pip install autopep8
pip install black


2to3 -W range_libc/
black range_libc/
autopep8 --in-place --recursive range_libc/


cd range_libc/pywrapper

# # on VM
./compile.sh
# # on car - compiles GPU ray casting methods
# ./compile_with_cuda.sh
 
cd ..
cd ..

git clone https://github.com/mit-racecar/particle_filter.git

2to3 -W particle_filter/

cd ..

catkin_make

source devel/setup.bash