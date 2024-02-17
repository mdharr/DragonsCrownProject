package com.skilldistillery.dragonscrown.services;

import java.util.List;

import com.skilldistillery.dragonscrown.entities.Recommendation;

public interface RecommendationService {

	public List<Recommendation> findAll();
	public Recommendation find(int recommendationId);
}
