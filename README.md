# Micronaut 2.0.2  vs Quarkus 1.8.1 vs Spring Boot 2.3.4 on JDK 15 and GraalVM Native Image 20.2.0 vs Go 1.15.2

This repo contains a performance comparison between Micronaut vs Quarkus vs Spring Boot on JDK 15 and GraalVM Native Image and Go.    

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

| FRAMEWORK         | Package Size in Bytes | Time to First Response (ms) | K6: Requests per second | Memory Consumption After K6 (RSS in kB) |
|---|--:|--:|--:|--:|
| Micronaut 2.0.2        | * 13_678_198  | 1_390  | 17_918     | 607_336    |
| Micronaut 2.0.2 Native | 65_476_184    | 62     | 13_831     | 473_223    |
| Quarkus 1.8.1          | * 13_085_663  | 1_131  | 13_987     | 531_936    |
| Quarkus 1.8.1 Native   | 32_170_288    | 28     | 11_255     | 640_984    |
| Spring Boot 2.3.4      | * 20_125_614  | 2_535  | 16_714     | 688_287    |
| Go 1.15.2              | **6_628_268** | **25** | 18_837     | **34_657** |
| Go Fibre 1.15.2        | 8_621_803     | 28     | **21_883** | 42_824     |

\* = requires JRE

Tests ran on a [Hetzner](https://www.hetzner.com/) VPS CX41 (4 VCPU, 16 GB RAM)      
OS: Ubuntu Server 20.04     
19 September 2020

