# Micronaut 3.4.3 vs Quarkus 2.9.1.Final vs Spring Boot 2.6.7 on OpenJdk 17 and GraalVM Native Image 22.1.0 vs Go 1.18.2

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
| Micronaut OpenJDK    | \* 13_602_163 | 1_687 | 16_843 | 486_915 |
| Micronaut Native     | 57_380_592 | 68  | 12_848 | 82_449 |
| Quarkus OpenJDK      | \* 16_694_751 | 1_512 | 14_808 | 329_800 |
| Quarkus Native       | 46_405_232  | 41 | 12_359 | 394_152 |
| Spring Boot OpenJDK  | \* 21_664_890 | 3_183 | 15_165 | 518_447 |
| Spring Boot Native   | 76_567_536 | 89 | 8_800 | 90_636 |
| Go                   | *6_466_706*  | *24* | 17_649 | 43_703 |
| Go Fibre 2.33.0      | 8_574_092  | *24* | *20_750* | *41_597* |
| Go Echo  4.7.2       | 7_066_174  | *24* | 17_584 | 47_298 |

\* = requires JVM

Tests ran on a [Hetzner](https://hetzner.cloud/?ref=n8nOAQHMszMa) (referral link) VPS CX41 (4 VCPU, 16 GB RAM)      
OS: Ubuntu Server 22.04     
18 May 2022

