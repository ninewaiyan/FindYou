package com.findyou.models;

import java.util.Date;

public class User {

	private Long id;
	private String name;
	private String email;
	private String password;
	private String photo;
	private String gender;
	private String bio; // default null
	private String hobby; // default null
	private String description; // default null

	private Long batch_id;

	private Date birthday;// default null

	private String phone; // default null
	private String fbLink; // default null
	private String tgLink; // default null
	private String ttLink; // default null
	private String igLink;// default unll
	private String batch;

	public String getBatch() {
		return batch;
	}

	public void setBatch_name(String batch) {
		this.batch = batch;
	}

	public void setTgLink(String tgLink) {
		this.tgLink = tgLink;
	}

	public User() {
	}

	public User(Long id, String name, String email, String password, String photo, String gender, String bio,
			String hobby, String description, Long batch_id, Date birthday, String phone, String fbLink, String tgLink,
			String ttLink, String igLink) {
		super();
		this.id = id;
		this.name = name;
		this.email = email;
		this.password = password;
		this.photo = photo;
		this.gender = gender;
		this.bio = bio;
		this.hobby = hobby;
		this.description = description;
		this.batch_id = batch_id;
		this.birthday = birthday;
		this.phone = phone;
		this.fbLink = fbLink;
		this.tgLink = tgLink;
		this.ttLink = ttLink;
		this.igLink = igLink;

	}

	public User(Long id, String name, String photo, String bio, String hobby, String description, Long batch_id,
			Date birthday, String phone, String fbLink, String tgLink, String ttLink, String igLink) {
		super();
		this.id = id;
		this.name = name;
		this.photo = photo;
		this.bio = bio;
		this.hobby = hobby;
		this.description = description;
		this.batch_id = batch_id;
		this.birthday = birthday;
		this.phone = phone;
		this.fbLink = fbLink;
		this.tgLink = tgLink;
		this.ttLink = ttLink;
		this.igLink = igLink;

	}

	

	public User(Long id, String name, String email, String password, String photo, String gender, String bio,
			String hobby, String description, Long batch_id, Date birthday, String phone, String fbLink, String tgLink,
			String ttLink, String igLink, String batch) {
		super();
		this.id = id;
		this.name = name;
		this.email = email;
		this.password = password;
		this.photo = photo;
		this.gender = gender;
		this.bio = bio;
		this.hobby = hobby;
		this.description = description;
		this.batch_id = batch_id;
		this.birthday = birthday;
		this.phone = phone;
		this.fbLink = fbLink;
		this.tgLink = tgLink;
		this.ttLink = ttLink;
		this.igLink = igLink;
		this.batch_id = batch_id;

	}

	public User(String name, String email, String password, String photo, String gender, Long batch_id) {
		super();
		this.name = name;
		this.email = email;
		this.password = password;
		this.photo = photo;
		this.gender = gender;
		this.batch_id = batch_id;

	}

	public User(String name, String email, String password, String photo, String gender, Long batch_id, String batch) {
		super();
		this.name = name;
		this.email = email;
		this.password = password;
		this.photo = photo;
		this.gender = gender;
		this.batch_id = batch_id;
		this.batch = batch;
	}

	

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getBio() {
		return bio;
	}

	public void setBio(String bio) {
		this.bio = bio;
	}

	public String getHobby() {
		return hobby;
	}

	public void setHobby(String hobby) {
		this.hobby = hobby;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Long getBatch_id() {
		return batch_id;
	}

	public void setBatch_id(Long batch_id) {
		this.batch_id = batch_id;
	}

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getFbLink() {
		return fbLink;
	}

	public void setFbLink(String fbLink) {
		this.fbLink = fbLink;
	}

	public String getTgLink() {
		return tgLink;
	}

	public void setTgLihk(String tgLink) {
		this.tgLink = tgLink;
	}

	public String getTtLink() {
		return ttLink;
	}

	public void setTtLink(String ttLink) {
		this.ttLink = ttLink;
	}

	public String getIgLink() {
		return igLink;
	}

	public void setIgLink(String igLink) {
		this.igLink = igLink;
	}

	public void setBatch(String batch) {
		this.batch = batch;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	
}
