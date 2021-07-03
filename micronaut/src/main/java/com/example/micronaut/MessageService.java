package com.example.micronaut;

import io.micronaut.context.annotation.Property;
import jakarta.inject.Singleton;

@Singleton
public class MessageService {
	private final String message;

	public MessageService(
			@Property(name = "hello.message", defaultValue = "Hello") String message) {
		this.message = message;
	}

	public String sayHello(String name) {
		return this.message + " " + name;
	}
}
