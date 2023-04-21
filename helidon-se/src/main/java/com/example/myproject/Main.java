package com.example.myproject;

import io.helidon.common.LogConfig;
import io.helidon.common.reactive.Single;
import io.helidon.config.Config;
import io.helidon.media.jackson.JacksonSupport;
import io.helidon.metrics.MetricsSupport;
import io.helidon.webserver.Routing;
import io.helidon.webserver.WebServer;

public final class Main {

	private Main() {
	}

	public static void main(final String[] args) {
		startServer();
	}

	static Single<WebServer> startServer() {

		LogConfig.configureRuntime();
		Config config = Config.create();

		WebServer server = WebServer.builder(createRouting()).config(config.get("server"))
				.addMediaSupport(JacksonSupport.create()).build();

		Single<WebServer> webserver = server.start();
		webserver.thenAccept(ws -> {
			System.out.println("Web server is up!");
			ws.whenShutdown()
					.thenRun(() -> System.out.println("WEB server is DOWN. Good bye!"));
		}).exceptionallyAccept(t -> {
			System.err.println("Startup failed: " + t.getMessage());
			t.printStackTrace(System.err);
		});

		return webserver;
	}

	private static Routing createRouting() {
		GreetService greetService = new GreetService();
		Routing.Builder builder = Routing.builder().register(MetricsSupport.create())
				.register("/helloJSON", greetService);

		return builder.build();
	}
}
