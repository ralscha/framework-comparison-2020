# Micronaut 2.0.0  vs Quarkus 1.5.2 vs Spring Boot 2.3.1 on JDK 14 and GraalVM Native Image vs Go 14.4.4

This repo contains a performance comparison between Micronaut 2.0 vs Quarkus 1.5.2 vs Spring Boot 2.3.1 on JDK 14 and GraalVM Native Image.    

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





