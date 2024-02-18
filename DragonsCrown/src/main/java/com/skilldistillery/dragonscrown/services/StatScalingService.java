package com.skilldistillery.dragonscrown.services;

import java.util.List;

import com.skilldistillery.dragonscrown.entities.StatScaling;

public interface StatScalingService {

	public List<StatScaling> findAll();
	public StatScaling find(int statScalingId);
}
