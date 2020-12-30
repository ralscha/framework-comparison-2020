export JAVA_HOME=`pwd`/openjdk
OLD_PATH=$PATH
PATH=$JAVA_HOME/bin:$OLD_PATH
java -version

export JAVA_OPTS="-XX:ArchiveClassesAtExit=openjdk-app-%FRAMEWORK%.jsa"
npm run time
sleep 5
export JAVA_OPTS="-XX:SharedArchiveFile=openjdk-app-%FRAMEWORK%.jsa"
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
export JAVA_OPTS="-Xshareclasses:name=%FRAMEWORK%"
PATH=$JAVA_HOME/bin:$OLD_PATH
java -version
npm run time
sleep 5
npm run time
sleep 5
npm run time
sleep 5
npm run time
sleep 10

source ./run_k6_java.sh
