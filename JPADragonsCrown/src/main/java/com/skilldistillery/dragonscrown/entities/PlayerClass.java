package com.skilldistillery.dragonscrown.entities;

import java.util.List;
import java.util.Objects;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name = "player_class")
public class PlayerClass {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String name;
	private String description;
	@Column(name = "animation_url")
	private String animationUrl;
	@Column(name = "artwork_url")
	private String artworkUrl;
	@Column(name = "title_url")
	private String titleUrl;
	@Column(name = "portrait_url")
	private String portraitUrl;
	@Column(name = "background_url")
	private String backgroundUrl;
	@Column(name = "icon_url")
	private String iconUrl;
	@Column(name = "streamable_url")
	private String streamableUrl;
	@Column(name = "hq_artwork_url")
	private String hqArtworkUrl;
	@Column(name = "sprite_start_url")
	private String spriteStartUrl;
	@Column(name = "sprite_end_url")
	private String spriteEndUrl;
	@Column(name = "select_img_url")
	private String selectImgUrl;
	@Column(name = "card_url")
	private String cardUrl;
	
	@OneToMany(mappedBy = "playerClass")
	private List<ClassStats> classStats;
	@OneToMany(mappedBy = "playerClass")
	private List<Recommendation> recommendations;
    
    @OneToOne(mappedBy = "playerClass", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
	private StatScaling statScaling;
    
    @OneToMany(mappedBy = "playerClass")
    private List<PlayerClassHasSkill> skills;
    
    @OneToMany(mappedBy = "playerClass")
    private List<PlayerClassHasQuest> quests;
	
	public PlayerClass() {
		super();
		// TODO Auto-generated constructor stub
	}

	public PlayerClass(int id, String name, String description, String animationUrl, String artworkUrl, String titleUrl,
			String portraitUrl, String backgroundUrl, String iconUrl, String streamableUrl, String hqArtworkUrl,
			String spriteStartUrl, String spriteEndUrl, String selectImgUrl, String cardUrl,
			List<ClassStats> classStats, List<Recommendation> recommendations, StatScaling statScaling,
			List<PlayerClassHasSkill> skills, List<PlayerClassHasQuest> quests) {
		super();
		this.id = id;
		this.name = name;
		this.description = description;
		this.animationUrl = animationUrl;
		this.artworkUrl = artworkUrl;
		this.titleUrl = titleUrl;
		this.portraitUrl = portraitUrl;
		this.backgroundUrl = backgroundUrl;
		this.iconUrl = iconUrl;
		this.streamableUrl = streamableUrl;
		this.hqArtworkUrl = hqArtworkUrl;
		this.spriteStartUrl = spriteStartUrl;
		this.spriteEndUrl = spriteEndUrl;
		this.selectImgUrl = selectImgUrl;
		this.cardUrl = cardUrl;
		this.classStats = classStats;
		this.recommendations = recommendations;
		this.statScaling = statScaling;
		this.skills = skills;
		this.quests = quests;
	}

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getAnimationUrl() {
		return animationUrl;
	}
	public void setAnimationUrl(String animationUrl) {
		this.animationUrl = animationUrl;
	}
	public String getArtworkUrl() {
		return artworkUrl;
	}
	public void setArtworkUrl(String artworkUrl) {
		this.artworkUrl = artworkUrl;
	}
	
	public String getTitleUrl() {
		return titleUrl;
	}

	public void setTitleUrl(String titleUrl) {
		this.titleUrl = titleUrl;
	}

	public String getPortraitUrl() {
		return portraitUrl;
	}

	public void setPortraitUrl(String portraitUrl) {
		this.portraitUrl = portraitUrl;
	}

	public String getBackgroundUrl() {
		return backgroundUrl;
	}

	public void setBackgroundUrl(String backgroundUrl) {
		this.backgroundUrl = backgroundUrl;
	}

	public String getIconUrl() {
		return iconUrl;
	}

	public void setIconUrl(String iconUrl) {
		this.iconUrl = iconUrl;
	}

	public String getStreamableUrl() {
		return streamableUrl;
	}

	public void setStreamableUrl(String streamableUrl) {
		this.streamableUrl = streamableUrl;
	}

	public String getSpriteStartUrl() {
		return spriteStartUrl;
	}

	public void setSpriteStartUrl(String spriteStartUrl) {
		this.spriteStartUrl = spriteStartUrl;
	}

	public String getSpriteEndUrl() {
		return spriteEndUrl;
	}

	public void setSpriteEndUrl(String spriteEndUrl) {
		this.spriteEndUrl = spriteEndUrl;
	}

	public String getSelectImgUrl() {
		return selectImgUrl;
	}

	public void setSelectImgUrl(String selectImgUrl) {
		this.selectImgUrl = selectImgUrl;
	}

	public List<ClassStats> getClassStats() {
		return classStats;
	}

	public void setClassStats(List<ClassStats> classStats) {
		this.classStats = classStats;
	}

	public List<Recommendation> getRecommendations() {
		return recommendations;
	}

	public void setRecommendations(List<Recommendation> recommendations) {
		this.recommendations = recommendations;
	}

	public String getHqArtworkUrl() {
		return hqArtworkUrl;
	}

	public void setHqArtworkUrl(String hqArtworkUrl) {
		this.hqArtworkUrl = hqArtworkUrl;
	}

	public StatScaling getStatScaling() {
		return statScaling;
	}

	public void setStatScaling(StatScaling statScaling) {
		this.statScaling = statScaling;
	}
	
	public List<PlayerClassHasSkill> getSkills() {
		return skills;
	}

	public void setSkills(List<PlayerClassHasSkill> skills) {
		this.skills = skills;
	}

	public List<PlayerClassHasQuest> getQuests() {
		return quests;
	}

	public void setQuests(List<PlayerClassHasQuest> quests) {
		this.quests = quests;
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
		PlayerClass other = (PlayerClass) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "PlayerClass [id=" + id + ", name=" + name + ", description=" + description + ", animationUrl="
				+ animationUrl + ", artworkUrl=" + artworkUrl + ", titleUrl=" + titleUrl + ", portraitUrl="
				+ portraitUrl + ", backgroundUrl=" + backgroundUrl + ", iconUrl=" + iconUrl + ", streamableUrl="
				+ streamableUrl + ", hqArtworkUrl=" + hqArtworkUrl + ", spriteStartUrl=" + spriteStartUrl
				+ ", spriteEndUrl=" + spriteEndUrl + ", selectImgUrl=" + selectImgUrl + ", cardUrl=" + cardUrl
				+ ", classStats=" + classStats + ", recommendations=" + recommendations + ", statScaling=" + statScaling
				+ ", skills=" + skills + ", quests=" + quests + "]";
	}

}
