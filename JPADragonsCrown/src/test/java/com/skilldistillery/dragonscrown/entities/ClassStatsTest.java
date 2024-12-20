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

class ClassStatsTest {
	
	private static EntityManagerFactory emf;
	private EntityManager em;
	private ClassStats classStats;

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
		classStats = em.find(ClassStats.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		classStats = null;
	}

	@Test
	void test_ClassStats_entity_mapping() {
		assertNotNull(classStats);
		assertEquals(16, classStats.getStrength());
	}
	
	@Test
	void test_ClassStats_PlayerClass_many_to_one_mapping() {
		assertNotNull(classStats);
		assertEquals("Fighter", classStats.getPlayerClass().getName());
	}

}
