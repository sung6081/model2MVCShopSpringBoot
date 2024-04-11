package spring.controller.user;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import spring.common.CommonProperties;
import spring.common.Page;
import spring.common.Search;
import spring.domain.User;
import spring.user.UserService;
import spring.user.impl.UserServiceImpl;

@Controller
@RequestMapping("/user/*")
public class UserController {

	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	@Autowired
	private CommonProperties common;
	
	public UserController() {
		System.out.println("Default UserController call...");
	}
	
	@RequestMapping(value="addUser")
	public ModelAndView addUser(@ModelAttribute User user) throws Exception {
		
		System.out.println("addUserAction start");
		
		userService.addUser(user);
		
		ModelAndView modelAndView = new ModelAndView();
		//modelAndView.addObject("", user);
		modelAndView.setViewName("redirect:/user/loginView.jsp");
		
		System.out.println("addUserAction end");
		
		return modelAndView;
		
	}//end of addUser
	
	@RequestMapping("checkDuplication/{userId}")
	public ModelAndView checkDuplicationAction(@PathVariable String userId) throws Exception {
		
		System.out.println("check duplicationAction start");
		
		ModelAndView modelAndView = new ModelAndView();
		
		boolean result = userService.checkDuplication(userId);
		
		modelAndView.addObject("result", new Boolean(result));
		modelAndView.addObject("userId", userId);
		modelAndView.setViewName("/user/checkDuplication.jsp");
		
		System.out.println("check duplicationAction end");
		
		return modelAndView;
		
	}//end of checkDuplication
	
	@RequestMapping("getUser/{userId}")
	public ModelAndView getUser(@PathVariable String userId, HttpSession session) throws Exception {
		
		System.out.println("getUSerAction start");
		
		User user = userService.getUser(userId);
		
		ModelAndView modelAndView = new ModelAndView("/user/getUser.jsp");
		
		modelAndView.addObject("user", user);
		
		if(!user.getRole().equals("admin"))
		{
			modelAndView.setViewName("/user/readUser.jsp");
		}
		
		System.out.println("getUSerAction end");
		
		return modelAndView;
		
	}//end of getUser
	
	@RequestMapping("listUser")
	public ModelAndView listUser(@ModelAttribute("searchVo") Search search) throws Exception {
		
		System.out.println("listUserAction start");
		
		ModelAndView modelAndView = new ModelAndView();
		
		int currentPage=1;

		if(search.getCurrentPage() != 0){
			currentPage=search.getCurrentPage();
		}else {
			search.setCurrentPage(1);
		}
		
		search.setPageSize(common.getPageSize());
		
		Map<String , Object> map=userService.getUserList(search);
		
		Page resultPage	= 
					new Page( currentPage, ((Integer)map.get("totalCount")).intValue(), common.getPageUnit(), common.getPageSize());
		System.out.println("ListUserAction ::"+resultPage);
		
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
		modelAndView.addObject("where", "User");
		modelAndView.addObject("list", map.get("list"));
		modelAndView.setViewName("/user/listUser.jsp");
		
		
		System.out.println("listUserAction end");
		
		return modelAndView;
		
	}//end of listUser
	
	@RequestMapping( value="login", method=RequestMethod.GET )
	public String login() throws Exception{
		
		System.out.println("/user/logon : GET");

		return "redirect:/user/loginView.jsp";
	}
	
	@RequestMapping( value="login", method=RequestMethod.POST )
	public String login(@ModelAttribute("user") User user , HttpSession session ) throws Exception{
		
		System.out.println("/user/login : POST");
		//Business Logic
		User dbUser=userService.getUser(user.getUserId());
		
		if(dbUser == null) {
			return "redirect:/index.jsp";
		}
		
		if( user.getPassword().equals(dbUser.getPassword())){
			session.setAttribute("user", dbUser);
		}else {
			return "redirect:/index.jsp";
		}
		
		return "redirect:/home.jsp";
	}
	
	@RequestMapping("logout")
	public ModelAndView logout(HttpSession session) {
		
		System.out.println("logoutAction start");
		
		session.removeAttribute("user");
		
		System.out.println("logoutAction end");
		
		return new ModelAndView("redirect:/index.jsp");
		
	}//end of logoutAction
	
	@RequestMapping("updateUser")
	public ModelAndView updateUser(@ModelAttribute("user") User user, HttpSession session) throws Exception {
		
		System.out.println("updateUserAction start");
		
		ModelAndView modelAndView = new ModelAndView();
		
		userService.updateUser(user);
		
		user = userService.getUser(user.getUserId());
		
		String sessionId=((User)session.getAttribute("user")).getUserId();
		
		System.out.println(user.getUserId()+", "+sessionId);
		
		if(sessionId.equals(user.getUserId())){
			System.out.println("update : setSession");
			session.setAttribute("user", user);
		}
		
		modelAndView.setViewName("forward:/user/getUser/"+user.getUserId());
		
		System.out.println("updateUserAction end");
		
		return modelAndView;
		
	}//end of updateUserAction
	
	@RequestMapping("updateUserView/{userId}")
	public ModelAndView updateUserView(@PathVariable("userId") String userId) throws Exception {
		
		System.out.println("updateUserViewAction start");
		
		ModelAndView modelAndView = new ModelAndView("/user/updateUser.jsp");
		
		User user=userService.getUser(userId);
		
		modelAndView.addObject("user", user);
		
		System.out.println("updateUserViewAction end");
		
		return modelAndView;
		
	}
	
}//end of UserController





















