package kr.ac.hongik.vin.user.dao;

public class UserDaoSqls {
	public static final String SELECT_ALL = "SELECT * FROM user ORDER BY user_id";
	public static final String SELECT_USER_BY_ID = "SELECT * FROM user WHERE user_id = :user_id";
	public static final String DELETE_BY_ID = "DELETE FROM user WHERE user_id = :user_id";
	public static final String SELECT_COUNT = "SELECT count(*) FROM user";
	public static final String SELECT_ID_BY_EMAIL = "SELECT user_id FROM user WHERE user_email = :user_email";
}
