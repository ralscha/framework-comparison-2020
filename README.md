# Micronaut 2.0.0  vs Quarkus 1.6.1 vs Spring Boot 2.3.2 on JDK 14 and GraalVM Native Image vs Go 1.14.6

This repo contains a performance comparison between Micronaut vs Quarkus vs Spring Boot on JDK 14 and GraalVM Native Image and Go.    

### Setup

```
wget https://raw.githubusercontent.com/ralscha/framework-comparison-2020/master/setup.sh
source ./setup.sh
```

### Benchmarks

Measure time to first response with:
```
npm run time
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

./goexample &&
./k6 run k6.js
ps x -o rss,vsz,command | grep goexample
pkill goexample

./gofibreexample &&
./k6 run k6.js
ps x -o rss,vsz,command | grep gofibreexample
pkill gofibreexample
```


### Results

| METRIC  | Micronaut 2.0.0  | Quarkus 1.6.1  | Spring Boot 2.3.2  | Go 1.14.6 | Go Fibre 1.14.6 |
|---|---|---|---|---|---|
| Test Time (./mvnw test) (ms)   | **7_145**  | 8_773  | 10_880   | - | - |
| Jar Size in Bytes    | 13_657_879  | **12_489_533**  | 20_067_300  | - | - |
| Native Image in Bytes |  57_650_136 | 32_591_416 | - | **7_681_136** | - |
| Time to First Response (ms) Java   | 1_957  | **1_529**  | 3_642 | - | - |
| Time to First Response (ms) Native   | 80   |  41  | - | **35** | - |
| K6: Requests per second Java   | **13_529**  | 10_309  | 12_512  | - | - |
| K6: Number of Requests Java   | **4_059_164**   | 3_092_883  | 3_753_940  | - | - |   
| Memory Consumption After K6 (RSS in kB) Java  | 553_300 | **450_120** | 661_656 | - | - |
| K6: Requests per second Native   | 11_111 |  9_273 | -  | **15_455** | - |
| K6: Number of Requests Native   | 3_333_411  | 2_782_155  | - | **4_636_753** | - |
| Memory Consumption After K6 (RSS in kB) Native  | 470_552  | 657_240  | - | **34_132** | - |


Tests ran on a Hetzner VPS CX41 (4 VCPU, 16 GB RAM)      
OS: Ubuntu Server 20.04     
25 July 2020

