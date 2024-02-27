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

class QuestTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Quest quest;

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
		quest = em.find(Quest.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		quest = null;
	}

	@Test
	void test_Quest_entity_mapping() {
		assertNotNull(quest);
		assertEquals("Help the Honey Buzzards", quest.getName());
	}

}
