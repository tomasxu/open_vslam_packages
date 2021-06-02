FROM ubuntu:16.04


# ------------------------------------------------------------------------------------------
# Definitions
ENV CERES_VERSION="1.12.0"
ENV OPENCV_VERSION 3.4.14
ENV OPENCV_DOWNLOAD_URL https://github.com/opencv/opencv/archive/$OPENCV_VERSION.zip
ENV OpenCV_DIR opencv-$OPENCV_VERSION
ENV EIGEN_VERSION 3.3.2
ENV EIGEN_DOWNLOAD_URL http://bitbucket.org/eigen/eigen/get/$EIGEN_VERSION.tar.gz

RUN if [ "x$(nproc)" = "x1" ] ; then export USE_PROC=1 ; \
      else export USE_PROC=$(($(nproc)/2)) ; fi

# ------------------------------------------------------------------------------------------
# [1] General Dependencies
RUN echo "[Dockerfile Info] Installing GENERAL Dependencies ......"
RUN apt-get update && apt-get install -y \
	 	build-essential \
		cmake \
		pkg-config \
		htop \
		gedit \
        vim \
		wget \
		git \
		unzip \
		curl \
		software-properties-common
		
# ------------------------------------------------------------------------------------------                                 
# [2] Ros
RUN echo "[Dockerfile Info] Installing ros kinetic ......"
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' && \
    apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654 && \
    apt-get update && apt-get install -y \
        ros-kinetic-desktop-full && \
    rosdep init && \
    rosdep update

# ------------------------------------------------------------------------------------------                                 
# [2] OpenCV

RUN echo "[Dockerfile Info] Installing OPENCV Dependencies ......"
RUN apt-get update && apt-get install -y \
	build-essential \
	libgtk2.0-dev\
	libavcodec-dev\
	libavformat-dev\ 
	libswscale-dev \
	python3.5-dev \
	python3-numpy \
	libtbb2 \
	libtbb-dev
	
RUN apt-add-repository "deb http://security.ubuntu.com/ubuntu xenial-security main"
RUN apt-get update && apt-get install -y \
	libjasper1\
	libjasper-dev \
	libjpeg-dev \
	libpng-dev \
	libtiff5-dev \
	libjasper-dev \
	libdc1394-22-dev \
	libeigen3-dev \
	libtheora-dev \
	libvorbis-dev \
	libxvidcore-dev \
	libx264-dev \
	sphinx-common \
	libtbb-dev \
	yasm \
	libfaac-dev \
	libopencore-amrnb-dev \
	libopencore-amrwb-dev \
	libopenexr-dev \
	libgstreamer-plugins-base1.0-dev \
	libavutil-dev \
	libavfilter-dev \
	libboost-thread-dev \
	libavresample-dev

RUN echo "[Dockerfile Info] Installing OPENCV ......"
RUN cd /opt && \
	wget "$OPENCV_DOWNLOAD_URL" && \
	unzip 3.4.14.zip && \
	cd opencv-3.4.14 && \
	mkdir build
RUN cd /opt/opencv-3.4.14/build && \ 
	cmake -D CMAKE_BUILD_TYPE=RELEASE -D WITH_CUDA=OFF -D WITH_OPENGL=OFF .. && \
	make -j8 && \
	make install

	
# ------------------------------------------------------------------------------------------
# [3] Pangolin
RUN echo "[Dockerfile Info] Installing PNGOLIN Dependencies ......"
RUN apt-get update && apt-get install -y \
		libgl1-mesa-dev \
		libglew-dev \
		libpython2.7-dev \
		ffmpeg libavcodec-dev libavutil-dev libavformat-dev libswscale-dev libavdevice-dev \
		libdc1394-22-dev libraw1394-dev \		
		libjpeg-dev libpng12-dev libtiff5-dev libopenexr-dev

RUN echo "[Dockerfile Info] Installing PNGOLIN ......"
RUN mkdir -p ~/pangolin && \
		cd ~/pangolin && \
		git clone https://github.com/stevenlovegrove/Pangolin.git && \
		cd Pangolin && \
		mkdir build && \
		cd build && \
		cmake .. && \
		cmake --build .	

# ------------------------------------------------------------------------------------------
# [3] Ceres Solver
RUN echo "[Dockerfile Info] Installing Ceres Solver Dependencies ......"
RUN apt-get update && apt-get install -y \
	libsuitesparse-dev \
	libgoogle-glog-dev  \
    libgflags-dev   \
    libatlas-base-dev   \
    libeigen3-dev   \
    python-catkin-tools 

RUN echo "[Dockerfile Info] Installing Ceres Solver ......"
RUN mkdir -p ~/Ceres && \
		cd ~/Ceres && \
		git clone https://ceres-solver.googlesource.com/ceres-solver && \
		cd ceres-solver && \
		git checkout tags/${CERES_VERSION} && \
		mkdir build && cd build && \
        cmake .. && \
        make -j$(USE_PROC) install

# ------------------------------------------------------------------------------------------
# [4] Eigen3
RUN echo "[Dockerfile Info] Installing EIGEN3 Dependencies ......"
# none 
RUN echo "[Dockerfile Info] Installing EIGEN3 ......"
RUN mkdir -p ~/eigen3 && \
	cd ~/eigen3 && \
	git clone https://github.com/libigl/eigen.git && \
	cd eigen && \
	mkdir build_dir && \
	cd build_dir && \
  	cmake ../ && \
  	make install


# ------------------------------------------------------------------------------------------
# [5] Orb-slam3

RUN apt-get update && apt-get install -y \
	libpcap-dev \
	libssl-dev

# ------------------------------------------------------------------------------------------
# [5] VINS-Fusion



CMD ["/bin/bash"]
