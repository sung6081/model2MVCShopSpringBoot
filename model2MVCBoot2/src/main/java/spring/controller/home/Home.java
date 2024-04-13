package spring.controller.home;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class Home {
	
	public Home() {
		System.out.println("Home Controller Default Constructor call...");
	}
	
	@GetMapping("/")
	public String getHome() {
		
		//log.debug(log);
		System.out.println("Home");
		
		return "index.jsp";
		
	}
	
}
