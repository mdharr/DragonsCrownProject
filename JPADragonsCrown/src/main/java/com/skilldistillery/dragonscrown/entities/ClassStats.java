package com.skilldistillery.dragonscrown.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "class_stats")
public class ClassStats {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private int level;
	private int health;
	private int strength;
	private int intelligence;
	private int constitution;
	
	@Column(name = "magic_resistance")
	private int magicResistance;
	private int dexterity;
	private int luck;
	
	@Column(name = "required_exp")
	private int requiredExp;
	
	@JsonIgnore
	@ManyToOne
	@JoinColumn(name = "player_class_id")
	private PlayerClass playerClass;

}
