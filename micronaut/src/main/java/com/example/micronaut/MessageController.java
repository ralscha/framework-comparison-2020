package com.example.micronaut;

import javax.validation.constraints.NotBlank;

import io.micronaut.http.MediaType;
import io.micronaut.http.annotation.Controller;
import io.micronaut.http.annotation.Get;
import io.micronaut.http.annotation.PathVariable;

@Controller
public class MessageController {
	private final MessageService messageService;

	public MessageController(MessageService messageService) {
		this.messageService = messageService;
	}

	@Get(value = "/hello/{name}", produces = MediaType.TEXT_PLAIN)
	public String hello(@NotBlank @PathVariable("name") String name) {
		return this.messageService.sayHello(name);
	}

	@Get(value = "/helloJSON/{name}", produces = MediaType.APPLICATION_JSON)
	public HelloMessage helloJSON(@NotBlank @PathVariable("name") String name) {
		return new HelloMessage(this.messageService.sayHello(name));
	}
}
