package kr.ac.hongik.vin.wine.dto;

public class WineCodeAndNames {
	private String wine21Code;
	private String koreanName;
	private String englishName;
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
	@Override
	public String toString() {
		return "WineCodeAndNames [wine21Code=" + wine21Code + ", koreanName=" + koreanName + ", englishName="
				+ englishName + "]";
	}
}
