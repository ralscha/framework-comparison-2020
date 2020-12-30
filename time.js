const spawn = require("child_process").spawn;
const request = require("request");

const pingIntervalMs = 5;

const args = process.argv.slice(2);
if (args.length == 0) {
  console.log('The path of java executable jar must be specified !');
}

const javaOpts = process.env.JAVA_OPTS;
const spawnOpts = ["-jar", args[0]];

if (javaOpts) {
  for (const jo of javaOpts.split(' ')) {
    const jor = jo.replace('%FRAMEWORK%', args[0]);
    spawnOpts.unshift(jor);
  }
}

const proc = (args[0].endsWith(".jar") ? spawn("java", spawnOpts) : spawn(args[0]));

const startTime = new Date().getTime();
const intervalHandle = setInterval(() => {
  request("http://localhost:8080/helloJSON/John", (error, response, body) => {
      if (!error && response && response.statusCode === 200 && body) {
          const time = new Date().getTime() - startTime;
          console.log(time + " ms");
          clearInterval(intervalHandle);
          proc.kill();
          process.exit(0);
      } else {
          // @ts-ignore
          if (!error || !error.code === "ECONNREFUSED") {
            console.log(error ? error : response.statusCode);
          }
      }
    }
  );
}, pingIntervalMs);