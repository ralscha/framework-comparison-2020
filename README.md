# Micronaut 2.0.0  vs Quarkus 1.5.2 vs Spring Boot 2.3.1 on JDK 14

This repo contains a performance comparison between Micronaut 2.0 vs Quarkus 1.5.2 vs Spring Boot 2.3.1 on JDK 14. 

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
export JAVA_HOME=`pwd`/jdk-14.0.1+7
PATH=$JAVA_HOME/bin:$PATH
```


To setup first run

```
npm install
``` 

Download k6

```
wget https://github.com/loadimpact/k6/releases/download/v0.26.2/k6-v0.26.2-linux64.tar.gz
tar xzf k6-v0.26.2-linux64.tar.gz
mv k6-v0.26.2-linux64/k6 .
rm -fr k6-*
```

Build all applications

```
npm run build
```

Measure time to first response with:

```
npm run time
```


Run K6 and measure memory usage

```
java -jar micronaut-example/target/micronaut.jar &
./k6 run k6.js
ps x -o rss,vsz,command | grep java
pkill java

java -jar quarkus-example/target/quarkus-runner.jar &
./k6 run k6.js
ps x -o rss,vsz,command | grep java
pkill java

java -jar spring-example/target/springboot.jar &
./k6 run k6.js
ps x -o rss,vsz,command | grep java
pkill java
```


### Results

| METRIC  | Micronaut 2.0.0  | Quarkus 1.5.2  | Spring Boot 2.3.1  |
|---|---|---|---|
| Package Time (./mvnw clean package) (ms)  | **13_476** |  15_174  | 13_617  |
| Test Time (./mvnw test) (ms)   | **8_360**  | 9_385  | 11_391  |
| Jar Size in Bytes    | 13_652_459  | **272_619**  | 20_067_312  |
| Time to First Response (ms)   |  **1_847**  | 2_069  | 4_482 |
| K6: Requests per second   | **12_757** | 10_176 | 11_345  |
| K6: Number of Requests   | **3_827_239**  | 3_052_992  | 3_403_713  |
| Memory Consumption After K6 (RSS in kB)   | 618_944  | **530_536** |  658_408 |


Tests ran on a Hetzner VPS CX41 (4 VCPU, 16 GB RAM)      
OS: Ubuntu Server 20.04     
28 June 2020



### Results with OpenJ9

```
wget https://github.com/AdoptOpenJDK/openjdk14-binaries/releases/download/jdk-14.0.1%2B7_openj9-0.20.0/OpenJDK14U-jdk_x64_linux_openj9_14.0.1_7_openj9-0.20.0.tar.gz
tar xzf OpenJDK14U-jdk_x64_linux_openj9_14.0.1_7_openj9-0.20.0.tar.gz
rm OpenJDK14U-jdk_x64_linux_openj9_14.0.1_7_openj9-0.20.0.tar.gz
export JAVA_HOME=`pwd`/jdk-14.0.1+7
PATH=$JAVA_HOME/bin:$PATH
```

| METRIC  | Micronaut 2.0.0  | Quarkus 1.5.2  | Spring Boot 2.3.1  |
|---|---|---|---|
| Package Time (./mvnw clean package) (ms)  | 14_467   | 17_218   | **14_004** |
| Test Time (./mvnw test) (ms)   | **8_787**  | 10_297   | 11_732  |
| Time to First Response (ms)   | 2_088  | **1_867** | 4_219  |
| K6: Requests per second   | **11_885**  |  9_547  | 11_577 |
| K6: Number of Requests   | **3_565_739**  | 2_864_238  | 3_473_116 |
| Memory Consumption After K6 (RSS in kB)   | 358_248  | **266_724** | 372_328 |


Tests ran on a Hetzner VPS CX41 (4 VCPU, 16 GB RAM)      
OS: Ubuntu Server 20.04     
28 June 2020

