package com.skilldistillery.dragonscrown.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.dragonscrown.entities.Skill;

public interface SkillRepository extends JpaRepository<Skill, Integer> {

}
