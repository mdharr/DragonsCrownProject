package com.skilldistillery.dragonscrown.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.dragonscrown.entities.PlayerClass;

public interface PlayerClassRepository extends JpaRepository<PlayerClass, Integer> {
	PlayerClass findById(int playerClassId);
}
