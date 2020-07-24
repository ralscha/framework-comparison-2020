java -jar micronaut.jar &
./k6 run --summary-export=micronaut1.json k6.js
./k6 run --summary-export=micronaut2.json k6.js
./k6 run --summary-export=micronaut3.json k6.js
ps x -o rss,vsz,command | grep java
sleep 5
ps x -o rss,vsz,command | grep java
sleep 5
ps x -o rss,vsz,command | grep java
pkill java
sleep 30

java -jar quarkus-runner.jar &
./k6 run --summary-export=quarkus1.json k6.js
./k6 run --summary-export=quarkus2.json k6.js
./k6 run --summary-export=quarkus3.json k6.js
ps x -o rss,vsz,command | grep java
sleep 5
ps x -o rss,vsz,command | grep java
sleep 5
ps x -o rss,vsz,command | grep java
pkill java
sleep 30


java -jar springboot.jar &
./k6 run --summary-export=springboot1.json k6.js
./k6 run --summary-export=springboot2.json k6.js
./k6 run --summary-export=springboot3.json k6.js
ps x -o rss,vsz,command | grep java
sleep 5
ps x -o rss,vsz,command | grep java
sleep 5
ps x -o rss,vsz,command | grep java
pkill java
sleep 30

./micronaut &
./k6 run --summary-export=micronaut-native1.json k6.js
./k6 run --summary-export=micronaut-native2.json k6.js
./k6 run --summary-export=micronaut-native3.json k6.js
ps x -o rss,vsz,command | grep micronaut
sleep 5
ps x -o rss,vsz,command | grep micronaut
sleep 5
ps x -o rss,vsz,command | grep micronaut
pkill micronaut
sleep 30

./quarkus-runner &
./k6 run --summary-export=quarkus-native1.json k6.js
./k6 run --summary-export=quarkus-native2.json k6.js
./k6 run --summary-export=quarkus-native3.json k6.js
ps x -o rss,vsz,command | grep quarkus-runner
sleep 5
ps x -o rss,vsz,command | grep quarkus-runner
sleep 5
ps x -o rss,vsz,command | grep quarkus-runner
pkill quarkus-runner
sleep 30

./goexample &
./k6 run --summary-export=go1.json k6.js
./k6 run --summary-export=go2.json k6.js
./k6 run --summary-export=go3.json k6.js
ps x -o rss,vsz,command | grep goexample
sleep 5
ps x -o rss,vsz,command | grep goexample
sleep 5
ps x -o rss,vsz,command | grep goexample
pkill goexample





