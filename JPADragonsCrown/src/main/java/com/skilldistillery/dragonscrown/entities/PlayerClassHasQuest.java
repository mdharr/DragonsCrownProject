package com.skilldistillery.dragonscrown.entities;

import java.util.Objects;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "player_class_has_quest")
public class PlayerClassHasQuest {

	@EmbeddedId
	private PlayerClassHasQuestId id;
	
	@JsonIgnore
    @ManyToOne
    @MapsId("playerClassId")
    @JoinColumn(name = "player_class_id")
    private PlayerClass playerClass;

    @ManyToOne
    @MapsId("questId")
    @JoinColumn(name = "quest_id")
    private Quest quest;

	public PlayerClassHasQuest() {
		super();
		// TODO Auto-generated constructor stub
	}

	public PlayerClassHasQuest(PlayerClassHasQuestId id, PlayerClass playerClass, Quest quest) {
		super();
		this.id = id;
		this.playerClass = playerClass;
		this.quest = quest;
	}

	public PlayerClassHasQuestId getId() {
		return id;
	}

	public void setId(PlayerClassHasQuestId id) {
		this.id = id;
	}

	public PlayerClass getPlayerClass() {
		return playerClass;
	}

	public void setPlayerClass(PlayerClass playerClass) {
		this.playerClass = playerClass;
	}

	public Quest getQuest() {
		return quest;
	}

	public void setQuest(Quest quest) {
		this.quest = quest;
	}

	@Override
	public int hashCode() {
		return Objects.hash(id);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		PlayerClassHasQuest other = (PlayerClassHasQuest) obj;
		return Objects.equals(id, other.id);
	}

	@Override
	public String toString() {
		return "PlayerClassHasQuest [id=" + id + ", playerClass=" + playerClass + ", quest=" + quest + "]";
	}
    
}
