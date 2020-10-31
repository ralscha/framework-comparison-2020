package com.example.micronaut;

import javax.inject.Singleton;

import io.micronaut.context.annotation.Factory;
import io.micronaut.context.annotation.Property;

@Factory
public class MessageServiceFactory {

	private final String message;

	public MessageServiceFactory(
			@Property(name = "hello.message", defaultValue = "Hello") String message) {
		this.message = message;
	}

	@Singleton
	MessageService messageService() {
		return new MessageService(this.message);
	}
}
