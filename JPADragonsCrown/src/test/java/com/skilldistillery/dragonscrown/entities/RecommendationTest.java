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

class RecommendationTest {
	
	private static EntityManagerFactory emf;
	private EntityManager em;
	private Recommendation recommendation;

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
		recommendation = em.find(Recommendation.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		recommendation = null;
	}

	@Test
	void test_Recommendation_entity_mapping() {
		assertNotNull(recommendation);
		assertEquals("I want to play as an orthodox warrior who wields a sword.", recommendation.getDescription());
	}

}
