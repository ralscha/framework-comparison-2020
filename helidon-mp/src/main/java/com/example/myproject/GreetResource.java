
package com.example.myproject;

import jakarta.enterprise.context.RequestScoped;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.PathParam;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;

@Path("/helloJSON")
@RequestScoped
public class GreetResource {

	@Path("/{name}")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public HelloMessage getMessage(@PathParam("name") String name) {
		return new HelloMessage("Hello " + name, System.currentTimeMillis());
	}

}
