# Micronaut 2.0.0  vs Quarkus 1.5.2 vs Spring Boot 2.3.1 on JDK 14 and GraalVM Native Image

This repo contains a performance comparison between Micronaut 2.0 vs Quarkus 1.5.2 vs Spring Boot 2.3.1 on JDK 14 and GraalVM Native Image.    

### Setup

```
apt update
apt dist-upgrade
apt install git
git clone https://github.com/ralscha/framework-comparison-2020.git
cd framework-comparison-2020
```

Install Node.js and Java (Ubuntu 20.04)

```
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt-get install -y nodejs

wget https://github.com/AdoptOpenJDK/openjdk14-binaries/releases/download/jdk-14.0.1%2B7/OpenJDK14U-jdk_x64_linux_hotspot_14.0.1_7.tar.gz
tar xzf OpenJDK14U-jdk_x64_linux_hotspot_14.0.1_7.tar.gz
rm OpenJDK14U-jdk_x64_linux_hotspot_14.0.1_7.tar.gz
```


Install GraalVM
```
wget https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-20.1.0/graalvm-ce-java11-linux-amd64-20.1.0.tar.gz
tar xzf graalvm-ce-java11-linux-amd64-20.1.0.tar.gz
rm graalvm-ce-java11-linux-amd64-20.1.0.tar.gz
apt-get install build-essential libz-dev zlib1g-dev
export JAVA_HOME=`pwd`/graalvm-ce-java11-20.1.0
PATH=$JAVA_HOME/bin:$PATH
gu install native-image
```


To setup run
```
npm install
``` 

Build native images
```
npm run build_native
```


Switch to AdoptOpenJDK and build jars
```
export JAVA_HOME=`pwd`/jdk-14.0.1+7
PATH=$JAVA_HOME/bin:$PATH
npm run build
```

Measure time to first response with:
```
npm run time
```

Download k6
```
wget https://github.com/loadimpact/k6/releases/download/v0.26.2/k6-v0.26.2-linux64.tar.gz
tar xzf k6-v0.26.2-linux64.tar.gz
mv k6-v0.26.2-linux64/k6 .
rm -fr k6-*
```

Run K6 and measure memory usage

```
java -jar micronaut.jar &
./k6 run k6.js
ps x -o rss,vsz,command | grep java
pkill java

java -jar quarkus-runner.jar &
./k6 run k6.js
ps x -o rss,vsz,command | grep java
pkill java

java -jar springboot.jar &
./k6 run k6.js
ps x -o rss,vsz,command | grep java
pkill java

./micronaut &
./k6 run k6.js
ps x -o rss,vsz,command | grep micronaut
pkill micronaut

./quarkus-runner &
./k6 run k6.js
ps x -o rss,vsz,command | grep quarkus-runner
pkill quarkus-runner
```


### Results

| METRIC  | Micronaut 2.0.0  | Quarkus 1.5.2  | Spring Boot 2.3.1  |
|---|---|---|---|
| Test Time (./mvnw test) (ms)   | **7_145**  | 8_773  | 10_880   |
| Jar Size in Bytes    | **13_657_879**  | 17_590_561  | 20_067_300  |
| Native Image in Bytes |  57_650_136 | **34_557_432** | - |
| Time to First Response (ms) Java   |  1_665  | **1_599**  | 3_547 |
| Time to First Response (ms) Native   | 69   |  **41**  | - |
| K6: Requests per second Java   | **14_148**  | 11_020  | 12_683  |
| K6: Number of Requests Java   | **4_244_742**   | 3_306_254  | 3_805_113  |   
| Memory Consumption After K6 (RSS in kB) Java  | 641_596  | **468_936** | 676_400 |
| K6: Requests per second Native   | **10_270** |  8_870 | -  |
| K6: Number of Requests Native   | **3_081_161**  | 2_661_400  | - |
| Memory Consumption After K6 (RSS in kB) Native  | **468_328**  | 660_052  | - |


Tests ran on a Hetzner VPS CX41 (4 VCPU, 16 GB RAM)      
OS: Ubuntu Server 20.04     
4 July 2020





