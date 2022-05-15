apt update
apt dist-upgrade -y
apt-get remove docker docker-engine docker.io containerd runc -y
apt install git screen apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt update
apt install docker-ce -y

git clone https://github.com/ralscha/framework-comparison-2020.git
cd framework-comparison-2020

curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
apt-get install -y nodejs

wget https://github.com/adoptium/temurin18-binaries/releases/download/jdk-18.0.1%2B10/OpenJDK18U-jdk_x64_linux_hotspot_18.0.1_10.tar.gz
tar xzf OpenJDK18U-jdk_x64_linux_hotspot_18.0.1_10.tar.gz
rm OpenJDK18U-jdk_x64_linux_hotspot_18.0.1_10.tar.gz
mv jdk-18.0.1+10 openjdk

wget https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-22.1.0/graalvm-ce-java17-linux-amd64-22.1.0.tar.gz
tar xzf graalvm-ce-java17-linux-amd64-22.1.0.tar.gz
rm graalvm-ce-java17-linux-amd64-22.1.0.tar.gz
apt-get install build-essential libz-dev zlib1g-dev -y
mv graalvm-ce-java17-22.1.0 graal
export JAVA_HOME=`pwd`/graal
PATH=$JAVA_HOME/bin:$PATH
gu install native-image

wget https://github.com/grafana/k6/releases/download/v0.38.2/k6-v0.38.2-linux-amd64.tar.gz
tar xzf k6-v0.38.2-linux-amd64.tar.gz
mv k6-v0.38.2-linux-amd64/k6 .
rm -fr k6-*

wget https://go.dev/dl/go1.18.2.linux-amd64.tar.gz
tar xzf go1.18.2.linux-amd64.tar.gz
rm go1.18.2.linux-amd64.tar.gz

npm install

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

./go/bin/go build -o goexample go/go-example.go

cd go-fibre
../go/bin/go build -o gofibre go-example.go
cp gofibre ..
cd ..

cd go-echo
../go/bin/go build -o goecho go-example.go
cp goecho ..
cd ..

