package com.skilldistillery.dragonscrown.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Skill {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String name;
	private String description;
	@Column(name = "card_image_url")
	private String cardImageUrl;
	@Column(name = "is_common")
	private boolean isCommon;
	public Skill() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Skill(int id, String name, String description, String cardImageUrl, boolean isCommon) {
		super();
		this.id = id;
		this.name = name;
		this.description = description;
		this.cardImageUrl = cardImageUrl;
		this.isCommon = isCommon;
	}
	
	
}
