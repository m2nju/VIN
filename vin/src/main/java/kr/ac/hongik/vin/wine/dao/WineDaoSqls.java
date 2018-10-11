package kr.ac.hongik.vin.wine.dao;

public class WineDaoSqls {
	public static final String SELECT_ALL = "SELECT * FROM wine ORDER BY wine21_code";
	public static final String SELECT_WINE_BY_WINE21CODE = "SELECT * FROM wine WHERE wine21_code = :wine21Code";
	public static final String SELECT_WINE_CODE_AND_NAMES = "SELECT wine21_code, korean_name, english_name FROM wine ORDER BY wine21_code";
}
