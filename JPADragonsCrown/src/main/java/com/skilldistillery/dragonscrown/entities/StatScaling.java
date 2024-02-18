package com.skilldistillery.dragonscrown.entities;

import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToOne;

@Entity
public class StatScaling {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String strength;
	private String constitution;
	private String intelligence;
	
	@Column(name = "magic_resistance")
	private String magicResistance;
	
	private String dexterity;
	private String luck;
	
	@OneToOne
	private PlayerClass playerClass;
	
	public StatScaling() {
		super();
		// TODO Auto-generated constructor stub
	}
	public StatScaling(int id, String strength, String constitution, String intelligence, String magicResistance,
			String dexterity, String luck, PlayerClass playerClass) {
		super();
		this.id = id;
		this.strength = strength;
		this.constitution = constitution;
		this.intelligence = intelligence;
		this.magicResistance = magicResistance;
		this.dexterity = dexterity;
		this.luck = luck;
		this.playerClass = playerClass;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getStrength() {
		return strength;
	}
	public void setStrength(String strength) {
		this.strength = strength;
	}
	public String getConstitution() {
		return constitution;
	}
	public void setConstitution(String constitution) {
		this.constitution = constitution;
	}
	public String getIntelligence() {
		return intelligence;
	}
	public void setIntelligence(String intelligence) {
		this.intelligence = intelligence;
	}
	public String getMagicResistance() {
		return magicResistance;
	}
	public void setMagicResistance(String magicResistance) {
		this.magicResistance = magicResistance;
	}
	public String getDexterity() {
		return dexterity;
	}
	public void setDexterity(String dexterity) {
		this.dexterity = dexterity;
	}
	public String getLuck() {
		return luck;
	}
	public void setLuck(String luck) {
		this.luck = luck;
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
		StatScaling other = (StatScaling) obj;
		return id == other.id;
	}
	@Override
	public String toString() {
		return "StatScaling [id=" + id + ", strength=" + strength + ", constitution=" + constitution + ", intelligence="
				+ intelligence + ", magicResistance=" + magicResistance + ", dexterity=" + dexterity + ", luck=" + luck
				+ ", playerClass=" + playerClass + "]";
	}
	
}
