package com.skilldistillery.dragonscrown.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.dragonscrown.entities.PlayerClassHasSkill;

public interface PlayerClassHasSkillRepository extends JpaRepository<PlayerClassHasSkill, Integer> {

	PlayerClassHasSkill findById(int playerClassHasSkillId);
}
