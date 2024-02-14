package com.skilldistillery.dragonscrown.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.dragonscrown.repositories.ClassStatsRepository;

@Service
public class ClassStatsServiceImpl implements ClassStatsService {

	@Autowired
	private ClassStatsRepository classStatsRepo;
}
