export JAVA_HOME=`pwd`/openjdk
OLD_PATH=$PATH
PATH=$JAVA_HOME/bin:$OLD_PATH
npm run time
sleep 5
npm run time
sleep 5
npm run time
sleep 5
npm run time
sleep 10

source ./run_k6_java.sh
source ./run_k6_native.sh

export JAVA_HOME=`pwd`/openj9
PATH=$JAVA_HOME/bin:$OLD_PATH
npm run time
sleep 5
npm run time
sleep 5
npm run time
sleep 5
npm run time
sleep 10

source ./run_k6_java.sh

export JAVA_HOME=`pwd`/corretto
PATH=$JAVA_HOME/bin:$OLD_PATH
npm run time
sleep 5
npm run time
sleep 5
npm run time
sleep 5
npm run time
sleep 10

source ./run_k6_java.sh