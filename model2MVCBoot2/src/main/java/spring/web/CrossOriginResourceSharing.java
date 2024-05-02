package spring.web;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class CrossOriginResourceSharing implements WebMvcConfigurer {

	@Override
	public void addCorsMappings(CorsRegistry registry) {
		// TODO Auto-generated method stub
		
		System.out.println("crossOrigin");
		
		registry.addMapping("/*")
			.allowedOrigins("*")
			.allowedMethods("GET", "POST")
			.allowCredentials(true);
	}

}
