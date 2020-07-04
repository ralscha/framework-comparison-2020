package com.example.micronaut;

import io.micronaut.core.annotation.Introspected;

@Introspected
public class HelloMessage {
	private final String msg;

	private final long ts;

	public HelloMessage(String msg) {
		this.msg = msg;
		this.ts = System.currentTimeMillis();
	}

	public String getMsg() {
		return this.msg;
	}

	public long getTs() {
		return this.ts;
	}
}
