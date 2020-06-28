import http from "k6/http";
import { check, sleep } from "k6";

export const options = {
    stages: [
        // Linearly ramp up from 1 to 500 VUs during first minute
        { target: 500, duration: "1m" },
        // Hold at 500 VUs for the next 3 minutes and 30 seconds
        { target: 500, duration: "3m30s" },
        // Linearly ramp down from 500 to 0 VUs over the last 30 seconds
        { target: 0, duration: "30s" }
        // Total execution time will be ~5 minutes
    ]
};

export default function() {
    const response = http.get("http://localhost:8080/helloJSON/John");
		
    const checkRes = check(response, {
        "status is 200": (r) => r.status === 200,
        "content is present": (r) => r.body.indexOf("{\"msg\":\"Hello John\",\"ts\"") !== -1,
    });
		
	sleep(Math.random() * 3 + 2); // Random sleep between 2s and 5s
};