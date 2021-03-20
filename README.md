# Micronaut 2.4.1  vs Quarkus 1.12.2 vs Spring Boot 2.4.4 on OpenJdk 16, OpenJ9 16 and GraalVM Native Image 21.0.0.2 vs Go 1.16.2

This repo contains a performance comparison between Micronaut vs Quarkus vs Spring Boot on JDK 16 and GraalVM Native Image and Go.    

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

./micronaut-runner &
./k6 run k6.js
ps x -o rss,vsz,command | grep micronaut-runner
pkill micronaut

./quarkus-runner &
./k6 run k6.js
ps x -o rss,vsz,command | grep quarkus-runner
pkill quarkus

./goexample &&
./k6 run k6.js
ps x -o rss,vsz,command | grep goexample
pkill goexample

./gofibre &&
./k6 run k6.js
ps x -o rss,vsz,command | grep gofibre
pkill gofibre

./goecho &&
./k6 run k6.js
ps x -o rss,vsz,command | grep goecho
pkill goecho
```


### Results

| FRAMEWORK         | Package Size in Bytes | Time to First Response (ms) | K6: Requests per second | Memory Consumption After K6 (RSS in kB) |
|---|--:|--:|--:|--:|
| Micronaut 2.4.1 OpenJDK   |13_599_879 *  | 2_011  | 14_526     | 647_872 |
| Micronaut 2.4.1 OpenJ9    |              | 2_719  | 13_060     | 381_689 |
| Micronaut 2.4.1 Native    |62_237_696    | 66     | 10_853     | 701_068 |
| Quarkus 1.12.2  OpenJDK   |16_248_194 *  | 1_740  | 10_957     | 554_704 |
| Quarkus 1.12.2  OpenJ9    |              | 2_683  | 10_497     | 273_008 |
| Quarkus 1.12.2 Native     |37_401_832    | 39     | 8_882      | 639_700 |
| Spring Boot 2.4.4 OpenJDK |20_846_051 *  | 3_874  | 13_208     | 621_153 |
| Spring Boot 2.4.4 OpenJ9  |              | 4_783  | 12_230     | 320_545 |
| Go 1.16.2                 |**6_361_418** | **27** | 14_696     | **35_960** |
| Go Fibre 2                |8_837_334     | 34     | **17_650** | 37_990 |
| Go Echo                   |7_502_306     | 32     | 15_169     | 40_161 |

\* = requires JVM

Tests ran on a [Hetzner](https://www.hetzner.com/) VPS CX41 (4 VCPU, 16 GB RAM)      
OS: Ubuntu Server 20.04     
20th March 2021
