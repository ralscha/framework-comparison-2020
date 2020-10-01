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

curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt-get install -y nodejs

wget https://github.com/AdoptOpenJDK/openjdk15-binaries/releases/download/jdk-15%2B36/OpenJDK15U-jdk_x64_linux_hotspot_15_36.tar.gz
tar xzf OpenJDK15U-jdk_x64_linux_hotspot_15_36.tar.gz
rm OpenJDK15U-jdk_x64_linux_hotspot_15_36.tar.gz

wget https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-20.2.0/graalvm-ce-java11-linux-amd64-20.2.0.tar.gz
tar xzf graalvm-ce-java11-linux-amd64-20.2.0.tar.gz
rm graalvm-ce-java11-linux-amd64-20.2.0.tar.gz
apt-get install build-essential libz-dev zlib1g-dev -y
export JAVA_HOME=`pwd`/graalvm-ce-java11-20.2.0
PATH=$JAVA_HOME/bin:$PATH
gu install native-image

wget https://github.com/loadimpact/k6/releases/download/v0.27.1/k6-v0.27.1-linux64.tar.gz
tar xzf k6-v0.27.1-linux64.tar.gz
mv k6-v0.27.1-linux64/k6 .
rm -fr k6-*

wget https://golang.org/dl/go1.15.2.linux-amd64.tar.gz
tar xzf go1.15.2.linux-amd64.tar.gz
rm go1.15.2.linux-amd64.tar.gz

npm install

cd micronaut-example
./mvnw clean package
cd target
native-image --no-server -cp micronaut.jar
cp micronaut ../..
cd ../..

cd quarkus-example
mv src/main/resources/application.properties .
./mvnw clean package -Pnative
cp target/quarkus-runner ..
mv application.properties src/main/resources/
cd ..

export JAVA_HOME=`pwd`/jdk-15+36
PATH=$JAVA_HOME/bin:$PATH

cd spring-example
./mvnw clean package
cp target/springboot.jar ..
cd ..

cd micronaut-example
./mvnw clean package
cp target/micronaut.jar ..
cd ..

cd quarkus-example
./mvnw clean package
cp target/quarkus-runner.jar ..
cd ..

./go/bin/go build -o goexample go-example/go-example.go

cd go-fibre-example
../go/bin/go build -o gofibreexample go-example.go
cp gofibreexample ..
cd ..


