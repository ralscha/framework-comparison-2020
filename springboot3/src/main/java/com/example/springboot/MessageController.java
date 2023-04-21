package com.example.springboot;


import org.springframework.http.MediaType;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import jakarta.validation.constraints.NotBlank;

@RestController
@RequestMapping("/")
@Validated
public class MessageController {

	@GetMapping(value = "/helloJSON/{name}", produces = MediaType.APPLICATION_JSON_VALUE)
	public HelloMessage helloJSON(@NotBlank @PathVariable("name") String name) {
		return new HelloMessage("Hello " + name, System.currentTimeMillis());
	}
}
