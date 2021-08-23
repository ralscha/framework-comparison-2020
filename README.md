# Micronaut 3.0.0  vs Quarkus 2.1.3 vs Spring Boot 2.5.4 on OpenJdk 16, OpenJ9 16 and GraalVM Native Image 21.2.0 vs Go 1.17

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

| FRAMEWORK              | Package Size in Bytes | Time to First Response (ms) | K6: Requests per second | Memory Consumption After K6 (RSS in kB) |
|---|--:|--:|--:|--:|
| Micronaut 3.0.0 OpenJDK   |  13_335_768 * |  1_645  |  19_439    | 568_052 |
| Micronaut 3.0.0 OpenJ9    |               |  2_234  |  18_554    | 319_898 |
| Micronaut 3.0.0 Native    | 53_754_888    |  69     |  15_023    | 698_839 |
| Quarkus 2.1.3  OpenJDK    | 15_556_608 *  |  1_485  |  21_774    | 256_806 |
| Quarkus 2.1.3  OpenJ9     |               |  1_835  |  21_280    | 138_576 |
| Quarkus 2.1.3 Native      |  43_990_928   |  60     |  17_710    | 327_425 |
| Spring Boot 2.5.4 OpenJDK | 21_353_334 *  |  3_176  |  17_407    | 570_207 |
| Spring Boot 2.5.4 OpenJ9  |               |  3_744  |  15_604    | 325_115 |
| Go 1.17                   | **6_298_246** | **24**  |  19_025    | **35_759** |
| Go 1.17 Fibre 2.17.0      | 8_208_895     |  28     | **23_289** | 36_736 |
| Go 1.17 Echo  4.5.0       | 6_867_078     |  25     |  19_051    | 39_632 |

\* = requires JVM

Tests ran on a [Hetzner](https://www.hetzner.com/) VPS CX41 (4 VCPU, 16 GB RAM)      
OS: Ubuntu Server 20.04     
21 August 2021
