#0 0 1 * * sh /home/ubuntu/.config/apt-get.sh

#LINUX
#https://cloud.google.com/compute/docs/instances/linux-guest-environment
sudo apt-add-repository universe && sudo apt-get update
declare -a PKG_LIST=(python-google-compute-engine \
python3-google-compute-engine \
google-compute-engine-oslogin \
gce-compute-image-packages)
for pkg in ${PKG_LIST[@]}; do
   sudo apt install -y $pkg || echo "Not available: $pkg"
done

#GCLOUD
#https://cloud.google.com/sdk/docs/quickstart-debian-ubuntu
export CLOUD_SDK_REPO=cloud-sdk-`lsb_release -c -s`
echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | \
sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt-get update && sudo apt-get --assume-yes install google-cloud-sdk
gcloud config list

#ETC
sudo apt-get update
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin
sudo apt-get --assume-yes install jq
sudo apt-get --assume-yes install nmap
sudo apt-get --assume-yes install expect
sudo apt-get --assume-yes install golang-go
sudo apt-get --assume-yes install redis-tools #redis-cli monitor

#COMPOSE
DESTINATION=/usr/local/bin/docker-compose
SOURCE=https://github.com/docker/compose/releases/download
VERSION=`curl -s https://api.github.com/repos/docker/compose/releases/latest | jq .name -r`
RELEASE="$SOURCE/$VERSION/docker-compose-$(uname -s)-$(uname -m)"
sudo curl -L $RELEASE -s -o $DESTINATION && sudo chmod +x $DESTINATION
docker-compose --version

#DOCKER
#https://docs.docker.com/install/linux/docker-ce/ubuntu/
sudo apt-get remove docker docker-engine docker.io containerd runc
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
VERSION_STRING=`apt-cache madison docker-ce | grep ubuntu-bionic | head -1 | cut -d'|' -f2`
sudo apt-get install docker-ce=$VERSION_STRING \
docker-ce-cli=$VERSION_STRING containerd.io
sudo docker run hello-world

sudo usermod -aG docker ${USER}
sudo systemctl enable docker
sudo systemctl edit docker.service

sudo systemctl daemon-reload
sudo systemctl restart docker.service
sudo systemctl is-active docker
sudo netstat -lntp | grep dockerd
sudo usermod -g docker ${USER}

sudo apt --assume-yes autoremove
sudo reboot
exit 1

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
cat /home/chetabahana/.docker/config.json

#HOOK
go get github.com/bketelsen/captainhook
mkdir -p ~/.go/config/captainhook
sudo cat << EOF > /etc/systemd/system/captainhook.service
[Unit]
Description=Captainhook service
After=network.target

[Service]
Type=simple
RestartSec=1
Restart=always
User=chetabahana
StartLimitBurst=5
StartLimitIntervalSec=10
ExecStart=~/.go/bin/captainhook -listen-addr=0.0.0.0:8080 -echo -configdir ~/.go/config/captainhook

[Install]
WantedBy=multi-user.target
EOF
sudo systemctl enable captainhook
sudo systemctl start captainhook

#TRANSIFEX
sudo apt-get update
sudo apt-get --assume-yes install transifex-client
tx init --token=1/7ecd38ed5a68a0c26e6216139be8ad460f9c0d4d --skipsetup --no-interactive
cat /home/chetabahana/.transifexrc
