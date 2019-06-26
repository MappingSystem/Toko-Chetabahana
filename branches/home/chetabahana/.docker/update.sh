#GCLOUD
export CLOUD_SDK_REPO=cloud-sdk-`lsb_release -c -s`
echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt-get update
sudo apt-get --assume-yes install google-cloud-sdk
gcloud init

#GITHUB
#ssh-keygen -t rsa -b 4096 -C "chetabahana@gmail.com"
sudo apt-get update
sudo apt-get --assume-yes install expect

#PIP
sudo apt-get update
sudo apt install python3-pip
sudo apt-get --assume-yes install python3-venv

#GCSFUSE
export GCSFUSE_REPO=gcsfuse-`lsb_release -c -s`
echo "deb http://packages.cloud.google.com/apt $GCSFUSE_REPO main" | sudo tee /etc/apt/sources.list.d/gcsfuse.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt-get update
sudo apt-get install gcsfuse
sudo sed -i 's|#user_allow_other|user_allow_other|g' /etc/fuse.conf

#TRANSIFEX
sudo apt-get update
sudo apt-get --assume-yes install transifex-client
tx init --token=1/7ecd38ed5a68a0c26e6216139be8ad460f9c0d4d --skipsetup --no-interactive
cat /home/chetabahana/.transifexrc

#OTHERS
sudo apt-get update
sudo apt-get --assume-yes install jq
sudo apt-get --assume-yes install nmap

#DOCKER
sudo apt-get update
sudo apt-get --assume-yes install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get --assume-yes install docker-ce docker-ce-cli containerd.io
apt-cache madison docker-ce
VERSION_STRING="5:18.09.3~3-0~ubuntu-bionic"
sudo apt-get install docker-ce=$VERSION_STRING \
docker-ce-cli=$VERSION_STRING containerd.io
sudo apt autoremove
sudo docker run hello-world

sudo usermod -aG docker ${USER}
sudo systemctl enable docker
sudo systemctl edit docker.service

sudo systemctl daemon-reload
sudo systemctl restart docker.service
sudo systemctl is-active docker
sudo netstat -lntp | grep dockerd
sudo usermod -g docker ${USER}
logout

#COMPOSE
DESTINATION=/usr/local/bin/docker-compose
SOURCE=https://github.com/docker/compose/releases/download
VERSION=`curl -s https://api.github.com/repos/docker/compose/releases/latest | jq .name -r`
RELEASE="$SOURCE/$VERSION/docker-compose-$(uname -s)-$(uname -m)"
sudo curl -L $RELEASE -s -o $DESTINATION && sudo chmod +x $DESTINATION
docker-compose --version

#CREDENTIALS
VERSION=1.5.0
OS=linux  # or "darwin" for OSX, "windows" for Windows.
ARCH=amd64  # or "386" for 32-bit OSs
URL=https://github.com/GoogleCloudPlatform/docker-credential-gcr/releases/download/v
curl -fsSL "${URL}${VERSION}/docker-credential-gcr_${OS}_${ARCH}-${VERSION}.tar.gz" \
  | tar xz --to-stdout ./docker-credential-gcr \
  > ~/docker-credential-gcr && chmod +x ~/docker-credential-gcr
sudo mv docker-credential-gcr /usr/bin/
docker-credential-gcr version
docker-credential-gcr configure-docker
docker login --username=chetabahana --password=DavSHxmRUJbzc5S
docker login r.cfcr.io -u Chetabahana -p 8773b320f9aecc567499cf119bd82766
cat /home/chetabahana_gmail_com/.docker/config.json