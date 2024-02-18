package com.skilldistillery.dragonscrown.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.dragonscrown.entities.StatScaling;
import com.skilldistillery.dragonscrown.services.StatScalingService;

@RestController
@CrossOrigin({"*", "http://localhost"})
@RequestMapping("api")
public class StatScalingController {

	@Autowired
	private StatScalingService statScalingService;
	
	@GetMapping("stat-scalings")
	public ResponseEntity<List<StatScaling>> getAllStatScalings() {
		List<StatScaling> statScalings = statScalingService.findAll();
		
		if(statScalings.isEmpty()) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		else {
			return new ResponseEntity<>(statScalings, HttpStatus.OK);
		}
	}
	
	@GetMapping("stat-scalings/{ssid}")
	public ResponseEntity<StatScaling> getStatScalingById(@PathVariable("ssid") int statScalingId) {
		StatScaling statScaling = statScalingService.find(statScalingId);
		
		if (statScaling != null) {
			return new ResponseEntity<>(statScaling, HttpStatus.OK);
		}
		else {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
	}
}
