# Micronaut 3.2.1  vs Quarkus 2.5.2.Final vs Spring Boot 2.6.1 on OpenJdk 17 and GraalVM Native Image 21.3.0 vs Go 1.17.5

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

./springboot &
./k6 run k6.js
ps x -o rss,vsz,command | grep springboot
pkill springboot

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
| Micronaut OpenJDK    | * 13_527_397  | 1_759 | 16_636   | 608_435    |
| Micronaut Native     | 57_669_488  | 67  | 12_848   |  525_108   |
| Quarkus OpenJDK      | * 16_362_065  | 1_483 | 14_533   | 345_133    |
| Quarkus Native       | 48_212_016  | 36 |  11_570  | 466_209    |
| Spring Boot OpenJDK  | * 21_655_017  | 3_248 | 15_348   |  526_475   |
| Spring Boot Native   | 83_377_496  | 85 |  8_693  | 516_914    |
| Go                   | 6_299_602   | 23 | 16_999   |  35_474   |
| Go Fibre 2.23.0      | 9_269_874   | 26 | 20_408   |  45_103   |
| Go Echo  4.6.1       | 6_868_245   | 23 | 17_161   |  39_502   |

\* = requires JVM

Tests ran on a [Hetzner](https://hetzner.cloud/?ref=n8nOAQHMszMa) (referral link) VPS CX41 (4 VCPU, 16 GB RAM)      
OS: Ubuntu Server 20.04     
11 December 2021

