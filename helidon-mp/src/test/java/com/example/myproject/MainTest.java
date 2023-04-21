
package com.example.myproject;

import static org.hamcrest.MatcherAssert.assertThat;

import org.hamcrest.Matchers;
import org.junit.jupiter.api.Test;

import io.helidon.microprofile.tests.junit5.HelidonTest;
import jakarta.inject.Inject;
import jakarta.ws.rs.client.WebTarget;

@HelidonTest
class MainTest {

	@Inject
	private WebTarget target;

	@Test
	void testGreet() {
		HelloMessage message = this.target.path("helloJSON/John").request()
				.get(HelloMessage.class);
		assertThat(message.msg(), Matchers.equalTo("Hello John"));
	}

}
