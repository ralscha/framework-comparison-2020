package com.example.quarkus;

import jakarta.validation.constraints.NotBlank;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.PathParam;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;

@Path("/")
public class MessageResource {

	@GET
	@Path("/helloJSON/{name}")
	@Produces(MediaType.APPLICATION_JSON)
	public HelloMessage helloJSON(@NotBlank @PathParam("name") String name) {
		return new HelloMessage("Hello " + name, System.currentTimeMillis());
	}
}