package com.skilldistillery.dragonscrown.entities;

import java.util.Objects;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;

@Entity
@Table(name = "player_class_has_skill")
public class PlayerClassHasSkill {

	@EmbeddedId
	private PlayerClassHasSkillId id;
	
    @ManyToOne
    @MapsId("playerClassId")
    @JoinColumn(name = "player_class_id")
    private PlayerClass playerClass;

    @ManyToOne
    @MapsId("skillId")
    @JoinColumn(name = "skill_id")
    private Skill skill;

	public PlayerClassHasSkill() {
		super();
		// TODO Auto-generated constructor stub
	}

	public PlayerClassHasSkill(PlayerClassHasSkillId id, PlayerClass playerClass, Skill skill) {
		super();
		this.id = id;
		this.playerClass = playerClass;
		this.skill = skill;
	}

	public PlayerClassHasSkillId getId() {
		return id;
	}

	public void setId(PlayerClassHasSkillId id) {
		this.id = id;
	}

	public PlayerClass getPlayerClass() {
		return playerClass;
	}

	public void setPlayerClass(PlayerClass playerClass) {
		this.playerClass = playerClass;
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
		PlayerClassHasSkill other = (PlayerClassHasSkill) obj;
		return Objects.equals(id, other.id);
	}

	@Override
	public String toString() {
		return "PlayerClassHasSkill [id=" + id + ", playerClass=" + playerClass + ", skill=" + skill + "]";
	}
	
}
