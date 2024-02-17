package com.skilldistillery.dragonscrown.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.dragonscrown.entities.Recommendation;
import com.skilldistillery.dragonscrown.repositories.RecommendationRepository;

@Service
public class RecommendationServiceImpl implements RecommendationService {

	@Autowired
	private RecommendationRepository recommendationRepo;
	
	@Override
	public List<Recommendation> findAll() {
		return recommendationRepo.findAll();
	}

	@Override
	public Recommendation find(int recommendationId) {
		Recommendation recommendation = recommendationRepo.findById(recommendationId);
		if(recommendation != null) {
			return recommendation;
		}
		return null;
	}

}
