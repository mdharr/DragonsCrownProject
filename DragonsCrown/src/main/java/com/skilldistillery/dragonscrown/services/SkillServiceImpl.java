package com.skilldistillery.dragonscrown.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.dragonscrown.entities.Skill;
import com.skilldistillery.dragonscrown.repositories.SkillRepository;

@Service
public class SkillServiceImpl implements SkillService {
	
	@Autowired
	private SkillRepository skillRepo;

	@Override
	public List<Skill> findAll() {
		return skillRepo.findAll();
	}

	@Override
	public Skill findById(int skillId) {
		Skill skill = skillRepo.findById(skillId);
		if (skill != null) {
			return skill;
		}
		return null;
	}

}
