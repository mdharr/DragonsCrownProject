package com.skilldistillery.dragonscrown.services;

import java.util.List;

import com.skilldistillery.dragonscrown.entities.PlayerClassHasQuest;

public interface PlayerClassHasQuestService {

	public List<PlayerClassHasQuest> findAll();
	public PlayerClassHasQuest find(int playerClassHasQuestId);
}