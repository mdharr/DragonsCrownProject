package com.skilldistillery.dragonscrown.services;

import java.util.List;

import com.skilldistillery.dragonscrown.entities.SkillDetails;

public interface SkillDetailsService {

	public List<SkillDetails> findAll();
	public SkillDetails findById(int skillDetailsId);
}
