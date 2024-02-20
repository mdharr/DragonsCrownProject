package com.skilldistillery.dragonscrown.services;

import java.util.List;

import com.skilldistillery.dragonscrown.entities.PlayerClassHasSkill;

public interface PlayerClassHasSkillService {

	public List<PlayerClassHasSkill> findAll();
	public PlayerClassHasSkill findById(int playerClassHasSkillId);
}
