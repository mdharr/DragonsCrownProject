package com.skilldistillery.dragonscrown.services;

import java.util.List;

import com.skilldistillery.dragonscrown.entities.Skill;

public interface SkillService {

	public List<Skill> findAll();
	public Skill findById(int skillId);
}
