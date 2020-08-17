# Micronaut 2.0.1  vs Quarkus 1.7.0 vs Spring Boot 2.3.3 on JDK 14 and GraalVM Native Image vs Go 1.15

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
| Micronaut 2.0.1 | * 13_668_313 | 1_989 | 12_032 | 589_006 |
| Micronaut 2.0.1 Native | 57_691_096 | 86 | 9_190 | 471_288 |
| Quarkus 1.7.0 | * 13_000_439 | 1_638 | 9_589 | 542_336 |
| Quarkus 1.7.0 Native | 30_994_360 | 37 | 7_569 | 637_588 |
| Spring Boot 2.3.3 | * 20_092_255 |3_746 | 11_449 | 676_315 |
| Go 1.15 | **6_628_268** | **27** | 12_214 | **34_921** |
| Go Fibre 1.15 | 8_639_777 | 34 | **14_286** | 42_756 |

\* = requires JRE

Tests ran on a Hetzner VPS CX41 (4 VCPU, 16 GB RAM)      
OS: Ubuntu Server 20.04     
17 August 2020

