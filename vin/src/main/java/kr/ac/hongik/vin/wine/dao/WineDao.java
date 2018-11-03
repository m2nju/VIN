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

import kr.ac.hongik.vin.wine.dto.Wine;
import kr.ac.hongik.vin.wine.dto.WineCodeAndNames;
import kr.ac.hongik.vin.wine.dto.WineSearchList;

@Repository
public class WineDao {
	
	private NamedParameterJdbcTemplate jdbc;
	private SimpleJdbcInsert insertAction;
	private RowMapper<Wine> rowMapper = BeanPropertyRowMapper.newInstance(Wine.class);
	private RowMapper<WineCodeAndNames> rowMapper_WineCodeAndNames = BeanPropertyRowMapper.newInstance(WineCodeAndNames.class);
	private RowMapper<WineSearchList> rowMapper_WineSearchList = BeanPropertyRowMapper.newInstance(WineSearchList.class);
	
	public WineDao(DataSource dataSource) {
		this.jdbc = new NamedParameterJdbcTemplate(dataSource);
		this.insertAction = new SimpleJdbcInsert(dataSource).withTableName("notify").usingGeneratedKeyColumns("id");
	}
	
	
	public List<Wine> selectAll(){
		Map<String, Integer> params = new HashMap<>();
		return jdbc.query(SELECT_ALL, params, rowMapper);
	}
	
	public Wine selectWine(int wine21Code) {
		Wine wine = jdbc.queryForObject(SELECT_WINE_BY_WINE21CODE, Collections.singletonMap("wine21Code", wine21Code), rowMapper);
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
	
	public List<WineSearchList> selectWinesSearchListByConditions(Integer start, Integer limit,
			List<String> types,
			List<String> countries,
			List<Integer> alcohol,
			List<Integer> sweetness,
			List<Integer> acidity,
			List<Integer> body,
			List<Integer> tanin,
			List<Integer> price)
	{
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.append(SELECT_CONDITION);	// 기본 조건
		
		if(types.size() != 0) {	// type에 관한 쿼리 추가
			stringBuilder.append(SPACE);
			stringBuilder.append(WHERE);
			stringBuilder.append(SPACE);
			stringBuilder.append("type IN (");
			for (int i = 0; i < types.size(); i++) {
				stringBuilder.append("'");
				if(types.get(i).equals("red")) {
					System.out.println("레드입니다.");
					stringBuilder.append("레드");
				}else if(types.get(i).equals("white")) {
					System.out.println("화이트입니다.");
					stringBuilder.append("화이트");
				}else if(types.get(i).equals("sparkling")) {
					System.out.println("스파클링입니다.");
					stringBuilder.append("스파클링");
				}else if(types.get(i).equals("rose")) {
					System.out.println("로제입니다.");
					stringBuilder.append("로제");
				}else if(types.get(i).equals("etc")) {
					System.out.println("기타입니다.");
					stringBuilder.append("기타");
				}
				stringBuilder.append("'");
				stringBuilder.append(",");
			}
			stringBuilder.setLength(stringBuilder.length() - 1);
			stringBuilder.append(")");
		}	// 여기까지 type에 관한 쿼리 추가.
		
		
		stringBuilder.append(SPACE);
		stringBuilder.append(ORDER_BY_COUNT);
		String queryStatement = stringBuilder.toString();
		Map<String, Integer> params = new HashMap<>();
		params.put("start", start);
		params.put("limit", limit);
		System.out.println(queryStatement);
		return jdbc.query(queryStatement, params, rowMapper_WineSearchList);
	}
}
