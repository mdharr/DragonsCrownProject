package com.skilldistillery.dragonscrown.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.dragonscrown.entities.StatScaling;

public interface StatScalingRepository extends JpaRepository<StatScaling, Integer> {

	StatScaling findById(int statScalingId);
}
