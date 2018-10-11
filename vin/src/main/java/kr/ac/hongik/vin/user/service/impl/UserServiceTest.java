package kr.ac.hongik.vin.user.service.impl;

import org.springframework.context.ApplicationContext;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import kr.ac.hongik.vin.config.ApplicationConfig;
import kr.ac.hongik.vin.user.dto.User;
import kr.ac.hongik.vin.user.service.UserService;
public class UserServiceTest {
	public static void main(String[] args) {
		ApplicationContext ac = new AnnotationConfigApplicationContext(ApplicationConfig.class); 
		UserService userService = ac.getBean(UserService.class);
		
		User user = new User();
		user.setUserEmail("2mingju@naver.comcomcom");
		user.setUserName("이민주22");
		user.setUserAge(2);
		user.setUserBirth("06.02");
		user.setUserIsMan(true);
		user.setUserGrade(2);
		User result = userService.registUser(user);
		System.out.println(result);
		
		((ConfigurableApplicationContext)ac).close();
	}
}
