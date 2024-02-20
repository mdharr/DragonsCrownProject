package com.skilldistillery.dragonscrown.entities;

import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
public class SkillDetails {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private int rank;
	
	@Column(name = "required_skill_points")
	private int requiredSkillPoints;
	
	@Column(name = "similar_skill_points")
	private int similarSkillPoints;
	
	@Column(name = "required_player_level")
	private int requiredPlayerLevel;
	
	private String effects;
	
	@JsonIgnore
	@ManyToOne
	@JoinColumn(name = "skill_id")
	private Skill skill;

	public SkillDetails() {
		super();
		// TODO Auto-generated constructor stub
	}

	public SkillDetails(int id, int rank, int requiredSkillPoints, int similarSkillPoints, int requiredPlayerLevel,
			String effects, Skill skill) {
		super();
		this.id = id;
		this.rank = rank;
		this.requiredSkillPoints = requiredSkillPoints;
		this.similarSkillPoints = similarSkillPoints;
		this.requiredPlayerLevel = requiredPlayerLevel;
		this.effects = effects;
		this.skill = skill;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getRank() {
		return rank;
	}

	public void setRank(int rank) {
		this.rank = rank;
	}

	public int getRequiredSkillPoints() {
		return requiredSkillPoints;
	}

	public void setRequiredSkillPoints(int requiredSkillPoints) {
		this.requiredSkillPoints = requiredSkillPoints;
	}

	public int getSimilarSkillPoints() {
		return similarSkillPoints;
	}

	public void setSimilarSkillPoints(int similarSkillPoints) {
		this.similarSkillPoints = similarSkillPoints;
	}

	public int getRequiredPlayerLevel() {
		return requiredPlayerLevel;
	}

	public void setRequiredPlayerLevel(int requiredPlayerLevel) {
		this.requiredPlayerLevel = requiredPlayerLevel;
	}

	public String getEffects() {
		return effects;
	}

	public void setEffects(String effects) {
		this.effects = effects;
	}

	public Skill getSkill() {
		return skill;
	}

	public void setSkill(Skill skill) {
		this.skill = skill;
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
		SkillDetails other = (SkillDetails) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "SkillDetails [id=" + id + ", rank=" + rank + ", requiredSkillPoints=" + requiredSkillPoints
				+ ", similarSkillPoints=" + similarSkillPoints + ", requiredPlayerLevel=" + requiredPlayerLevel
				+ ", effects=" + effects + ", skill=" + skill + "]";
	}
	
}
