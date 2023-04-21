package com.example.myproject;

import io.helidon.webserver.Routing;
import io.helidon.webserver.ServerRequest;
import io.helidon.webserver.ServerResponse;
import io.helidon.webserver.Service;

public class GreetService implements Service {

	@Override
	public void update(Routing.Rules rules) {
		rules.get("/{name}", this::getMessageHandler);
	}

	private void getMessageHandler(ServerRequest request, ServerResponse response) {
		sendResponse(response, request.path().param("name"));
	}

	private static void sendResponse(ServerResponse response, String name) {
		response.send(new HelloMessage("Hello " + name, System.currentTimeMillis()));
	}

}
