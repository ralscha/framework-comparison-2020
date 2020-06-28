package com.example.quarkus;

import javax.enterprise.inject.Produces;
import javax.inject.Singleton;

import org.eclipse.microprofile.config.inject.ConfigProperty;

@Singleton
public class MessageServiceFactory {

	private final String message;

	public MessageServiceFactory(@ConfigProperty(name = "hello.message",
			defaultValue = "Hello") String message) {
		this.message = message;
	}

	@Singleton
	@Produces
	MessageService messageService() {
		return new MessageService(this.message);
	}
}
