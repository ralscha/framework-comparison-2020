# Micronaut 2.1.2  vs Quarkus 1.9.1 vs Spring Boot 2.4.0-RC1 on JDK 15 and GraalVM Native Image 20.2.0 vs Go 1.15.3

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
| Micronaut 2.1.2        | * 13_694_969  | 1_766  | 14_910     | 572_482    |
| Micronaut 2.1.2 Native | 65_046_104    | 60     | 11_083     | 470_008    |
| Quarkus 1.9.1          | * 13_361_271  | 1_400  | 11_902     | 464_472    |
| Quarkus 1.9.1 Native   | 34_177_512    | 35     | 9_278      | 643_656    |
| Spring Boot 2.4.0-RC1  | * 20_511_000  | 3_136  | 13_877     | 501_981    |
| Go 1.15.3              | **6_628_330** | 28     | 14_823     | **34_836** |
| Go Fibre 1             | 8_617_769     | 27     | 17_419     | 42_880     |
| Go Fibre 2             | 8_896_184     | **24** | **17_523** | 36_532     |

\* = requires JRE

Tests ran on a [Hetzner](https://www.hetzner.com/) VPS CX41 (4 VCPU, 16 GB RAM)      
OS: Ubuntu Server 20.04     
2 November 2020

