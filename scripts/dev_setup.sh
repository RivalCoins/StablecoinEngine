sudo echo "Please input root password: "

# Install Go
wget https://dl.google.com/go/go1.15.6.linux-amd64.tar.gz

export GOROOT=$PWD/go-install

export GOPATH=$PWD/go-workspace
echo "export GOPATH=\"$GOPATH\"" >> ~/.bashrc
mkdir -p $GOPATH

export GOBIN=$GOROOT/bin
echo "export GOBIN=\"$GOBIN\"" >> ~/.bashrc

export PATH=$PATH:$GOBIN
echo "PATH=\"$PATH\"" >> ~/.bashrc

tar -xzf go1.15.6.linux-amd64.tar.gz
mv go $GOROOT

# Install Glide
curl https://glide.sh/get | sh

# Install Yarn
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update && sudo apt install -y yarn

# Clone repo
mkdir -p $GOPATH/src/github.com/stellar/kelp
cd $GOPATH/src/github.com/stellar/kelp

git clone https://github.com/stellar/kelp.git .

# Install dependencies
glide install

# Install astilectron-bundler
go get -u github.com/asticode/go-astilectron-bundler/...

# Build
./scripts/build.sh

# Confirm build
./bin/kelp version