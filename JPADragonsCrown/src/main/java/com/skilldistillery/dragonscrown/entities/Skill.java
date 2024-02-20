package com.skilldistillery.dragonscrown.entities;

import java.util.Objects;

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
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getCardImageUrl() {
		return cardImageUrl;
	}
	public void setCardImageUrl(String cardImageUrl) {
		this.cardImageUrl = cardImageUrl;
	}
	public boolean isCommon() {
		return isCommon;
	}
	public void setCommon(boolean isCommon) {
		this.isCommon = isCommon;
	}
	@Override
	public int hashCode() {
		return Objects.hash(id);
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Skill other = (Skill) obj;
		return id == other.id;
	}
	@Override
	public String toString() {
		return "Skill [id=" + id + ", name=" + name + ", description=" + description + ", cardImageUrl=" + cardImageUrl
				+ ", isCommon=" + isCommon + "]";
	}
	
}
