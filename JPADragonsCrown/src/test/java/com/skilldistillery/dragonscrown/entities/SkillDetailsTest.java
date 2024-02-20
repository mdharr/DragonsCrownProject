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

class SkillDetailsTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private SkillDetails skillDetails;

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
		skillDetails = em.find(SkillDetails.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		skillDetails = null;
	}

	@Test
	void test_SkillDetails_entity_mapping() {
		assertNotNull(skillDetails);
		assertEquals("Power 30, Knockback + 30%", skillDetails.getEffects());
	}

}
