package com.skilldistillery.dragonscrown.entities;

import static org.junit.jupiter.api.Assertions.*;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class StatScalingTest {
	
	private static EntityManagerFactory emf;
	private EntityManager em;
	private StatScaling statScaling;

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
		statScaling = em.find(StatScaling.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		statScaling = null;
	}

	@Test
	void test_StatScaling_entity_mapping() {
		assertNotNull(statScaling);
		assertEquals("S", statScaling.getStrength());
	}

}
