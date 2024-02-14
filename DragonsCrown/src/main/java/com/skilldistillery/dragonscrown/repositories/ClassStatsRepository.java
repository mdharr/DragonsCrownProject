package com.skilldistillery.dragonscrown.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.dragonscrown.entities.ClassStats;

public interface ClassStatsRepository extends JpaRepository<ClassStats, Integer> {
	ClassStats findById(int classStatsId);
}
