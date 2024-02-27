package com.skilldistillery.dragonscrown.services;

import java.util.List;

import com.skilldistillery.dragonscrown.entities.Quest;

public interface QuestService {

	public List<Quest> findAll();
	public Quest findById(int questId);
}
