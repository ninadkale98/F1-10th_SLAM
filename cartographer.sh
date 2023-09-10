sudo apt-get update
sudo apt-get install -y python3-wstool python3-rosdep ninja-build stow

mkdir cartographer_ws
cd cartographer_ws
wstool init src
wstool merge -t src https://raw.githubusercontent.com/cartographer-project/cartographer_ros/master/cartographer_ros.rosinstall
wstool update -t src


package_xml_path="src/cartographer/package.xml"

line_number=46

# Check if the package.xml file exists
if [ -f "$package_xml_path" ]; then
    # Delete the specified line from the package.xml file
    sed -i "${line_number}d" "$package_xml_path"
    echo "Line $line_number deleted from $package_xml_path"
else
    echo "Error: $package_xml_path does not exist."
fi

sudo rosdep init
rosdep update
rosdep install --from-paths src --ignore-src --rosdistro=${ROS_DISTRO} -y

src/cartographer/scripts/install_abseil.sh

catkin_make_isolated --install --use-ninja

source install_isolated/setup.bash

git clone https://github.com/ninadkale98/cartographer.git

cp cartographer/*.launch install_isolated/share/cartographer_ros/launch/

cp cartographer/*.lua install_isolated/share/cartographer_ros/configuration_files/

rm -r cartographer
