package com.skilldistillery.dragonscrown.entities;

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
	@JoinColumn(name = "player_class_id")
	@MapsId("playerClassId")
	private PlayerClass playerClass;
	
	@ManyToOne
	@JoinColumn(name = "skill_id")
	@MapsId("skillId")
	private Skill skill;
}
