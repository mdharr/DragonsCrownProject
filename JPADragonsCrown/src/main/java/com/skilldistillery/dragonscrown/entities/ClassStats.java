package com.skilldistillery.dragonscrown.entities;

import java.util.Objects;

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
	
	@Column(name = "skill_points")
	private int skillPoints;
	
	@JsonIgnore
	@ManyToOne
	@JoinColumn(name = "player_class_id")
	private PlayerClass playerClass;

	public ClassStats() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ClassStats(int id, int level, int health, int strength, int intelligence, int constitution,
			int magicResistance, int dexterity, int luck, int requiredExp, int skillPoints, PlayerClass playerClass) {
		super();
		this.id = id;
		this.level = level;
		this.health = health;
		this.strength = strength;
		this.intelligence = intelligence;
		this.constitution = constitution;
		this.magicResistance = magicResistance;
		this.dexterity = dexterity;
		this.luck = luck;
		this.requiredExp = requiredExp;
		this.skillPoints = skillPoints;
		this.playerClass = playerClass;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getLevel() {
		return level;
	}

	public void setLevel(int level) {
		this.level = level;
	}

	public int getHealth() {
		return health;
	}

	public void setHealth(int health) {
		this.health = health;
	}

	public int getStrength() {
		return strength;
	}

	public void setStrength(int strength) {
		this.strength = strength;
	}

	public int getIntelligence() {
		return intelligence;
	}

	public void setIntelligence(int intelligence) {
		this.intelligence = intelligence;
	}

	public int getConstitution() {
		return constitution;
	}

	public void setConstitution(int constitution) {
		this.constitution = constitution;
	}

	public int getMagicResistance() {
		return magicResistance;
	}

	public void setMagicResistance(int magicResistance) {
		this.magicResistance = magicResistance;
	}

	public int getDexterity() {
		return dexterity;
	}

	public void setDexterity(int dexterity) {
		this.dexterity = dexterity;
	}

	public int getLuck() {
		return luck;
	}

	public void setLuck(int luck) {
		this.luck = luck;
	}

	public int getRequiredExp() {
		return requiredExp;
	}

	public void setRequiredExp(int requiredExp) {
		this.requiredExp = requiredExp;
	}

	public int getSkillPoints() {
		return skillPoints;
	}

	public void setSkillPoints(int skillPoints) {
		this.skillPoints = skillPoints;
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
		ClassStats other = (ClassStats) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "ClassStats [id=" + id + ", level=" + level + ", health=" + health + ", strength=" + strength
				+ ", intelligence=" + intelligence + ", constitution=" + constitution + ", magicResistance="
				+ magicResistance + ", dexterity=" + dexterity + ", luck=" + luck + ", requiredExp=" + requiredExp
				+ ", playerClass=" + playerClass + "]";
	}

}
