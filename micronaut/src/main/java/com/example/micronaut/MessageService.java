package com.example.micronaut;

import javax.inject.Singleton;

import io.micronaut.context.annotation.Property;

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
