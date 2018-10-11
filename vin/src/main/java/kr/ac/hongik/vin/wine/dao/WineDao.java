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

@Repository
public class WineDao {
	
	private NamedParameterJdbcTemplate jdbc;
	private SimpleJdbcInsert insertAction;
	private RowMapper<Wine> rowMapper = BeanPropertyRowMapper.newInstance(Wine.class);
	private RowMapper<WineCodeAndNames> rowMapper_WinecodeAndNames = BeanPropertyRowMapper.newInstance(WineCodeAndNames.class);

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
		return jdbc.query(SELECT_WINE_CODE_AND_NAMES, params, rowMapper_WinecodeAndNames);
	}
}
