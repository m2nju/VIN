package kr.ac.hongik.vin.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.DefaultServletHandlerConfigurer;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.view.InternalResourceViewResolver;


@Configuration
@EnableWebMvc
@ComponentScan(basePackages= {"kr.ac.hongik.vin.controller"})
public class WebMvcContextConfiguration extends WebMvcConfigurerAdapter {
	@Override
	// Resource들을 handling하는 핸들러를 선언 및 세팅
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/css/**").addResourceLocations("/resources/static/static/css/").setCachePeriod(31556926);
        registry.addResourceHandler("/img/**").addResourceLocations("/resources/static/static/img/").setCachePeriod(31556926);
        registry.addResourceHandler("/js/**").addResourceLocations("/resources/static/static/js/").setCachePeriod(31556926);
        registry.addResourceHandler("/txt/**").addResourceLocations("/resources/static/static/txt/").setCachePeriod(31556926);
    }
	
    // default servlet handler를 사용하게 합니다.
    @Override	// 아무런 핸들러가 정해지지 않았을 때, 사용하는 default servlet handler의 설정
    public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
        configurer.enable();
    }
   
    @Override	// default Controller를 설정.
    public void addViewControllers(final ViewControllerRegistry registry) {
        registry.addViewController("/").setViewName("index");
    }
    
    @Bean	// 기본 경로는 src/main/webapp/WEB-INF/views 디렉토리이다.
    public InternalResourceViewResolver getInternalResourceViewResolver() {
        InternalResourceViewResolver resolver = new InternalResourceViewResolver();
        resolver.setPrefix("/resources/static/");
        resolver.setSuffix(".html");
        return resolver;
    } 
}
