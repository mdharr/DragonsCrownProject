package com.skilldistillery.dragonscrown.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.dragonscrown.entities.StatScaling;
import com.skilldistillery.dragonscrown.repositories.StatScalingRepository;

@Service
public class StatScalingServiceImpl implements StatScalingService {
	
	@Autowired
	private StatScalingRepository statScalingRepo;

	@Override
	public List<StatScaling> findAll() {
		return statScalingRepo.findAll();
	}

	@Override
	public StatScaling find(int statScalingId) {
		StatScaling statScaling = statScalingRepo.findById(statScalingId);
		if(statScaling != null) {
			return statScaling;
		}
		return null;
	}

}
