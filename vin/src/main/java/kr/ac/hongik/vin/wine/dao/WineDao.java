package kr.ac.hongik.vin.wine.dao;

import static kr.ac.hongik.vin.wine.dao.WineDaoSqls.*;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.simple.SimpleJdbcInsert;
import org.springframework.stereotype.Repository;

import kr.ac.hongik.vin.wine.dto.RecommendedWine;
import kr.ac.hongik.vin.wine.dto.Wine;
import kr.ac.hongik.vin.wine.dto.WineCodeAndNames;
import kr.ac.hongik.vin.wine.dto.WineSearchList;

@Repository
public class WineDao {

	private NamedParameterJdbcTemplate jdbc;
	private SimpleJdbcInsert insertAction;
	private RowMapper<Wine> rowMapper = BeanPropertyRowMapper.newInstance(Wine.class);
	private RowMapper<WineCodeAndNames> rowMapper_WineCodeAndNames = BeanPropertyRowMapper
			.newInstance(WineCodeAndNames.class);
	private RowMapper<WineSearchList> rowMapper_WineSearchList = BeanPropertyRowMapper
			.newInstance(WineSearchList.class);
	private RowMapper<RecommendedWine> rowMapper_RecommendedWine = BeanPropertyRowMapper
			.newInstance(RecommendedWine.class);

	
	public WineDao(DataSource dataSource) {
		this.jdbc = new NamedParameterJdbcTemplate(dataSource);
		this.insertAction = new SimpleJdbcInsert(dataSource).withTableName("notify").usingGeneratedKeyColumns("id");
	}

	public List<Wine> selectAll() {
		Map<String, Integer> params = new HashMap<>();
		return jdbc.query(SELECT_ALL, params, rowMapper);
	}

	public Wine selectWine(int wine21Code) {
		Wine wine = jdbc.queryForObject(SELECT_WINE_BY_WINE21CODE, Collections.singletonMap("wine21Code", wine21Code),
				rowMapper);
		return wine;
	}

	public List<WineCodeAndNames> selectWineCodeAndNames() {
		Map<String, Integer> params = new HashMap<>();
		return jdbc.query(SELECT_WINE_CODE_AND_NAMES, params, rowMapper_WineCodeAndNames);
	}

	public List<WineSearchList> selectWinesSearchList(Integer start, Integer limit) {
		Map<String, Integer> params = new HashMap<>();
		params.put("start", start);
		params.put("limit", limit);
		return jdbc.query(SELECT_PAGING, params, rowMapper_WineSearchList);
	}

	public int selectCount() {
		return jdbc.queryForObject(SELECT_COUNT, Collections.emptyMap(), Integer.class);
	}

