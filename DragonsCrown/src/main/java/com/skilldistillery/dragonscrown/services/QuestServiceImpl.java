package com.skilldistillery.dragonscrown.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.dragonscrown.entities.Quest;
import com.skilldistillery.dragonscrown.repositories.QuestRepository;

@Service
public class QuestServiceImpl implements QuestService {

	@Autowired
	private QuestRepository questRepo;
	
	@Override
	public List<Quest> findAll() {
		return questRepo.findAll();
	}

	@Override
	public Quest findById(int questId) {
		Quest quest = questRepo.findById(questId);
		if (quest != null) {
			return quest;
		}
		return null;
	}

}
