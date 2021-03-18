package com.example.quarkus;

import javax.enterprise.context.ApplicationScoped;
import javax.enterprise.inject.Produces;

import org.eclipse.microprofile.config.inject.ConfigProperty;

@ApplicationScoped
public class MessageServiceFactory {

	private final String message;

	public MessageServiceFactory(@ConfigProperty(name = "hello.message",
			defaultValue = "Hello") String message) {
		this.message = message;
	}

	@ApplicationScoped
	@Produces
	MessageService messageService() {
		return new MessageService(this.message);
	}
}
