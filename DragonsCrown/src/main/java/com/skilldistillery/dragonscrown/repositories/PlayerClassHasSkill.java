package com.skilldistillery.dragonscrown.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

public interface PlayerClassHasSkill extends JpaRepository<PlayerClassHasSkill, Integer> {

	PlayerClassHasSkill findById(int playerClassHasSkillId);
}
