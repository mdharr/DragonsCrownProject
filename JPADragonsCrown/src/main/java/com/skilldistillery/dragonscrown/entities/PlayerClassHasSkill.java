package com.skilldistillery.dragonscrown.entities;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name = "player_class_has_skill")
public class PlayerClassHasSkill {

	@EmbeddedId
	private PlayerClassHasSkillId id;
}
