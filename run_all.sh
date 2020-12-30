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

export JAVA_OPTS_MICRONAUT="-XX:SharedArchiveFile=openjdk-app-micronaut.jar.jsa"
export JAVA_OPTS_QUARKUS="-XX:SharedArchiveFile=openjdk-app-quarkus-runner.jar.jsa"
export JAVA_OPTS_SPRING="-XX:SharedArchiveFile=openjdk-app-springboot.jar.jsa"
export JAVA_VM="openjdk"
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

export JAVA_OPTS_MICRONAUT="-Xshareclasses:name=micronaut.jar"
export JAVA_OPTS_QUARKUS="-Xshareclasses:name=quarkus-runner.jar"
export JAVA_OPTS_SPRING="-Xshareclasses:name=springboot.jar"
export JAVA_VM="openj9"
source ./run_k6_java.sh
