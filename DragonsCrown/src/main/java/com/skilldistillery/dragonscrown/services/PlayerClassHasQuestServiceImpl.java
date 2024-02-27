package com.skilldistillery.dragonscrown.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.dragonscrown.entities.PlayerClassHasQuest;
import com.skilldistillery.dragonscrown.repositories.PlayerClassHasQuestRepository;

@Service
public class PlayerClassHasQuestServiceImpl implements PlayerClassHasQuestService {

	@Autowired
	private PlayerClassHasQuestRepository playerClassHasQuestRepo;
	
	@Override
	public List<PlayerClassHasQuest> findAll() {
		return playerClassHasQuestRepo.findAll();
	}

	@Override
	public PlayerClassHasQuest find(int playerClassHasQuestId) {
		PlayerClassHasQuest playerClassHasQuest = playerClassHasQuestRepo.findById(playerClassHasQuestId);
		if (playerClassHasQuest != null) {
			return playerClassHasQuest;
		}
		return null;
	}

}
