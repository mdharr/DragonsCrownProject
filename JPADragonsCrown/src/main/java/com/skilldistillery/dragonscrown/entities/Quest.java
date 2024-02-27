package com.skilldistillery.dragonscrown.entities;

import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Quest {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String name;
	
	@Column(name = "skill_points")
	private int skillPoints;
	private String description;
	private String location;
	private String path;
	
	public Quest() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public Quest(int id, String name, int skillPoints, String description, String location, String path) {
		super();
		this.id = id;
		this.name = name;
		this.skillPoints = skillPoints;
		this.description = description;
		this.location = location;
		this.path = path;
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

	public int getSkillPoints() {
		return skillPoints;
	}

	public void setSkillPoints(int skillPoints) {
		this.skillPoints = skillPoints;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
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
		Quest other = (Quest) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "Quest [id=" + id + ", name=" + name + ", skillPoints=" + skillPoints + ", description=" + description
				+ ", location=" + location + ", path=" + path + "]";
	}
	
}
