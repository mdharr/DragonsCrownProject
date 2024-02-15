package com.skilldistillery.dragonscrown.services;

import java.util.List;

import com.skilldistillery.dragonscrown.entities.ClassStats;

public interface ClassStatsService {

	public List<ClassStats> findAll();
	public ClassStats findById(int classStatsId);
}
