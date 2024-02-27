package com.skilldistillery.dragonscrown.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.dragonscrown.entities.PlayerClassHasQuest;

public interface PlayerClassHasQuestRepository extends JpaRepository<PlayerClassHasQuest, Integer> {

	PlayerClassHasQuest findById(int playerClassHasQuestId);
}
