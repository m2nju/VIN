package kr.ac.hongik.vin.wine.dto;

public class RecommendedWine {
	private String wine21Code;
	private String koreanName;
	private int price;
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
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	@Override
	public String toString() {
		return "RecommendedWine [wine21Code=" + wine21Code + ", koreanName=" + koreanName + ", price=" + price + "]";
	}
}
