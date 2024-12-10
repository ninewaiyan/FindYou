package com.findyou.models;

public class Batch {

	private Long id ;
	private String batch;
	
	public Batch(Long id, String batch) {
		super();
		this.id = id;
		this.batch = batch;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getBatch() {
		return batch;
	}

	public void setBatch(String batch) {
		this.batch = batch;
	}
	
	
	
}
