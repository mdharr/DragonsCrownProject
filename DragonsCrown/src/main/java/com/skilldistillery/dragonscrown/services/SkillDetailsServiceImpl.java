package com.skilldistillery.dragonscrown.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.dragonscrown.entities.SkillDetails;
import com.skilldistillery.dragonscrown.repositories.SkillDetailsRepository;

@Service
public class SkillDetailsServiceImpl implements SkillDetailsService {
	
	@Autowired
	private SkillDetailsRepository skillDetailsRepo;

	@Override
	public List<SkillDetails> findAll() {
		return skillDetailsRepo.findAll();
	}

	@Override
	public SkillDetails findById(int skillDetailsId) {
		SkillDetails skillDetails = skillDetailsRepo.findById(skillDetailsId);
		if (skillDetails != null) {
			return skillDetails;
		}
		return null;
	}

}
