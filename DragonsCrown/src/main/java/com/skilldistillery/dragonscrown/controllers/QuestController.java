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

import com.skilldistillery.dragonscrown.entities.Quest;
import com.skilldistillery.dragonscrown.services.QuestService;

@RestController
@CrossOrigin({"*", "http://localhost"})
@RequestMapping("api")
public class QuestController {

	@Autowired
	private QuestService questService;
	
	@GetMapping("quests")
	public ResponseEntity<List<Quest>> getAllQuests() {
		List<Quest> quests = questService.findAll();
		if (quests != null) {
			return new ResponseEntity<>(quests, HttpStatus.OK);
		}
		else {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
	}
	
	@GetMapping("quests/{qid}")
	public ResponseEntity<Quest> getQuestById(@PathVariable("qid") int questId) {
		Quest quest = questService.findById(questId);
		if (quest != null) {
			return new ResponseEntity<>(quest, HttpStatus.OK);
		}
		else {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
	}
}
