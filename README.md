# vslam_env

## how
1. container setup
./docker_setup.sh 

2. enter container
docker start vslam_runner
docker attach vslam_runner

3. compile orb-slam3
git clone git@github.com:UZ-SLAMLab/ORB_SLAM3.git
find_package(OpenCV 3.0)->find_package(OpenCV 3.4) // in CMakelists.txt
cd ORB_SLAM3
./build.sh

4. compile vins-fusion
cd ~/catkin_ws/src
git clone https://github.com/HKUST-Aerial-Robotics/VINS-Fusion.git
cd ../
catkin_make
source ~/catkin_ws/devel/setup.bash
