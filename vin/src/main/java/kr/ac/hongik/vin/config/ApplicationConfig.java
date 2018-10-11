package kr.ac.hongik.vin.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;

@Configuration
@ComponentScan(basePackages = { "kr.ac.hongik.vin.wine.dao","kr.ac.hongik.vin.wine.service","kr.ac.hongik.vin.user.dao","kr.ac.hongik.vin.user.service" })
@Import({DBConfig.class})
public class ApplicationConfig {

}
