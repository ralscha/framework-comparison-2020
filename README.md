# Micronaut 2.4.1  vs Quarkus 1.13.0 vs Spring Boot 2.4.4 on OpenJdk 16, OpenJ9 16 and GraalVM Native Image 21.0.0.2 vs Go 1.16.2

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
| Micronaut 2.4.1 OpenJDK   |  13_599_879 * | 1_943   | 14_566     | 663_999 |
| Micronaut 2.4.1 OpenJ9    |               | 2_622   | 13_299     | 378_687 |
| Micronaut 2.4.1 Native    | 62_237_696    | 78      | 11_109     | 701_234 |
| Quarkus 1.13.0  OpenJDK   | 14_517_778 *  | 1_611   | 17_250     | 249_554 |
| Quarkus 1.13.0  OpenJ9    |               | 2_086   | 16_941     | 132_686 |
| Quarkus 1.13.0 Native     |  32_970_216   | 38      | 13_903     | 318_043 |
| Spring Boot 2.4.4 OpenJDK | 20_846_052 *  | 3_792   | 13_611     | 590_344 |
| Spring Boot 2.4.4 OpenJ9  |               | 4_776   | 11_979     | 307_959 |
| Go 1.16.2                 | **6_361_418** | 33      | 15_212     | **35_801** |
| Go Fibre 2.7.1            | 8_836_737     | **31**  | **18_287** | 37_111 |
| Go Echo  4.2.1            | 7_502_306     | 32      | 15_025     | 40_046 |

\* = requires JVM

Tests ran on a [Hetzner](https://www.hetzner.com/) VPS CX41 (4 VCPU, 16 GB RAM)      
OS: Ubuntu Server 20.04     
2 April 2021
