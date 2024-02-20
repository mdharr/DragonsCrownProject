package com.skilldistillery.dragonscrown.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.dragonscrown.entities.SkillDetails;

public interface SkillDetailsRepository extends JpaRepository<SkillDetails, Integer> {

	SkillDetails findById(int skillDetailsId);
}
