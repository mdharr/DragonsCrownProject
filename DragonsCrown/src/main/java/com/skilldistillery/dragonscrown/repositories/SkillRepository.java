package com.skilldistillery.dragonscrown.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.dragonscrown.entities.Skill;

public interface SkillRepository extends JpaRepository<Skill, Integer> {

	Skill findById(int skillId);
	List<Skill> findByIsCommonTrue();
}
