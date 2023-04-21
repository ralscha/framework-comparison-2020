
package com.example.myproject;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.is;

import java.util.concurrent.ExecutionException;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

import io.helidon.media.jackson.JacksonSupport;
import io.helidon.webclient.WebClient;
import io.helidon.webserver.WebServer;

class MainTest {

	private static WebServer webServer;
	private static WebClient webClient;

	@BeforeAll
	static void startTheServer() {
		webServer = Main.startServer().await();

		webClient = WebClient.builder().baseUri("http://localhost:" + webServer.port())
				.addMediaSupport(JacksonSupport.create()).build();
	}

	@AfterAll
	static void stopServer()
			throws ExecutionException, InterruptedException, TimeoutException {
		if (webServer != null) {
			webServer.shutdown().toCompletableFuture().get(10, TimeUnit.SECONDS);
		}
	}

	@Test
	void testSimpleGreet() {
		HelloMessage json = webClient.get().path("/helloJSON/John")
				.request(HelloMessage.class).await();
		assertThat(json.msg(), is("Hello John"));
	}

}
