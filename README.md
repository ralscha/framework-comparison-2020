# Micronaut 2.2.1  vs Quarkus 1.10.5 vs Spring Boot 2.4.1 on JDK 15 and GraalVM Native Image 20.3.0 vs Go 1.15.6

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

./micronaut-runner &
./k6 run k6.js
ps x -o rss,vsz,command | grep micronaut-runner
pkill micronaut-runner

./quarkus-runner &
./k6 run k6.js
ps x -o rss,vsz,command | grep quarkus-runner
pkill quarkus-runner

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
| Micronaut 2.2.1        | * 13_317_522  | 1_559  |   16_323    | 643_496 |
| Micronaut 2.2.1 Native | 62_019_944    |    71  |   12_393    | 474_474 |
| Quarkus 1.10.5         | * 15_632_779  | 1_395  |   12_790    | 528_848 |
| Quarkus 1.10.5 Native  | 35_635_504    |    36  |   10_284    | 623_073 |
| Spring Boot 2.4.1      | * 20_576_165  | 2_943  |   15_002    | 587_811 |
| Go 1.15.6              | **6_624_365** | **28** |   16_341    |  **34_887** |
| Go Fibre 2             | 9_035_807     | **28** |  **19_499** |  36_345 |
| Go Echo                | 7_755_220     | **28** |   16_475    |  41_008 |

\* = requires JRE

Tests ran on a [Hetzner](https://www.hetzner.com/) VPS CX41 (4 VCPU, 16 GB RAM)      
OS: Ubuntu Server 20.04     
20 December 2020

