apt update
apt dist-upgrade -y
apt install git screen ca-certificates curl gnupg build-essential libz-dev zlib1g-dev -y

curl https://sh.rustup.rs -sSf | sh -s -- -q -y
source "$HOME/.cargo/env"

git clone https://github.com/ralscha/framework-comparison-2020.git
cd framework-comparison-2020

mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
NODE_MAJOR=20
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
apt-get update
apt-get install nodejs -y

wget https://github.com/adoptium/temurin21-binaries/releases/download/jdk-21.0.1%2B12/OpenJDK21U-jdk_x64_linux_hotspot_21.0.1_12.tar.gz
tar xzf OpenJDK21U-jdk_x64_linux_hotspot_21.0.1_12.tar.gz
rm OpenJDK21U-jdk_x64_linux_hotspot_21.0.1_12.tar.gz
mv jdk-21.0.1+12 openjdk

wget https://download.oracle.com/graalvm/21/latest/graalvm-jdk-21_linux-x64_bin.tar.gz
tar xzf graalvm-jdk-21_linux-x64_bin.tar.gz
rm graalvm-jdk-21_linux-x64_bin.tar.gz
mv graalvm-jdk-21.0.1+12.1 graalvm

wget https://github.com/grafana/k6/releases/download/v0.48.0/k6-v0.48.0-linux-amd64.tar.gz
tar xzf k6-v0.48.0-linux-amd64.tar.gz
mv k6-v0.48.0-linux-amd64/k6 .
rm -fr k6-*

wget https://go.dev/dl/go1.21.5.linux-amd64.tar.gz
tar xzf go1.21.5.linux-amd64.tar.gz
rm go1.21.5.linux-amd64.tar.gz

npm install

cd rust
cargo build -r
cp target/release/salvodemo ../rustdemo
cd ..

export GRAALVM_HOME="/root/framework-comparison-2020/graalvm"
export PATH="/root/framework-comparison-2020/graalvm/bin:$PATH"
export JAVA_HOME="/root/framework-comparison-2020/graalvm"

cd springboot
./mvnw -Pnative -DskipTests clean package
cp target/springboot ../springboot-runner
cd ..

cd micronaut
./mvnw clean package -Dpackaging=native-image
cp target/micronaut ../micronaut-runner
cd ..

cd quarkus
./mvnw clean package -Pnative
cp target/quarkus-0.0.1-runner ../quarkus-runner
cd ..

export JAVA_HOME=`pwd`/openjdk
PATH=$JAVA_HOME/bin:$PATH

cd springboot
./mvnw clean package
cp target/springboot.jar ../springboot.jar
cd ..


cd micronaut
./mvnw clean package
cp target/micronaut-0.1.jar ../micronaut.jar
cd ..

cd quarkus
./mvnw clean package
cp target/quarkus-app .. -r
cd ..

./go/bin/go build -ldflags='-s' -o goexample go/go-example.go

cd go-fibre
../go/bin/go build -ldflags='-s' -o gofibre go-example.go
cp gofibre ..
cd ..

cd go-echo
../go/bin/go build -ldflags='-s' -o goecho go-example.go
cp goecho ..
cd ..

