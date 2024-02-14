package com.skilldistillery.dragonscrown.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class PlayerClassTest {
	
	private static EntityManagerFactory emf;
	private EntityManager em;
	private PlayerClass playerClass;

	@BeforeAll
	static void setUpBeforeClass() throws Exception {
		emf = Persistence.createEntityManagerFactory("JPADragonsCrown");
	}

	@AfterAll
	static void tearDownAfterClass() throws Exception {
		emf.close();
	}

	@BeforeEach
	void setUp() throws Exception {
		em = emf.createEntityManager();
		playerClass = em.find(PlayerClass.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		playerClass = null;
	}

	@Test
	void test_PlayerClass_entity_mapping() {
		assertNotNull(playerClass);
		assertEquals("Fighter", playerClass.getName());
	}
	
	@Test
	void test_PlayerClass_ClassStats_one_to_many_mapping() {
		assertNotNull(playerClass);
		assertEquals(16, playerClass.getClassStats().get(0).getStrength());
	}

}
