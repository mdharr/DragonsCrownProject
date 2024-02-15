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

import com.skilldistillery.dragonscrown.entities.ClassStats;
import com.skilldistillery.dragonscrown.services.ClassStatsService;

@RestController
@CrossOrigin({"*", "http://localhost"})
@RequestMapping("api")
public class ClassStatsController {

	@Autowired
	private ClassStatsService classStatsService;
	
	@GetMapping("classStats")
	public ResponseEntity<List<ClassStats>> getAllClassStats() {
		List<ClassStats> classStats = classStatsService.findAll();
		if (classStats.isEmpty()) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		else {
			return new ResponseEntity<>(classStats, HttpStatus.OK);
		}
	}
	
	@GetMapping("classStats/{csid}")
	public ResponseEntity<ClassStats> getClassStatsById(@PathVariable("csid") int classStatsId) {
		ClassStats classStats = classStatsService.findById(classStatsId);
		if (classStats != null) {
			return new ResponseEntity<>(classStats, HttpStatus.OK);
		}
		else {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
	}
}
