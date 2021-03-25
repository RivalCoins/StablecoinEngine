# Install pre-requisites
sudo apt update && apt install -y wget curl sudo git gnupg gnupg1 gnupg2 unzip zip

# Install Go
GO_PACKAGE=go1.15.6.linux-amd64.tar.gz
wget https://dl.google.com/go/$GO_PACKAGE

export GOROOT=$PWD/go-install

export GOPATH=$PWD/go-workspace
echo "export GOPATH=\"$GOPATH\"" >> ~/.bashrc
mkdir -p $GOPATH

export GOBIN=$GOROOT/bin
echo "export GOBIN=\"$GOBIN\"" >> ~/.bashrc

export PATH=$PATH:$GOBIN
echo "PATH=\"$PATH\"" >> ~/.bashrc

tar -xzf $GO_PACKAGE
rm $GO_PACKAGE
mv go $GOROOT

# Install Glide
wget https://github.com/Masterminds/glide/releases/download/v0.13.3/glide-v0.13.3-linux-amd64.tar.gz
tar -xvf glide-v0.13.3-linux-amd64.tar.gz
cp linux-amd64/glide /bin/glide
rm -rf linux-amd64 glide-v0.13.3-linux-amd64.tar.gz

# Install Yarn
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update && sudo apt install -y yarn

# Clone repo
mkdir -p $GOPATH/src/github.com/stellar/kelp
cd $GOPATH/src/github.com/stellar/kelp

git clone https://github.com/RivalCoins/StablecoinEngine.git .

# Install dependencies
glide install

# Install astilectron-bundler
go get -u github.com/asticode/go-astilectron-bundler/...

# Dev Build
./scripts/build.sh

# Confirm dev build
./bin/kelp version

# Production build
export AMPLITUDE_API_KEY=foobar
echo "export AMPLITUDE_API_KEY=\"$AMPLITUDE_API_KEY\"" >> ~/.bashrc
./scripts/build.sh -d -f

# Confirm production build
echo "Confirm production build in the 'build' directory"
