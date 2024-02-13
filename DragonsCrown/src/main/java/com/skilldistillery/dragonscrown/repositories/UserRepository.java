package com.skilldistillery.dragonscrown.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.dragonscrown.entities.User;

public interface UserRepository extends JpaRepository<User, Integer> {

	User findByUsername(String username);

}
