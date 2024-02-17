package com.skilldistillery.dragonscrown.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.dragonscrown.entities.Recommendation;
import com.skilldistillery.dragonscrown.services.RecommendationService;

@RestController
@CrossOrigin({"*", "http://localhost"})
@RequestMapping("api")
public class RecommendationController {
	
	@Autowired
	private RecommendationService recommendationService;
	
	@GetMapping("recommendations")
	public ResponseEntity<List<Recommendation>> getAllRecommendations() {
		List<Recommendation> recommendations = recommendationService.findAll();
		if(recommendations.isEmpty()) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		else {
			return new ResponseEntity<>(recommendations, HttpStatus.OK);
		}
	}
}
