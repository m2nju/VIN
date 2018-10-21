package kr.ac.hongik.vin.wine.dto;

public class WineSearchList {
	private String wine21Code;
	private String koreanName;
	private String englishName;
	private String winary;
	private String country;
	private String region;
	private String grapeVariety;
	private String vintage;
	private int capacity;
	private String type;
	
	public String getWine21Code() {
		return wine21Code;
	}
	public void setWine21Code(String wine21Code) {
		this.wine21Code = wine21Code;
	}
	public String getKoreanName() {
		return koreanName;
	}
	public void setKoreanName(String koreanName) {
		this.koreanName = koreanName;
	}
	public String getEnglishName() {
		return englishName;
	}
	public void setEnglishName(String englishName) {
		this.englishName = englishName;
	}
	public String getWinary() {
		return winary;
	}
	public void setWinary(String winary) {
		this.winary = winary;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getRegion() {
		return region;
	}
	public void setRegion(String region) {
		this.region = region;
	}
	public String getGrapeVariety() {
		return grapeVariety;
	}
	public void setGrapeVariety(String grapeVariety) {
		this.grapeVariety = grapeVariety;
	}
	public String getVintage() {
		return vintage;
	}
	public void setVintage(String vintage) {
		this.vintage = vintage;
	}
	public int getCapacity() {
		return capacity;
	}
	public void setCapacity(int capacity) {
		this.capacity = capacity;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	@Override
	public String toString() {
		return "WineSearchList [wine21Code=" + wine21Code + ", koreanName=" + koreanName + ", englishName="
				+ englishName + ", winary=" + winary + ", country=" + country + ", region=" + region + ", grapeVariety="
				+ grapeVariety + ", vintage=" + vintage + ", capacity=" + capacity + ", type=" + type + "]";
	}
	
	
}
