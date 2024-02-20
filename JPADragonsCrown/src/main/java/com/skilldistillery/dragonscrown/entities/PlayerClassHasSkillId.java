package com.skilldistillery.dragonscrown.entities;

import java.io.Serializable;

import javax.persistence.Embeddable;
import javax.persistence.Table;

@Embeddable
@Table(name = "player_class_has_skill")
public class PlayerClassHasSkillId implements Serializable {

	private static final long serialVersionUID = 1L;
	
}
