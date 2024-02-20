package com.skilldistillery.dragonscrown.services;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.dragonscrown.entities.PlayerClass;
import com.skilldistillery.dragonscrown.repositories.PlayerClassRepository;

@Service
public class PlayerClassServiceImpl implements PlayerClassService {

	@Autowired
	private PlayerClassRepository playerClassRepo;
	
	@Override
	public List<PlayerClass> findAll() {
		return playerClassRepo.findAll();
	}
	
	@Override
	public PlayerClass find(int playerClassId) {
		PlayerClass playerClass = playerClassRepo.findById(playerClassId);
		if(playerClass != null) {
			return playerClass;
		}
		return null;
	}

}
