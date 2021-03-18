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

curl -sL https://deb.nodesource.com/setup_15.x | sudo -E bash -
sudo apt-get install -y nodejs

wget https://github.com/AdoptOpenJDK/openjdk16-binaries/releases/download/jdk-16%2B36/OpenJDK16-jdk_x64_linux_hotspot_16_36.tar.gz
tar xzf OpenJDK16-jdk_x64_linux_hotspot_16_36.tar.gz
rm OpenJDK16-jdk_x64_linux_hotspot_16_36.tar.gz
mv jdk-16+36 openjdk

wget https://github.com/AdoptOpenJDK/openjdk16-binaries/releases/download/jdk-16%2B36_openj9-0.25.0/OpenJDK16-jre_x64_linux_openj9_16_36_openj9-0.25.0.tar.gz
tar xzf OpenJDK16-jre_x64_linux_openj9_16_36_openj9-0.25.0.tar.gz
rm OpenJDK16-jre_x64_linux_openj9_16_36_openj9-0.25.0.tar.gz
mv jdk-16+36-jre openj9

wget https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-21.0.0.2/graalvm-ce-java11-linux-amd64-21.0.0.2.tar.gz
tar xzf graalvm-ce-java11-linux-amd64-21.0.0.2.tar.gz
rm graalvm-ce-java11-linux-amd64-21.0.0.2.tar.gz
apt-get install build-essential libz-dev zlib1g-dev -y
export JAVA_HOME=`pwd`/graalvm-ce-java11-21.0.0.2
PATH=$JAVA_HOME/bin:$PATH
gu install native-image

wget https://github.com/loadimpact/k6/releases/download/v0.31.1/k6-v0.31.1-linux64.tar.gz
tar xzf k6-v0.31.1-linux64.tar.gz
mv k6-v0.31.1-linux64/k6 .
rm -fr k6-*

wget https://golang.org/dl/go1.16.2.linux-amd64.tar.gz
tar xzf go1.16.2.linux-amd64.tar.gz
rm go1.16.2.linux-amd64.tar.gz

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

export JAVA_HOME=`pwd`/openjdk
PATH=$JAVA_HOME/bin:$PATH

cd springboot
chmod 700 mvnw
./mvnw clean package
cp target/springboot.jar ..
cd ..

cd micronaut
./mvnw clean package
cp target/micronaut-0.1.jar ../micronaut.jar
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

