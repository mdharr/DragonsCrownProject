package com.skilldistillery.dragonscrown.entities;

import java.util.List;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "player_class")
public class PlayerClass {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String name;
	private String description;
	@Column(name = "animation_url")
	private String animationUrl;
	@Column(name = "artwork_url")
	private String artworkUrl;
	@Column(name = "title_url")
	private String titleUrl;
	
	@OneToMany(mappedBy = "playerClass")
	private List<ClassStats> classStats;
	
	public PlayerClass() {
		super();
		// TODO Auto-generated constructor stub
	}

	public PlayerClass(int id, String name, String description, String animationUrl, String artworkUrl, String titleUrl,
			List<ClassStats> classStats) {
		super();
		this.id = id;
		this.name = name;
		this.description = description;
		this.animationUrl = animationUrl;
		this.artworkUrl = artworkUrl;
		this.titleUrl = titleUrl;
		this.classStats = classStats;
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
	public String getAnimationUrl() {
		return animationUrl;
	}
	public void setAnimationUrl(String animationUrl) {
		this.animationUrl = animationUrl;
	}
	public String getArtworkUrl() {
		return artworkUrl;
	}
	public void setArtworkUrl(String artworkUrl) {
		this.artworkUrl = artworkUrl;
	}
	
	public String getTitleUrl() {
		return titleUrl;
	}

	public void setTitleUrl(String titleUrl) {
		this.titleUrl = titleUrl;
	}

	public List<ClassStats> getClassStats() {
		return classStats;
	}

	public void setClassStats(List<ClassStats> classStats) {
		this.classStats = classStats;
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
		PlayerClass other = (PlayerClass) obj;
		return id == other.id;
	}
	@Override
	public String toString() {
		return "PlayerClass [id=" + id + ", name=" + name + ", description=" + description + ", animationUrl="
				+ animationUrl + ", artworkUrl=" + artworkUrl + ", titleUrl=" + titleUrl + ", classStats=" + classStats
				+ "]";
	}
	
}
