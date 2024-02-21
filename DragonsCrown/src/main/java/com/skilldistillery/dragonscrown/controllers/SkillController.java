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

import com.skilldistillery.dragonscrown.entities.Skill;
import com.skilldistillery.dragonscrown.services.SkillService;

@RestController
@CrossOrigin({"*", "http://localhost"})
@RequestMapping("api")
public class SkillController {

	@Autowired
	private SkillService skillService;
	
	@GetMapping("skills")
	public ResponseEntity<List<Skill>> getAllSkills() {
		List<Skill> skills = skillService.findAll();
		
		if (skills.isEmpty()) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		else {
			return new ResponseEntity<>(skills, HttpStatus.OK);
		}
	}
	
	@GetMapping("skills/{sid}")
	public ResponseEntity<Skill> getSkillById(@PathVariable("sid") int skillId) {
		Skill skill = skillService.findById(skillId);
		
		if (skill != null) {
			return new ResponseEntity<>(skill, HttpStatus.OK);
		}
		else {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
	}
}
