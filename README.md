# Micronaut vs Quarkus vs Spring Boot vs Go vs Rust

This repo contains a http request performance comparison between Micronaut, Quarkus, Spring Boot, Go and Rust.

### Setup

```
wget https://raw.githubusercontent.com/ralscha/framework-comparison-2020/master/setup.sh
source ./setup.sh
```


### Results

| FRAMEWORK              | Package Size in Bytes | Time to First Response (ms) | K6: Requests per second | Memory Consumption After K6 (RSS in kB) |
|---|--:|--:|--:|--:|
| Micronaut 4.2.1 OpenJDK 21    | \* 11_663_897  | 1_586  | 19_834  | 379_024 |
| Micronaut 4.2.1 Native     | 75_374_272  | 76 | 16_008  | 75_741  | 
| Quarkus 3.6.4 OpenJDK 21      | \* 19_218_432 | 1_890  | 14_978  | 632_648 |
| Quarkus 3.6.4 Native       | 63_622_840  | 49 | 12_705  | 255_128 | 
| Spring Boot 3.2.1 OpenJDK 21  | \* 24_423_223  | 4_130  | 12_690  | 566_765 | 
| Spring Boot 3.2.1 Native   | 96_843_096 | 133 | 12_684  | 132_038 |
| Go 1.21.5                  | 4_755_456 | **18**  | 18_635  | 35_780 | 
| Go 1.21.5  Echo  4.11.4       |  5_120_000  | 19  | 18_704  | 40_344 | 
| Go 1.21.5  Fibre 2.51.0      | 5_828_608  | 20 | 23_380  | 38_401 | 
| Rust 1.75.0 Salvo 0.63.1     | **3_160_688** | 19 | **24_807**  | **30_533** |

\* = requires JVM

Tests ran on a [Hetzner](https://hetzner.cloud/?ref=n8nOAQHMszMa) (referral link) VPS CX41 (4 VCPU, 16 GB RAM)      
OS: Ubuntu Server 22.04     
1st January 2024

