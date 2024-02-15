package com.skilldistillery.dragonscrown.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.dragonscrown.entities.ClassStats;
import com.skilldistillery.dragonscrown.repositories.ClassStatsRepository;

@Service
public class ClassStatsServiceImpl implements ClassStatsService {

	@Autowired
	private ClassStatsRepository classStatsRepo;

	@Override
	public List<ClassStats> findAll() {
		return classStatsRepo.findAll();
	}

	@Override
	public ClassStats findById(int classStatsId) {
		ClassStats classStats = classStatsRepo.findById(classStatsId);
		if(classStats != null) {
			return classStats;
		}
		return null;
	}
}
