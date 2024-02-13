package com.skilldistillery.dragonscrown.services;

import com.skilldistillery.dragonscrown.entities.User;

public interface AuthService {
	
	public User register(User user);
	public User getUserByUsername(String username);

}
