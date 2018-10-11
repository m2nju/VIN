package kr.ac.hongik.vin.user.dto;

public class User {
	private int userId;
	private String userEmail;
	private String userName;
	private int userAge;
	private String userBirth;
	private Boolean userIsMan;
	private int userGrade;
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public int getUserAge() {
		return userAge;
	}
	public void setUserAge(int userAge) {
		this.userAge = userAge;
	}
	public String getUserBirth() {
		return userBirth;
	}
	public void setUserBirth(String userBirth) {
		this.userBirth = userBirth;
	}
	public Boolean getUserIsMan() {
		return userIsMan;
	}
	public void setUserIsMan(Boolean userIsMan) {
		this.userIsMan = userIsMan;
	}
	public int getUserGrade() {
		return userGrade;
	}
	public void setUserGrade(int userGrade) {
		this.userGrade = userGrade;
	}
	@Override
	public String toString() {
		return "User [userId=" + userId + ", userEmail=" + userEmail + ", userName=" + userName + ", userAge=" + userAge
				+ ", userBirth=" + userBirth + ", userIsMan=" + userIsMan + ", userGrade=" + userGrade + "]";
	}
	
	
}
