package com.skilldistillery.dragonscrown.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.dragonscrown.entities.Quest;

public interface QuestRepository extends JpaRepository<Quest, Integer> {
	
	Quest findById(int questId);
}
