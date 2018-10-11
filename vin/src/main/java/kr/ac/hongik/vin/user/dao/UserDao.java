package kr.ac.hongik.vin.user.dao;

import static kr.ac.hongik.vin.user.dao.UserDaoSqls.*;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcInsert;
import org.springframework.stereotype.Repository;

import kr.ac.hongik.vin.user.dto.User;

@Repository
public class UserDao {
	private NamedParameterJdbcTemplate jdbc;
	private SimpleJdbcInsert insertAction;
	private RowMapper<User> rowMapper = BeanPropertyRowMapper.newInstance(User.class);

	public UserDao(DataSource dataSource) {
		this.jdbc = new NamedParameterJdbcTemplate(dataSource);
		this.insertAction = new SimpleJdbcInsert(dataSource).withTableName("user").usingGeneratedKeyColumns("user_id");
	}

	public List<User> selectAll() {
		Map<String, Integer> params = new HashMap<>();
		return jdbc.query(SELECT_ALL, params, rowMapper);
	}
	
	public User selectUserById(Long userId) {
		//System.out.println("UserDao의 selectUserById() 호출");
		return jdbc.queryForObject(SELECT_USER_BY_ID, Collections.singletonMap("user_id", userId), rowMapper);
	}
	
	public Long insert(User user) {
		SqlParameterSource params = new BeanPropertySqlParameterSource(user);
		return insertAction.executeAndReturnKey(params).longValue();
	}

	public int deleteById(Long userId) {
		Map<String, ?> params = Collections.singletonMap("user_id", userId);
		return jdbc.update(DELETE_BY_ID, params);
	}

	public int selectCount() {
		return jdbc.queryForObject(SELECT_COUNT, Collections.emptyMap(), Integer.class);
	}
	
	public int selectIdByEmail(String userEmail) {
		Map<String, ?> params = Collections.singletonMap("user_email", userEmail);
		return jdbc.queryForObject(SELECT_ID_BY_EMAIL, params, Integer.class);
	}
}