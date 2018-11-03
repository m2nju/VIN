package kr.ac.hongik.vin.wine.dao;

public class WineDaoSqls {
	public static final String SELECT_ALL = "SELECT * FROM wine ORDER BY wine21_code";
	public static final String SELECT_WINE_BY_WINE21CODE = "SELECT * FROM wine WHERE wine21_code = :wine21Code";
	public static final String SELECT_WINE_CODE_AND_NAMES = "SELECT wine21_code, korean_name, english_name FROM wine ORDER BY wine21_code";
	public static final String SELECT_PAGING = "SELECT wine21_code, korean_name, english_name, country, region, winary, grape_variety, vintage, capacity, type, price FROM wine ORDER BY wine21_code DESC limit :start, :limit";
	public static final String SELECT_COUNT = "SELECT count(*) FROM wine";
	
	public static final String SELECT_CONDITION = "SELECT wine21_code, korean_name, english_name, country, region, winary, grape_variety, vintage, capacity, type, price FROM wine";	// 여기 뒤에 WHERE 와 함꼐 조건들을 붙여보자.
	public static final String AND = "AND";
	public static final String OR = "OR";
	public static final String TYPE_CONDITION = "type IN :type_list";
	public static final String COUNTRY_CONDITION = "country IN :country_list";
	public static final String TASTE_CONDITION = "taste IN :taste_list";
	public static final String PRICE_CONDITION = "price IN :price_list";
	public static final String ORDER_BY_COUNT = "ORDER BY wine21_code DESC limit :start, :limit";	// 코드 기준 내림차순, start부터 limit까지의 갯수를 꺼내와라.
}	
