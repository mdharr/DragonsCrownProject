package com.skilldistillery.dragonscrown.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

public interface SkillDetails extends JpaRepository<SkillDetails, Integer> {

	SkillDetails findById(int skillDetailsId);
}
