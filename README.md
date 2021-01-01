# Micronaut 2.2.2  vs Quarkus 1.10.5 vs Spring Boot 2.4.1 on OpenJdk 15, OpenJ9 15 and GraalVM Native Image 20.3.0 vs Go 1.15.6

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
| Micronaut 2.2.2 OpenJDK   |13_321_219 *  | 988    | 15_229     | 562_952 |
| Micronaut 2.2.2 OpenJ9    |              | 1_299  | 13_354     | 354_483 |
| Micronaut 2.2.2 Native    |61_995_368    | 63     | 11_370     | 477_730 |
| Quarkus 1.10.5  OpenJDK   |15_632_761 *  | 856    | 11_877     | 514_181 |
| Quarkus 1.10.5  OpenJ9    |              | 1_110  | 10_962     | 222_852 |
| Quarkus 1.10.5 Native     |36_721_120    | 36     | 9_356      | 620_626 |
| Spring Boot 2.4.1 OpenJDK |20_576_165 *  | 2_853  | 13_759     | 619_217 |
| Spring Boot 2.4.1 OpenJ9  |              | 2_016  | 12_336     | 320_473 |
| Go 1.15.6                 |**6_624_365** | 32     | 14_877     | **34_747** |
| Go Fibre 2                |9_035_872     | **29** | **17_859** | 36_297 |
| Go Echo                   |7_755_220     | 30     | 15_017     | 41_244 |

\* = requires JVM

Tests ran on a [Hetzner](https://www.hetzner.com/) VPS CX41 (4 VCPU, 16 GB RAM)      
OS: Ubuntu Server 20.04     
1st January 2021

