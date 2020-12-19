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

wget https://github.com/AdoptOpenJDK/openjdk15-binaries/releases/download/jdk-15.0.1%2B9/OpenJDK15U-jdk_x64_linux_hotspot_15.0.1_9.tar.gz
tar xzf OpenJDK15U-jdk_x64_linux_hotspot_15.0.1_9.tar.gz
rm OpenJDK15U-jdk_x64_linux_hotspot_15.0.1_9.tar.gz

wget https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-20.3.0/graalvm-ce-java11-linux-amd64-20.3.0.tar.gz
tar xzf graalvm-ce-java11-linux-amd64-20.3.0.tar.gz
rm graalvm-ce-java11-linux-amd64-20.3.0.tar.gz
apt-get install build-essential libz-dev zlib1g-dev -y
export JAVA_HOME=`pwd`/graalvm-ce-java11-20.3.0
PATH=$JAVA_HOME/bin:$PATH
gu install native-image

wget https://github.com/loadimpact/k6/releases/download/v0.29.0/k6-v0.29.0-linux64.tar.gz
tar xzf k6-v0.29.0-linux64.tar.gz
mv k6-v0.29.0-linux64/k6 .
rm -fr k6-*

wget https://golang.org/dl/go1.15.6.linux-amd64.tar.gz
tar xzf go1.15.6.linux-amd64.tar.gz
rm go1.15.6.linux-amd64.tar.gz

npm install

cd micronaut
chmod 700 mvnw
./mvnw clean package -Dpackaging=native-image
cp target/micronaut ../micronaut-runner
cd ..

cd quarkus
mv src/main/resources/application.properties .
chmod 700 mvnw
./mvnw clean package -Pnative
cp target/quarkus-runner ..
mv application.properties src/main/resources/
cd ..

export JAVA_HOME=`pwd`/jdk-15.0.1+9
PATH=$JAVA_HOME/bin:$PATH

cd springboot
chmod 700 mvnw
./mvnw clean package
cp target/springboot.jar ..
cd ..

cd micronaut
./mvnw clean package
cp target/micronaut.jar ..
cd ..

cd quarkus
./mvnw clean package
cp target/quarkus-runner.jar ..
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

