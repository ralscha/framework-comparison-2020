import http from "k6/http";
import { check, sleep } from "k6";
import { Rate } from "k6/metrics";

var failureRate = new Rate("check_failure_rate");

export const options = {
	  vus: 500,
		duration: '30s'
		/*
    stages: [
        // Linearly ramp up from 1 to 200 VUs during first minute
        { target: 200, duration: "1m" },
        // Hold at 200 VUs for the next 3 minutes and 30 seconds
        { target: 200, duration: "3m30s" },
        // Linearly ramp down from 200 to 0 VUs over the last 30 seconds
        { target: 0, duration: "30s" }
        // Total execution time will be ~5 minutes
    ],
		*/
};

export default function() {
    const response = http.get("http://localhost:8080/hello/John");
		
		 const checkRes = check(response, {
        "status is 200": (r) => r.status === 200,
        "content is present": (r) => r.body.indexOf("Hello John") !== -1,
    });

    failureRate.add(!checkRes);
		
		// sleep(Math.random() * 3 + 2); // Random sleep between 2s and 5s
};