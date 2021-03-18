package com.example.springboot;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration(proxyBeanMethods = false)
public class MessageServiceFactory {

	private final String message;

	public MessageServiceFactory(@Value("${hello.message:Hello}") String message) {
		this.message = message;
	}

	@Bean
	public MessageService messageService() {
		return new MessageService(this.message);
	}
}