	public List<WineSearchList> selectWinesSearchListByConditions(Integer start, Integer limit, String keyword, List<String> types,
			List<String> countries, List<Integer> alcohol, List<Integer> sweetness, List<Integer> acidity,
			List<Integer> body, List<Integer> tanin, List<Integer> price) {
		boolean isAdded = false; // 쿼리 조건이 추가되었는지 체크하는 불리언형 변수
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.append(SELECT_CONDITION); // 기본 조건

		if (!keyword.equals("") || !types.isEmpty() || !countries.isEmpty() || !alcohol.isEmpty() || !sweetness.isEmpty() || !acidity.isEmpty()
				|| !body.isEmpty() || !tanin.isEmpty() || !price.isEmpty()) {
			stringBuilder.append(SPACE);
			stringBuilder.append(WHERE);
			stringBuilder.append(SPACE);
		}
		
		try { // keyword에 관한 쿼리 추가
			if (!keyword.equals("")) {
				isAdded = true;
				stringBuilder.append(" korean_name LIKE '%");
				stringBuilder.append(keyword);
				stringBuilder.append("%' OR english_name LIKE '%");
				stringBuilder.append(keyword);
				stringBuilder.append("%' OR winary LIKE '%");
				stringBuilder.append(keyword);
				stringBuilder.append("%' OR region LIKE '%");
				stringBuilder.append(keyword);
				stringBuilder.append("%' OR grape_variety LIKE '%");
				stringBuilder.append(keyword);
				stringBuilder.append("%' OR pairing LIKE '%");
				stringBuilder.append(keyword);
				stringBuilder.append("%' OR other_information LIKE '%");
				stringBuilder.append(keyword);
				stringBuilder.append("%' OR maker_note LIKE '%");
				stringBuilder.append(keyword);
				stringBuilder.append("%'");
				
				stringBuilder.append(SPACE);
			} // 여기까지 type에 관한 쿼리 추가.
		} catch (Exception e) {
			System.out.println(e);
		}

		
		try { // type에 관한 쿼리 추가
			if (!types.isEmpty()) {
				if (isAdded) {
					stringBuilder.append(AND);
					stringBuilder.append(SPACE);
				}
				isAdded = true;
				stringBuilder.append("type IN (");
				for (int i = 0; i < types.size(); i++) {
					stringBuilder.append("'");
					if (types.get(i).equals("red")) {
						System.out.println("레드입니다.");
						stringBuilder.append("레드");
					} else if (types.get(i).equals("white")) {
						System.out.println("화이트입니다.");
						stringBuilder.append("화이트");
					} else if (types.get(i).equals("sparkling")) {
						System.out.println("스파클링입니다.");
						stringBuilder.append("스파클링");
					} else if (types.get(i).equals("rose")) {
						System.out.println("로제입니다.");
						stringBuilder.append("로제");
					} else if (types.get(i).equals("etc")) {
						System.out.println("기타입니다.");

						stringBuilder.append("고도주','주정강화','기타");
					}
					stringBuilder.append("'");
					stringBuilder.append(",");
				}
				stringBuilder.setLength(stringBuilder.length() - 1);
				stringBuilder.append(")");
				stringBuilder.append(SPACE);
			} // 여기까지 type에 관한 쿼리 추가.
		} catch (Exception e) {
			System.out.println(e);
		}

		try { // countries에 관한 쿼리 추가
			if (!countries.isEmpty()) {
				if (isAdded) {
					stringBuilder.append(AND);
					stringBuilder.append(SPACE);
				}
				isAdded = true;
				stringBuilder.append("country IN (");
				for (int i = 0; i < countries.size(); i++) {
					stringBuilder.append("'");
					if (countries.get(i).equals("ZA")) {
						System.out.println("남아프리카 공화국입니다.");
						stringBuilder.append("남아프리카(South Africa)");
					} else if (countries.get(i).equals("NZ")) {
						System.out.println("뉴질랜드입니다.");
						stringBuilder.append("뉴질랜드(New Zealand)");
					} else if (countries.get(i).equals("DE")) {
						System.out.println("독일입니다.");
						stringBuilder.append("독일(Germany)");
					} else if (countries.get(i).equals("US")) {
						System.out.println("미국입니다.");
						stringBuilder.append("미국(U.S.A)");
					} else if (countries.get(i).equals("ES")) {
						System.out.println("스페인입니다.");
						stringBuilder.append("스페인(Spain)");
					} else if (countries.get(i).equals("AR")) {
						System.out.println("아르헨티나입니다.");
						stringBuilder.append("아르헨티나(Argentina)");
					} else if (countries.get(i).equals("AT")) {
						System.out.println("오스트리아입니다.");
						stringBuilder.append("오스트리아(Austria)");
					} else if (countries.get(i).equals("IT")) {
						System.out.println("이탈리아입니다.");
						stringBuilder.append("이탈리아(Italia)");
					} else if (countries.get(i).equals("JP")) {
						System.out.println("일본입니다.");
						stringBuilder.append("일본(Japan)");
					} else if (countries.get(i).equals("CL")) {
						System.out.println("칠레입니다.");
						stringBuilder.append("칠레(Chile)");
					} else if (countries.get(i).equals("CA")) {
						System.out.println("캐나다입니다.");
						stringBuilder.append("캐나다(Canada)");
					} else if (countries.get(i).equals("PT")) {
						System.out.println("포르투갈입니다.");
						stringBuilder.append("포르투갈(Portugal)");
					} else if (countries.get(i).equals("FR")) {
						System.out.println("프랑스입니다.");
						stringBuilder.append("프랑스(France)");
					} else if (countries.get(i).equals("HU")) {
						System.out.println("헝가리입니다.");
						stringBuilder.append("헝가리(Hungary)");
					} else if (countries.get(i).equals("AU")) {
						System.out.println("호주입니다.");
						stringBuilder.append("호주(Australia)");
					}
					stringBuilder.append("'");
					stringBuilder.append(",");
				}
				stringBuilder.setLength(stringBuilder.length() - 1);
				stringBuilder.append(")");
				stringBuilder.append(SPACE);
			} // 여기까지 countries에 관한 쿼리 추가.
		} catch (Exception e) {
			System.out.println(e);
		}

		try { // alcohol에 관한 쿼리 추가
			if (!alcohol.isEmpty()) {
				if (isAdded) {
					stringBuilder.append(AND);
					stringBuilder.append(SPACE);
				}
				isAdded = true;
				stringBuilder.append("alcohol >= ");
				stringBuilder.append(alcohol.get(0));
				stringBuilder.append(SPACE);
				stringBuilder.append(AND);
				stringBuilder.append(SPACE);
				stringBuilder.append("alcohol <= ");
				stringBuilder.append(alcohol.get(1));
				stringBuilder.append(SPACE);
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		try { // sweetness에 관한 쿼리 추가
			if (!sweetness.isEmpty()) {
				if (isAdded) {
					stringBuilder.append(AND);
					stringBuilder.append(SPACE);
				}
				isAdded = true;
				stringBuilder.append("sweetness >= ");
				stringBuilder.append(sweetness.get(0));
				stringBuilder.append(SPACE);
				stringBuilder.append(AND);
				stringBuilder.append(SPACE);
				stringBuilder.append("sweetness <= ");
				stringBuilder.append(sweetness.get(1));
				stringBuilder.append(SPACE);
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		try { // acidity에 관한 쿼리 추가
			if (!acidity.isEmpty()) {
				if (isAdded) {
					stringBuilder.append(AND);
					stringBuilder.append(SPACE);
				}
				isAdded = true;
				stringBuilder.append("acidity >= ");
				stringBuilder.append(acidity.get(0));
				stringBuilder.append(SPACE);
				stringBuilder.append(AND);
				stringBuilder.append(SPACE);
				stringBuilder.append("acidity <= ");
				stringBuilder.append(acidity.get(1));
				stringBuilder.append(SPACE);
			}
		} catch (Exception e) {
			System.out.println(e);
		}

		try { // body에 관한 쿼리 추가
			if (!body.isEmpty()) {
				if (isAdded) {
					stringBuilder.append(AND);
					stringBuilder.append(SPACE);
				}
				isAdded = true;
				stringBuilder.append("body >= ");
				stringBuilder.append(body.get(0));
				stringBuilder.append(SPACE);
				stringBuilder.append(AND);
				stringBuilder.append(SPACE);
				stringBuilder.append("body <= ");
				stringBuilder.append(body.get(1));
				stringBuilder.append(SPACE);
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		try { // tanin에 관한 쿼리 추가
			if (!tanin.isEmpty()) {
				if (isAdded) {
					stringBuilder.append(AND);
					stringBuilder.append(SPACE);
				}
				isAdded = true;
				stringBuilder.append("tanin >= ");
				stringBuilder.append(tanin.get(0));
				stringBuilder.append(SPACE);
				stringBuilder.append(AND);
				stringBuilder.append(SPACE);
				stringBuilder.append("tanin <= ");
				stringBuilder.append(tanin.get(1));
				stringBuilder.append(SPACE);
			}
		} catch (Exception e) {
			System.out.println(e);
		}

		try { // price에 관한 쿼리 추가
			if (!price.isEmpty()) {
				if (isAdded) {
					stringBuilder.append(AND);
					stringBuilder.append(SPACE);
				}
				isAdded = true;
				stringBuilder.append("price >= ");
				stringBuilder.append(price.get(0));
				stringBuilder.append(SPACE);
				stringBuilder.append(AND);
				stringBuilder.append(SPACE);
				stringBuilder.append("price <= ");
				stringBuilder.append(price.get(1));
				stringBuilder.append(SPACE);
			}
		} catch (Exception e) {
			System.out.println(e);
		}

		stringBuilder.append(SPACE);
		stringBuilder.append(ORDER_BY_COUNT);
		String queryStatement = stringBuilder.toString();
		Map<String, Integer> params = new HashMap<>();
		params.put("start", start);
		params.put("limit", limit);
		System.out.println(queryStatement);
		return jdbc.query(queryStatement, params, rowMapper_WineSearchList);
	}
	
	public List<RecommendedWine> selectRecommendedWinesList(Integer start, Integer limit) {
		Map<String, Integer> params = new HashMap<>();
		params.put("start", start);
		params.put("limit", limit);
		return jdbc.query(SELECT_RECOMMEND, params, rowMapper_RecommendedWine);
	}
}
