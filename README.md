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

| FRAMEWORK | Package Size in Bytes | Time to First Response (ms) | K6: Requests per second | Memory Consumption After K6 (RSS in kB) |
|---|--:|--:|--:|--:|
| Micronaut 2.0.0 | 13_657_888 * | 1_989 | ? | ? |
| Micronaut 2.0.0 Native | 57_650_136 | 67 | ? | ? |
|Quarkus 1.6.1 | 12_830_245 * | 1_711 | ? | ? |
| Quarkus 1.6.1 Native | 31_756_776 | 36 | ? | ? |
| Spring Boot 2.3.2 | 20_085_712 * | 3_718 | ? | ? |
| Go 1.14.6 | **7_689_328** | 31 | ? | ? |
| Go Fibre 1.14.6 | 12_984_161 | **28** | ? | ? |

\* = requires a JRE

Tests ran on a Hetzner VPS CX41 (4 VCPU, 16 GB RAM)      
OS: Ubuntu Server 20.04     
25 July 2020

