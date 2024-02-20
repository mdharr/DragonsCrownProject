package com.skilldistillery.dragonscrown.entities;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.Table;

@Embeddable
@Table(name = "player_class_has_skill")
public class PlayerClassHasSkillId implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@Column(name = "player_class_id")
	private int PlayerClassId;
	
	@Column(name = "skill_id")
	private int skillId;

	public PlayerClassHasSkillId() {
		super();
		// TODO Auto-generated constructor stub
	}

	public PlayerClassHasSkillId(int playerClassId, int skillId) {
		super();
		PlayerClassId = playerClassId;
		this.skillId = skillId;
	}

	public int getPlayerClassId() {
		return PlayerClassId;
	}

	public void setPlayerClassId(int playerClassId) {
		PlayerClassId = playerClassId;
	}

	public int getSkillId() {
		return skillId;
	}

	public void setSkillId(int skillId) {
		this.skillId = skillId;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public int hashCode() {
		return Objects.hash(PlayerClassId, skillId);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		PlayerClassHasSkillId other = (PlayerClassHasSkillId) obj;
		return PlayerClassId == other.PlayerClassId && skillId == other.skillId;
	}

	@Override
	public String toString() {
		return "PlayerClassHasSkillId [PlayerClassId=" + PlayerClassId + ", skillId=" + skillId + "]";
	}
	
}
