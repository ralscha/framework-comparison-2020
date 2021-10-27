apt update
apt dist-upgrade -y
apt-get remove docker docker-engine docker.io containerd runc -y
apt install git screen apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y
    
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
apt-key fingerprint 0EBFCD88
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update
apt-get install docker-ce docker-ce-cli containerd.io


git clone https://github.com/ralscha/framework-comparison-2020.git
cd framework-comparison-2020

curl -fsSL https://deb.nodesource.com/setup_17.x | sudo -E bash -
sudo apt-get install -y nodejs

wget https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.1%2B12/OpenJDK17U-jdk_x64_linux_hotspot_17.0.1_12.tar.gz
tar xzf OpenJDK17U-jdk_x64_linux_hotspot_17.0.1_12.tar.gz
rm OpenJDK17U-jdk_x64_linux_hotspot_17.0.1_12.tar.gz
mv jdk-17.0.1+12 openjdk

wget https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-21.3.0/graalvm-ce-java17-linux-amd64-21.3.0.tar.gz
tar xzf graalvm-ce-java17-linux-amd64-21.3.0.tar.gz
rm graalvm-ce-java17-linux-amd64-21.3.0.tar.gz
apt-get install build-essential libz-dev zlib1g-dev -y
mv graalvm-ce-java17-21.3.0 graal
export JAVA_HOME=`pwd`/graal
PATH=$JAVA_HOME/bin:$PATH
gu install native-image

wget https://github.com/grafana/k6/releases/download/v0.34.1/k6-v0.34.1-linux-amd64.tar.gz
tar xzf k6-v0.34.1-linux-amd64.tar.gz
mv k6-v0.34.1-linux-amd64/k6 .
rm -fr k6-*

wget https://golang.org/dl/go1.17.2.linux-amd64.tar.gz
tar xzf go1.17.2.linux-amd64.tar.gz
rm go1.17.2.linux-amd64.tar.gz

npm install

cd springboot
./mvnw -Pnative-image package
 mv target/com.example.springboot.demoapplication ../springboot-runner
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

./go/bin/go build -o goexample go/go-example.go

cd go-fibre
../go/bin/go build -o gofibre go-example.go
cp gofibre ..
cd ..

cd go-echo
../go/bin/go build -o goecho go-example.go
cp goecho ..
cd ..

