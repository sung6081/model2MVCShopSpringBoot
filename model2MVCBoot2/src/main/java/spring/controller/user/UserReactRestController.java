package spring.controller.user;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import spring.common.CommonProperties;
import spring.common.Page;
import spring.common.Search;
import spring.domain.User;
import spring.user.UserService;


//==> 회원관리 RestController
@CrossOrigin(origins = "*")
@RestController
@RequestMapping("/react/user/*")
public class UserReactRestController {
	
	///Field
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	//setter Method 구현 않음
	
	@Autowired
	private CommonProperties common;
		
	public UserReactRestController(){
		System.out.println("Default UserReactRestController call...");
	}

	@RequestMapping( value="login", method=RequestMethod.POST )
	public User login(	@RequestBody User user,
			HttpSession session ) throws Exception{

			System.out.println("/react/user/login : POST");
			//Business Logic
			System.out.println("::"+user);
			User dbUser=userService.getUser(user.getUserId());

			if( user.getPassword().equals(dbUser.getPassword())){
				session.setAttribute("user", dbUser);
				
				return dbUser;
			}

			return null;
	}
	
	@RequestMapping(value="logout", method=RequestMethod.GET)
	public void logout(HttpSession session) {
		
		System.out.println("logoutAction start");
		
		session.removeAttribute("user");
		
		System.out.println("logoutAction end");
		
	}//end of logoutAction
	
	@GetMapping(value="getUser/{userId}")
	public User getUser(@PathVariable String userId) throws Exception {
		
		System.out.println("getUser start");
		
		User user = userService.getUser(userId);
		
		System.out.println("getUser end");
		
		return user;
		
	}
	
	@PostMapping(value="getUserList")
	public Map getUserList(@RequestBody Search search) throws Exception {
		
		System.out.println("getUserList start");
		
		search.setPageSize(common.getPageSize());
		
		Map<String, Object> map = userService.getUserList(search);
		
		Page resultPage	= new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), common.getPageUnit(), common.getPageSize());
		
		map.put("resultPage", resultPage);
		
		System.out.println("getUserList end");
		
		return map;
		
	}
	
	@PostMapping(value="updateUser")
	public void updateUser(@RequestBody User user) throws Exception {
		
		System.out.println("updateUser start");
		
		System.out.println("updateUser end");
		
		userService.updateUser(user);
		
	}
	
	@PostMapping(value="addUser")
	public void addUser(@RequestBody User user) throws Exception {
		
		System.out.println("updateUser start");
		
		System.out.println("updateUser end");
		
		userService.addUser(user);
		
	}
	
	@GetMapping(value="checkDuplication/{userId}")
	public Boolean checkDuplication(@PathVariable String userId) throws Exception {
		
		System.out.println("updateUser start");
		
		Boolean result = new Boolean(true);
		
		result = userService.checkDuplication(userId);
		
		System.out.println("updateUser end");
		
		return result;
		
	}
	
}
















