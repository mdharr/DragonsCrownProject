package com.skilldistillery.dragonscrown.controllers;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@CrossOrigin({"*", "http://localhost"})
@RequestMapping("api")
public class RecommendationController {

}
