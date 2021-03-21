# MIT License

# Copyright (c) 2020 Joseph Auckley, Matthew O'Kelly, Aman Sinha, Hongrui Zheng

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# base the rest of the container off the Stable Baselines 3 image
FROM stablebaselines/rl-baselines3-zoo:latest

RUN DEBIAN_FRONTEND="noninteractive" apt-get update --fix-missing && \
    DEBIAN_FRONTEND="noninteractive" apt-get install -y \
    python3-dev python3-pip

RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y nano \
                       git \
                       unzip \
                       build-essential \
                       autoconf \
                       libtool \
                       cmake \
                       vim

RUN pip3 install --upgrade pip

RUN pip3 install numpy \
                 scipy \
                 numba \
                 Pillow \
                 gym \
                 pyyaml \
                 pyglet

# this isn't necessary, just a hack to make the terminal look better...
RUN useradd -m Team-1 -u 1000 -g 0

# create home directory for code files
ENV HOME /home/Team-1

# copy repo from local computer into container
COPY . /home/Team-1

# install F110 Gym
RUN cd /home/Team-1 && \
    pip3 install -e gym/

# open container in home folder
WORKDIR /home/Team-1

# opens terminal when container starts
ENTRYPOINT ["/bin/bash"]
