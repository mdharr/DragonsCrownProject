package com.skilldistillery.dragonscrown.entities;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.Table;

@Embeddable
@Table(name = "player_class_has_quest")
public class PlayerClassHasQuestId implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@Column(name = "player_class_id")
	private int playerClassId;
	
	@Column(name = "quest_id")
	private int questId;

	public PlayerClassHasQuestId() {
		super();
		// TODO Auto-generated constructor stub
	}

	public PlayerClassHasQuestId(int playerClassId, int questId) {
		super();
		this.playerClassId = playerClassId;
		this.questId = questId;
	}

	public int getPlayerClassId() {
		return playerClassId;
	}

	public void setPlayerClassId(int playerClassId) {
		this.playerClassId = playerClassId;
	}

	public int getQuestId() {
		return questId;
	}

	public void setQuestId(int questId) {
		this.questId = questId;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public int hashCode() {
		return Objects.hash(playerClassId, questId);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		PlayerClassHasQuestId other = (PlayerClassHasQuestId) obj;
		return playerClassId == other.playerClassId && questId == other.questId;
	}

	@Override
	public String toString() {
		return "PlayerClassHasQuestId [playerClassId=" + playerClassId + ", questId=" + questId + "]";
	}
	
}
