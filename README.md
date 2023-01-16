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
| Micronaut 3.8.1 OpenJDK 19    | \* 14_170_326 | 2_029 | 15_104 | 498_824 |
| Micronaut 3.8.1 Native     | 65_054_016 | 61  | 11_824 | 82_791 |
| Quarkus 2.15.3 OpenJDK 19      | \* 17_894_194 | 1_749  | 15_599 | 456_211 |
| Quarkus 2.15.3 Native       | 45_582_080  | 48 | 12_653  | 348_268 |
| Spring Boot 2.7.7 OpenJDK 19  | \* 21_732_411 | 3_590 | 14_204 | 500_683 |
| Spring Boot 3.0.1 OpenJDK 19  | \* 23_132_950 | 3_658 | 14_450 | 524_370 |
| Spring Boot 3.0.1 Native   | 77_015_096 | 129 | 7_169 | 107_526 |
| Go 1.19.5                  | 4_632_576  | 20 | 16_875 | 40_421 |
| Go 1.19.5 Echo  4.10.2       | 5_005_312  | 22 | 16_894 | 41_152 |
| Go 1.19.5 Fibre 2.41.0      | 6_803_456  | 21 |20_930 | 39_320 |
| Rust 1.66.1 Cargo 0.67.1     | **2_439_744** | **20**  | **22_583**  | **25_442** |

\* = requires JVM

Tests ran on a [Hetzner](https://hetzner.cloud/?ref=n8nOAQHMszMa) (referral link) VPS CX41 (4 VCPU, 16 GB RAM)      
OS: Ubuntu Server 22.04     
14 January 2023

