package spring.controller.home;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class Home {
	
	public Home() {
		System.out.println("Home Controller Default Constructor call...");
	}
	
	@GetMapping("/")
	public String getHome() {
		
		System.out.println("Home");
		
		return "index.jsp";
		
	}
	
}
