# Micronaut 2.0.0  vs Quarkus 1.5.2 vs Spring Boot 2.3.1 on JDK 14

This repo contains a performance comparison between Micronaut 2.0 vs Quarkus 1.5.2 vs Spring Boot 2.3.1 on JDK 14. 

Associated YouTube video: https://www.youtube.com/watch?v=rJFgdFIs_k8&feature=youtu.be

### Setup

Install Node.js and Java (Ubuntu 20.04)

```
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt-get install -y nodejs

wget https://github.com/AdoptOpenJDK/openjdk11-binaries/releases/download/jdk-11.0.7%2B10/OpenJDK11U-jdk_x64_linux_hotspot_11.0.7_10.tar.gz
tar xzf OpenJDK11U-jdk_x64_linux_hotspot_11.0.7_10.tar.gz
rm OpenJDK11U-jdk_x64_linux_hotspot_11.0.7_10.tar.gz
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


### Comparison

| METRIC  | Micronaut 2.0.0  | Quarkus 1.5.2  | Spring Boot 2.3.1  |
|---|---|---|---|
| Package Time (./mvnw clean package)  |   |   |   |
| Test Time (./mvnw test)   |   |   |   |
| Time to First Response   |   |   |   |
| Requests per second   |   |   |   |
| Memory Consumption After Load Test (-Xmx128m)   |   |   |   |
| Memory Consumption After Load Test (--Xmx18m)   |   |   |   |


Tests ran on a Hetzner VPS CX41 (4 VCPU, 16 GB RAM)
OS: Ubuntu Server 20.04


### Q & A

*How was memory measured?*

Using the `ps` command on OS X to obtain the RSS memory:

```
ps x -o rss,vsz,command | grep java
```

*How was req/sec measured?*

Using `k6`:

```
k6 run k6.js
```
