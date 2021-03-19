./micronaut-runner &
sleep 5
./k6 run --summary-export=micronaut-native1.json k6.js
./k6 run --summary-export=micronaut-native2.json k6.js
./k6 run --summary-export=micronaut-native3.json k6.js
ps x -o rss,vsz,command | grep micronaut-runner
sleep 5
ps x -o rss,vsz,command | grep micronaut-runner
sleep 5
ps x -o rss,vsz,command | grep micronaut-runner
pkill micronaut
sleep 30

./quarkus-runner &
sleep 5
./k6 run --summary-export=quarkus-native1.json k6.js
./k6 run --summary-export=quarkus-native2.json k6.js
./k6 run --summary-export=quarkus-native3.json k6.js
ps x -o rss,vsz,command | grep quarkus-runner
sleep 5
ps x -o rss,vsz,command | grep quarkus-runner
sleep 5
ps x -o rss,vsz,command | grep quarkus-runner
pkill quarkus
sleep 30

./goexample &
sleep 5
./k6 run --summary-export=go1.json k6.js
./k6 run --summary-export=go2.json k6.js
./k6 run --summary-export=go3.json k6.js
ps x -o rss,vsz,command | grep goexample
sleep 5
ps x -o rss,vsz,command | grep goexample
sleep 5
ps x -o rss,vsz,command | grep goexample
pkill goexample


./gofibre &
sleep 5
./k6 run --summary-export=gofibre_1.json k6.js
./k6 run --summary-export=gofibre_2.json k6.js
./k6 run --summary-export=gofibre_3.json k6.js
ps x -o rss,vsz,command | grep gofibre
sleep 5
ps x -o rss,vsz,command | grep gofibre
sleep 5
ps x -o rss,vsz,command | grep gofibre
pkill gofibre


./goecho &
sleep 5
./k6 run --summary-export=goecho_1.json k6.js
./k6 run --summary-export=goecho_2.json k6.js
./k6 run --summary-export=goecho_3.json k6.js
ps x -o rss,vsz,command | grep goecho
sleep 5
ps x -o rss,vsz,command | grep goecho
sleep 5
ps x -o rss,vsz,command | grep goecho
pkill goecho
