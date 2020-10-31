FROM oracle/graalvm-ce:20.2.0-java11 as graalvm
RUN gu install native-image

COPY . /home/app/micronaut
WORKDIR /home/app/micronaut

RUN native-image -cp target/micronaut-*.jar

FROM frolvlad/alpine-glibc
RUN apk update && apk add libstdc++
EXPOSE 8080
COPY --from=graalvm /home/app/micronaut/micronaut /app/micronaut
ENTRYPOINT ["/app/micronaut"]
