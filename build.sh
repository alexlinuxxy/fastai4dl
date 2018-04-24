#!/bin/sh

#!/usr/bin/env bash

set -e
set -o xtrace
DEBIAN_FRONTEND=noninteractive
apt update
apt install unzip -y

# rm /etc/apt/apt.conf.d/*.*
# apt -y upgrade --force-yes -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold"
# apt -y autoremove
# ufw allow 8888:8898/tcp
# apt -y install --force-yes -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" qtdeclarative5-dev qml-module-qtquick-controls
# add-apt-repository ppa:graphics-drivers/ppa -y
# apt update

mkdir downloads
cd ~/downloads/
wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_9.0.176-1_amd64.deb
dpkg -i cuda-repo-ubuntu1604_9.0.176-1_amd64.deb
apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub
apt update
apt install cuda -y
wget http://files.fast.ai/files/cudnn-9.1-linux-x64-v7.tgz
tar xf cudnn-9.1-linux-x64-v7.tgz
cp cuda/include/*.* /usr/local/cuda/include/
cp cuda/lib64/*.* /usr/local/cuda/lib64/
wget https://repo.continuum.io/archive/Anaconda3-5.0.1-Linux-x86_64.sh
bash Anaconda3-5.0.1-Linux-x86_64.sh -b
cd
git clone https://github.com/fastai/fastai.git
cd fastai/
echo 'export PATH=~/anaconda3/bin:$PATH' >> ~/.bashrc
export PATH=~/anaconda3/bin:$PATH
source ~/.bashrc
conda env update
echo 'source activate fastai' >> ~/.bashrc
source activate fastai
source ~/.bashrc
cd ..
mkdir data
cd data
wget http://files.fast.ai/data/dogscats.zip
unzip -q dogscats.zip
cd ../fastai/courses/dl1/
ln -s ~/data ./
jupyter notebook --generate-config
echo "c.NotebookApp.ip = '*'" >> ~/.jupyter/jupyter_notebook_config.py
echo "c.NotebookApp.open_browser = False" >> ~/.jupyter/jupyter_notebook_config.py
pip install ipywidgets
jupyter nbextension enable --py widgetsnbextension --sys-prefix
echo
echo ---
echo - Fastai Install Done.
echo ---
