package kr.ac.hongik.vin.user.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.ac.hongik.vin.user.dao.UserDao;
import kr.ac.hongik.vin.user.dto.User;
import kr.ac.hongik.vin.user.service.UserService;

@Service
public class UserServiceImpl implements UserService{
	@Autowired
	UserDao userDao;
	
	@Override
	@Transactional
	public List<User> getUsers() {
		List<User> list = userDao.selectAll();
		return list;
	}
	
	@Override
	@Transactional(readOnly=false)
	public int deleteUser(Long userId) {
		int deleteCount = userDao.deleteById(userId);
		return deleteCount;
	}
	
	@Override
	@Transactional(readOnly=false)
	public User getUser(Long userId) {
		//System.out.println("UserService의 getUser() 호출");
		User user = userDao.selectUserById(userId);
		return user;
	}
	
	@Override
	@Transactional(readOnly=false)
	public User registUser(User user) {
		long userId = userDao.insert(user);
		user.setUserId((int)userId);
		
		return user;
	}

	@Override
	public int getCount() {
		return userDao.selectCount();
	}
	
	@Override
	@Transactional(readOnly=false)
	public int isUser(User user) {	// isUser는 해당 유저의 userId를 반환하는 메소드이며, 회원이 아닐 시에 
		int userId = 0;
		try {
		userId = userDao.selectIdByEmail(user.getUserEmail());
		//System.out.println("유저 아이디는 "+userId);
		}catch(Exception e) {
			System.out.println(e);
		}
		return userId;
	}
}
