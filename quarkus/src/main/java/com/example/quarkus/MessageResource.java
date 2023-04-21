package com.example.quarkus;

import javax.validation.constraints.NotBlank;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

@Path("/")
public class MessageResource {

	@GET
	@Path("/helloJSON/{name}")
	@Produces(MediaType.APPLICATION_JSON)
	public HelloMessage helloJSON(@NotBlank @PathParam("name") String name) {
		return new HelloMessage("Hello " + name, System.currentTimeMillis());
	}
}