package kr.ac.hongik.vin.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;

// 이 클래스는 웹 어플리케이션의 기본 설정을 java로 설정하는 클래스입니다.
@Configuration
@ComponentScan(basePackages = { "kr.ac.hongik.vin.wine.dao","kr.ac.hongik.vin.wine.service","kr.ac.hongik.vin.user.dao","kr.ac.hongik.vin.user.service" })
@Import({DBConfig.class})	// DB에 관한 설정을 읽어옵니다.
public class ApplicationConfig {

}
