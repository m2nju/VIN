package kr.ac.hongik.vin.wine.dto;

public class Wine {
	private String wine21Code;
	private String koreanName;
	private String englishName;
	private String winary;
	private String country;
	private String region;
	private String grapeVariety;
	private String grade;
	private int alcohol;
	private String drinkingTemperature;
	private int sweetness;
	private int acidity;
	private int body;
	private int tanin;
	private String pairing;
	private String otherInformation;
	private String vintage;
	private int capacity;
	private String importer;
	private String type;
	private String makerNote;
	
	
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
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public int getAlcohol() {
		return alcohol;
	}
	public void setAlcohol(int alcohol) {
		this.alcohol = alcohol;
	}
	public String getDrinkingTemperature() {
		return drinkingTemperature;
	}
	public void setDrinkingTemperature(String drinkingTemperature) {
		this.drinkingTemperature = drinkingTemperature;
	}
	public int getSweetness() {
		return sweetness;
	}
	public void setSweetness(int sweetness) {
		this.sweetness = sweetness;
	}
	public int getAcidity() {
		return acidity;
	}
	public void setAcidity(int acidity) {
		this.acidity = acidity;
	}
	public int getBody() {
		return body;
	}
	public void setBody(int body) {
		this.body = body;
	}
	public int getTanin() {
		return tanin;
	}
	public void setTanin(int tanin) {
		this.tanin = tanin;
	}
	public String getPairing() {
		return pairing;
	}
	public void setPairing(String pairing) {
		this.pairing = pairing;
	}
	public String getOtherInformation() {
		return otherInformation;
	}
	public void setOtherInformation(String otherInformation) {
		this.otherInformation = otherInformation;
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
	public String getImporter() {
		return importer;
	}
	public void setImporter(String importer) {
		this.importer = importer;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getMakerNote() {
		return makerNote;
	}
	public void setMakerNote(String makerNote) {
		this.makerNote = makerNote;
	}
	
	@Override
	public String toString() {
		return "Wine [wine21Code=" + wine21Code + ", koreanName=" + koreanName + ", englishName=" + englishName
				+ ", winary=" + winary + ", country=" + country + ", region=" + region + ", grapeVariety="
				+ grapeVariety + ", grade=" + grade + ", alcohol=" + alcohol + ", drinkingTemperature="
				+ drinkingTemperature + ", sweetness=" + sweetness + ", acidity=" + acidity + ", body=" + body
				+ ", tanin=" + tanin + ", pairing=" + pairing + ", otherInformation=" + otherInformation + ", vintage="
				+ vintage + ", capacity=" + capacity + ", importer=" + importer + ", type=" + type + ", makerNote="
				+ makerNote + "]";
	}
	
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Wine other = (Wine) obj;
		if (acidity != other.acidity)
			return false;
		if (alcohol != other.alcohol)
			return false;
		if (body != other.body)
			return false;
		if (capacity != other.capacity)
			return false;
		if (country == null) {
			if (other.country != null)
				return false;
		} else if (!country.equals(other.country))
			return false;
		if (drinkingTemperature == null) {
			if (other.drinkingTemperature != null)
				return false;
		} else if (!drinkingTemperature.equals(other.drinkingTemperature))
			return false;
		if (englishName == null) {
			if (other.englishName != null)
				return false;
		} else if (!englishName.equals(other.englishName))
			return false;
		if (grade == null) {
			if (other.grade != null)
				return false;
		} else if (!grade.equals(other.grade))
			return false;
		if (grapeVariety == null) {
			if (other.grapeVariety != null)
				return false;
		} else if (!grapeVariety.equals(other.grapeVariety))
			return false;
		if (importer == null) {
			if (other.importer != null)
				return false;
		} else if (!importer.equals(other.importer))
			return false;
		if (koreanName == null) {
			if (other.koreanName != null)
				return false;
		} else if (!koreanName.equals(other.koreanName))
			return false;
		if (makerNote == null) {
			if (other.makerNote != null)
				return false;
		} else if (!makerNote.equals(other.makerNote))
			return false;
		if (otherInformation == null) {
			if (other.otherInformation != null)
				return false;
		} else if (!otherInformation.equals(other.otherInformation))
			return false;
		if (pairing == null) {
			if (other.pairing != null)
				return false;
		} else if (!pairing.equals(other.pairing))
			return false;
		if (region == null) {
			if (other.region != null)
				return false;
		} else if (!region.equals(other.region))
			return false;
		if (sweetness != other.sweetness)
			return false;
		if (tanin != other.tanin)
			return false;
		if (type == null) {
			if (other.type != null)
				return false;
		} else if (!type.equals(other.type))
			return false;
		if (vintage == null) {
			if (other.vintage != null)
				return false;
		} else if (!vintage.equals(other.vintage))
			return false;
		if (winary == null) {
			if (other.winary != null)
				return false;
		} else if (!winary.equals(other.winary))
			return false;
		if (wine21Code == null) {
			if (other.wine21Code != null)
				return false;
		} else if (!wine21Code.equals(other.wine21Code))
			return false;
		return true;
	}


	
}
