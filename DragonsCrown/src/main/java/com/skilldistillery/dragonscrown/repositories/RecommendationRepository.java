package com.skilldistillery.dragonscrown.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.dragonscrown.entities.Recommendation;

public interface RecommendationRepository extends JpaRepository<Recommendation, Integer> {

	Recommendation findById(int recommendationId);
}
