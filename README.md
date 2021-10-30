# Micronaut 3.1.3  vs Quarkus 2.4.0 vs Spring Boot 2.5.6 on OpenJdk 17 and GraalVM Native Image 21.3.0 vs Go 1.17.2

This repo contains a performance comparison between Micronaut vs Quarkus vs Spring Boot on JDK 17 and GraalVM Native Image and Go.    

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

| FRAMEWORK              | Package Size in Bytes | Time to First Response (ms) | K6: Requests per second | Memory Consumption After K6 (RSS in kB) |
|---|--:|--:|--:|--:|
| Micronaut 3.1.3 OpenJDK   | 13'476'757 *  | 1_709   |  18_013    | 571_051    |
| Micronaut 3.1.3 Native    | 58'386'288    |    67   |  13_687    | 575_767    |
| Quarkus 2.4.0  OpenJDK    | 16'442'242 *  | 1_496   |  15_626    | 331_302    |
| Quarkus 2.4.0 Native      | 46'389'672    |    38   |  12_475    | 454_149    |
| Spring Boot 2.5.6 OpenJDK | 21'354'506 *  | 2_977   |  16_288    | 549_003    |
| Go 1.17.2                 | **6_300_406** |  **27** |  17_997    | **35_871** |
| Go 1.17.2 Fibre 2.20.2    | 9_321_859     |    30   | **21_758** | 46_067     |
| Go 1.17 Echo  4.6.1       |  6_869_017    |    32   |  17_999    | 39_608     |

\* = requires JVM

Tests ran on a [Hetzner](https://www.hetzner.com/) VPS CX41 (4 VCPU, 16 GB RAM)      
OS: Ubuntu Server 20.04     
30 October 2021
