package com.example.quarkus;

import javax.enterprise.context.ApplicationScoped;

import org.eclipse.microprofile.config.inject.ConfigProperty;

@ApplicationScoped
public class MessageService {
	private final String message;

	public MessageService(@ConfigProperty(name = "hello.message",
			defaultValue = "Hello") String message) {
		this.message = message;
	}

	public String sayHello(String name) {
		return this.message + " " + name;
	}
}
