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

import com.skilldistillery.dragonscrown.entities.PlayerClass;
import com.skilldistillery.dragonscrown.services.PlayerClassService;

@RestController
@CrossOrigin({"*", "http://localhost"})
@RequestMapping("api")
public class PlayerClassController {

	@Autowired
	private PlayerClassService playerClassService;
	
	@GetMapping("classes")
	public ResponseEntity<List<PlayerClass>> getAllPlayerClasses() {
		List<PlayerClass> playerClasses = playerClassService.findAll();
		
		if(playerClasses.isEmpty()) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		else {
			return new ResponseEntity<>(playerClasses, HttpStatus.OK);
		}
	}
	
	@GetMapping("classes/{cid}")
	public ResponseEntity<PlayerClass> getPlayerClassById(@PathVariable("cid") int playerClassId) {
		PlayerClass playerClass = playerClassService.find(playerClassId);
		
		if (playerClass != null) {
			return new ResponseEntity<>(playerClass, HttpStatus.OK);
		}
		else {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
	}
}
