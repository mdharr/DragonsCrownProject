package com.skilldistillery.dragonscrown.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.dragonscrown.entities.PlayerClassHasSkill;
import com.skilldistillery.dragonscrown.repositories.PlayerClassHasSkillRepository;

@Service
public class PlayerClassHasSkillServiceImpl implements PlayerClassHasSkillService {
	
	@Autowired
	private PlayerClassHasSkillRepository playerClassHasSkillRepo;

	@Override
	public List<PlayerClassHasSkill> findAll() {
		return playerClassHasSkillRepo.findAll();
	}

	@Override
	public PlayerClassHasSkill findById(int playerClassHasSkillId) {
		PlayerClassHasSkill playerClassHasSkill = playerClassHasSkillRepo.findById(playerClassHasSkillId);
		if (playerClassHasSkill != null) {
			return playerClassHasSkill;
		}
		return null;
	}

}
