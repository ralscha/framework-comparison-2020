apt update
apt dist-upgrade -y
apt install git -y
git clone https://github.com/ralscha/framework-comparison-2020.git
cd framework-comparison-2020

curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt-get install -y nodejs

wget https://github.com/AdoptOpenJDK/openjdk14-binaries/releases/download/jdk-14.0.1%2B7/OpenJDK14U-jdk_x64_linux_hotspot_14.0.1_7.tar.gz
tar xzf OpenJDK14U-jdk_x64_linux_hotspot_14.0.1_7.tar.gz
rm OpenJDK14U-jdk_x64_linux_hotspot_14.0.1_7.tar.gz

wget https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-20.1.0/graalvm-ce-java11-linux-amd64-20.1.0.tar.gz
tar xzf graalvm-ce-java11-linux-amd64-20.1.0.tar.gz
rm graalvm-ce-java11-linux-amd64-20.1.0.tar.gz
apt-get install build-essential libz-dev zlib1g-dev -y
export JAVA_HOME=`pwd`/graalvm-ce-java11-20.1.0
PATH=$JAVA_HOME/bin:$PATH
gu install native-image

npm install
npm run build_native
export JAVA_HOME=`pwd`/jdk-14.0.1+7
PATH=$JAVA_HOME/bin:$PATH
npm run build
npm run time
npm run time
npm run time

wget https://github.com/loadimpact/k6/releases/download/v0.26.2/k6-v0.26.2-linux64.tar.gz
tar xzf k6-v0.26.2-linux64.tar.gz
mv k6-v0.26.2-linux64/k6 .
rm -fr k6-*

source ./run_k6.sh