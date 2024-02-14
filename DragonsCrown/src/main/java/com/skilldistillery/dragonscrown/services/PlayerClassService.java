package com.skilldistillery.dragonscrown.services;

import java.util.List;

import com.skilldistillery.dragonscrown.entities.PlayerClass;

public interface PlayerClassService {

	public List<PlayerClass> findAll();
	public PlayerClass find(int playerClassId);
}
