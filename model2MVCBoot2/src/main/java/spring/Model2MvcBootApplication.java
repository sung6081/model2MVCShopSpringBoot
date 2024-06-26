package spring;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.context.annotation.PropertySource;
import org.springframework.web.bind.annotation.CrossOrigin;

import lombok.extern.log4j.Log4j;

@EnableAspectJAutoProxy
@SpringBootApplication
@PropertySource(value="classpath:config/common.properties")
public class Model2MvcBootApplication {

	public static void main(String[] args) {
		SpringApplication.run(Model2MvcBootApplication.class, args);
	}

}