package com.skilldistillery.dragonscrown.entities;

import java.util.Objects;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
public class Recommendation {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String description;
	
	@JsonIgnore
	@ManyToOne
	@JoinColumn(name = "player_class_id")
	private PlayerClass playerClass;

	public Recommendation() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Recommendation(int id, String description, PlayerClass playerClass) {
		super();
		this.id = id;
		this.description = description;
		this.playerClass = playerClass;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public PlayerClass getPlayerClass() {
		return playerClass;
	}

	public void setPlayerClass(PlayerClass playerClass) {
		this.playerClass = playerClass;
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
		Recommendation other = (Recommendation) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "Recommendation [id=" + id + ", description=" + description + ", playerClass=" + playerClass + "]";
	}
	
}
