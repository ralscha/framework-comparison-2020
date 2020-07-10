java -jar micronaut.jar &
./k6 run k6.js
./k6 run k6.js
./k6 run k6.js
ps x -o rss,vsz,command | grep java
sleep 5
ps x -o rss,vsz,command | grep java
sleep 5
ps x -o rss,vsz,command | grep java
pkill java
sleep 30

java -jar quarkus-runner.jar &
./k6 run k6.js
./k6 run k6.js
./k6 run k6.js
ps x -o rss,vsz,command | grep java
sleep 5
ps x -o rss,vsz,command | grep java
sleep 5
ps x -o rss,vsz,command | grep java
pkill java
sleep 30


java -jar springboot.jar &
./k6 run k6.js
./k6 run k6.js
./k6 run k6.js
ps x -o rss,vsz,command | grep java
sleep 5
ps x -o rss,vsz,command | grep java
sleep 5
ps x -o rss,vsz,command | grep java
pkill java
sleep 30

./micronaut &
./k6 run k6.js
./k6 run k6.js
./k6 run k6.js
ps x -o rss,vsz,command | grep micronaut
sleep 5
ps x -o rss,vsz,command | grep micronaut
sleep 5
ps x -o rss,vsz,command | grep micronaut
pkill micronaut
sleep 30

./quarkus-runner &
./k6 run k6.js
./k6 run k6.js
./k6 run k6.js
ps x -o rss,vsz,command | grep quarkus-runner
sleep 5
ps x -o rss,vsz,command | grep quarkus-runner
sleep 5
ps x -o rss,vsz,command | grep quarkus-runner
pkill quarkus-runner
sleep 30

./goexample &
./k6 run k6.js
./k6 run k6.js
./k6 run k6.js
ps x -o rss,vsz,command | grep goexample
sleep 5
ps x -o rss,vsz,command | grep goexample
sleep 5
ps x -o rss,vsz,command | grep goexample
pkill goexample





