package com.skilldistillery.dragonscrown.entities;

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
	
	
}
