package com.example.springboot;

import javax.validation.constraints.NotBlank;

import org.springframework.http.MediaType;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/")
@Validated
public class MessageController {
	private final MessageService messageService;

	public MessageController(MessageService messageService) {
		this.messageService = messageService;
	}

	@GetMapping(value = "/hello/{name}", produces = MediaType.TEXT_PLAIN_VALUE)
	String hello(@NotBlank @PathVariable("name") String name) {
		return this.messageService.sayHello(name);
	}

	@GetMapping(value = "/helloJSON/{name}", produces = MediaType.APPLICATION_JSON_VALUE)
	public HelloMessage helloJSON(@NotBlank @PathVariable("name") String name) {
		return new HelloMessage(this.messageService.sayHello(name));
	}
}
