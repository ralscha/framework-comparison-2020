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
| Micronaut 4.0.1 OpenJDK 20    | \* 11_595_957  | 1_733  | 16_850 | 476_543 |
| Micronaut 4.0.1 Native     | 78_727_032  | 81  | 12_664  | 91_711 |
| Quarkus 3.2.1 OpenJDK 20      | \* 18_804_736 | 1_817  | 16_670 | 399_278  |
| Quarkus 3.2.1 Native       | 60_525_816  | 58 | 14_804  | 265_814 |
| Spring Boot 3.1.2 OpenJDK 20  | \* 23_674_097  | 3_484 | 14_804 | 513_239 |
| Spring Boot 3.1.2 Native   | 98_336_368 | 124 | 10_381 | 114_846 |
| Go 1.20.6                  | 4_734_976 | 23 | 18_108 | 36_072 |
| Go 1.20.6  Echo  4.11.1       |  5_111_808  | 26 | 17_992 | 40_396 |
| Go 1.20.6  Fibre 2.48.0      | 6_848_512  | 23 | 22_285 | 39_076  |
| Rust 1.71.0 Salvo 0.48.2     | **2_906_696** | **20**  | **23_227**  | **28_731** |

\* = requires JVM

Tests ran on a [Hetzner](https://hetzner.cloud/?ref=n8nOAQHMszMa) (referral link) VPS CX41 (4 VCPU, 16 GB RAM)      
OS: Ubuntu Server 22.04     
23 July 2023

