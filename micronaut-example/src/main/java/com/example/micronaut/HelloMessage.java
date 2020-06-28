package com.example.micronaut;

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
