package spring.controller.product;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.plaf.basic.BasicInternalFrameTitlePane.SystemMenuBar;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ResourceLoader;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import spring.common.Category;
import spring.common.CommonProperties;
import spring.common.Page;
import spring.common.Search;
import spring.domain.Product;
import spring.domain.User;
import spring.product.ProductService;
import spring.product.impl.ProductServiceImpl;

@Controller
@RequestMapping("/product/*")
public class ProductController {
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Autowired
	private CommonProperties common;
	
	@Autowired
	private ResourceLoader resourceLoader;
	
	public ProductController() {
		System.out.println("Default ProductController called");
	}
	
	@RequestMapping("addPrdouctView")
	public ModelAndView addProductView(HttpServletRequest request, HttpSession session) throws Exception {
		
		System.out.println("addProductView");
		
		ModelAndView modelAndView = new ModelAndView("/product/addProductView.jsp");
		
		if(session.getAttribute("listCategory") == null)
			session.setAttribute("listCategory", productService.getCategoryList());
		
		System.out.println("addProductView");
		
		return modelAndView;
		
	}//end of addProductView

	@RequestMapping("addProduct")
	public ModelAndView addProductAction(@RequestPart(required = false) MultipartFile file,@ModelAttribute Product product,
											@RequestParam String category) throws Exception {
		
		System.out.println("addProductAction start");
		
		ModelAndView modelAndView = new ModelAndView("/product/addProduct.jsp");
		
		System.out.println("fileName :"+file.getOriginalFilename()+"_");
		
		System.out.println("filePath:"+common.getUploadPath());
		
		if(file.getOriginalFilename() != null && !file.getOriginalFilename().equals("")) {
			UUID uuid = UUID.randomUUID();
			System.out.println("fileName :"+file.getOriginalFilename()+"_");
			String extension = file.getOriginalFilename().split("\\.")[1];
			String fileName = file.getOriginalFilename().split("\\.")[0] + uuid +"."+ extension;
			product.setFileName(fileName);
			
			//File destination = new File(common.getUploadPath()+"\\"+fileName);
			File destination = new File(resourceLoader.getResource(common.getUploadPath()).getFile(), fileName);
			try {
				file.transferTo(destination);
			}catch(IOException e) {
				e.printStackTrace();
			}
			
		}else {
			product.setFileName("no_image.png");
			System.out.println("fileName :"+file.getOriginalFilename()+"_");
		}
		
		System.out.println("_"+category+"_");
		
		if(!category.equals("0")) {
			product.setCateNo(category.split("&")[0]);
			product.setCateName(category.split("&")[1]);
		}
		
		productService.addProduct(product);
		modelAndView.addObject("product", product);
		
		System.out.println("addProductAction end");
		
		return modelAndView;
		
	}//end of addProductAction
	
	@RequestMapping("getProduct")
	public ModelAndView getProductAction(HttpSession session, HttpServletRequest request,
										HttpServletResponse response) throws Exception {
		
		System.out.println("getProductAction start");
		
		ModelAndView modelAndView = new ModelAndView("redirect:/user/loginView.jsp");
		
//		if(session.getAttribute("user") == null) {
//			System.out.println("getProductAction end");
//			return modelAndView;
//		}
		
		if( request.getParameter("menu") != null && request.getParameter("menu").equals("manage")) {
			modelAndView.setViewName("forward:/product/updateProductView");
			System.out.println("getProductAction end");
			return modelAndView;
		}
		
		Product product = productService.getProduct(Integer.parseInt(request.getParameter("prodNo")));
		product.setProdNo(Integer.parseInt(request.getParameter("prodNo")));
		
		modelAndView.addObject("product", product);
		
		if(request.getParameter("menu") != null && request.getParameter("menu").equals("update")) {
			modelAndView.setViewName("/product/updateProduct.jsp");
			System.out.println("getProductAction end");
			return modelAndView;
		}
		
		Cookie[] cookies = request.getCookies();
		
		String record = "";
		Cookie cookie = null;
		
		for(int i = 0; i < cookies.length; i++) {
			
			if(cookies[i].getName().equals("history")) {
				cookie= cookies[i];
				break;
			}
			
		}
		
		if(cookie != null) {
			String[] history = cookie.getValue().split("and");
			
			for(int i = 0; i < history.length; i++) {
				if(!history[i].equals(""+product.getProdNo()))
					if(i == 0)
						record += history[i];
					else
						record += "and"+history[i];
			}
			if(!record.equals(""))
				record += "and"+product.getProdNo();
			else
				record += product.getProdNo();
			
			cookie.setValue(record);
			
		}else {
			cookie = new Cookie("history", new Integer(product.getProdNo()).toString());
		}
		
		System.out.println("cookie : "+cookie.getName());
		System.out.println("cookie : "+cookie.getValue());
		System.out.println("cookie : "+cookies.length);
		
		//cookie.setMaxAge(3600);
		cookie.setPath("/");
		response.addCookie(cookie);
		
		if(request.getParameter("menu") == null) {
			modelAndView.setViewName("/product/readProduct.jsp?page="+request.getParameter("page"));
			System.out.println("getProductAction end");
			return modelAndView;
		}
		
		modelAndView.setViewName("/product/getProduct.jsp");
		
		System.out.println(response.toString());
		
		System.out.println("getProductAction Realend");
		
		return modelAndView;
		
	}//end of getProductAction
	
	@RequestMapping("listProduct")
	public ModelAndView listProductAction(HttpServletRequest request, HttpSession session) throws Exception {
		
		System.out.println("listProductAction start");
		
		ModelAndView modelAndView = new ModelAndView("/product/listProduct.jsp");
		
		Search searchVO = new Search();
		Category category = new Category();
		
		if(request.getParameter("category") != null) {
			searchVO.setCateNo(Integer.parseInt(request.getParameter("category")));
		}
		
		System.out.println("controller search : "+searchVO);
		
		int page = 1;
		
		if(request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
			
		searchVO.setCurrentPage(page);
		searchVO.setSearchCondition(request.getParameter("searchCondition"));
		searchVO.setSearchKeyword(request.getParameter("searchKeyword"));
		if(request.getParameter("low") != null && request.getParameter("low") != "")
			searchVO.setPriceOption("low");
		else if(request.getParameter("high") != null && request.getParameter("high") != "")
			searchVO.setPriceOption("high");
		searchVO.setMenu(request.getParameter("menu"));
		searchVO.setSearchRange(request.getParameter("searchRange"));
		
		User user = (User)request.getSession().getAttribute("user");
			
		searchVO.setPageSize(common.getPageSize());
		
		if(user == null || user.getRole().equals("user"))
		{
			searchVO.setPageSize(6);
		}
			
		Map<String, Object> map = productService.getProductList(searchVO);
		System.out.println("getList over");
		
		Page resultPage	= new Page( page, ((Integer)map.get("totalCount")).intValue(), common.getPageUnit(), common.getPageSize());
		System.out.println(resultPage);
			
		modelAndView.addObject("map", map);
		modelAndView.addObject("searchVO", searchVO);
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("list", map.get("list"));
		//modelAndView.addObject("listCategory", map.get("listCategory"));
		session.setAttribute("listCategory", map.get("listCategory"));
		request.setAttribute("where", "Product");
		modelAndView.addObject("where", "Product");
		
		if(user == null || user.getRole().equals("user"))
		{
			modelAndView.setViewName("/product/searchProduct.jsp");
		}
		
		System.out.println("listProductAction end");
		
		return modelAndView;
		
	}//end of listProductAction
	
	@RequestMapping("updateProduct")
	public ModelAndView updateProductAction(@RequestPart(required = false) MultipartFile file,@ModelAttribute Product product,
			@RequestParam String category) throws Exception {
		
		System.out.println("updateProductAction start");
		
		ModelAndView modelAndView = new ModelAndView();
		
		System.out.println("fileName :"+file.getOriginalFilename()+"_");
		
		System.out.println("filePath:"+common.getUploadPath());
		
		if(file.getOriginalFilename() != null && !file.getOriginalFilename().equals("")) {
			UUID uuid = UUID.randomUUID();
			System.out.println("fileName :"+file.getOriginalFilename()+"_");
			String extension = file.getOriginalFilename().split("\\.")[1];
			String fileName = file.getOriginalFilename().split("\\.")[0] + uuid +"."+ extension;
			product.setFileName(fileName);
			
			//File destination = new File(common.getUploadPath()+"\\"+fileName);
			File destination = new File(resourceLoader.getResource(common.getUploadPath()).getFile(), fileName);
			try {
				file.transferTo(destination);
			}catch(IOException e) {
				e.printStackTrace();
			}
			
		}
		
		System.out.println("_"+category+"_");
		
		if(!category.equals("0")) {
			product.setCateNo(category.split("&")[0]);
			product.setCateName(category.split("&")[1]);
		}
		
		productService.updateProduct(product);
		modelAndView.addObject("product", product);
		
		modelAndView.setViewName("forward:/product/getProduct?prodNo="+product.getProdNo()+"&menu=update");
		
		System.out.println("updateProductAction end");
		
		return modelAndView;
		
	}//end of updateProductAction
	
	@RequestMapping("updateProductView")
	public ModelAndView updateProductViewAction(HttpServletRequest request) throws NumberFormatException, Exception {
		
		System.out.println("updateProductViewAction start");
		
		ModelAndView modelAndView = new ModelAndView();
		
		Product product = productService.getProduct(Integer.parseInt(request.getParameter("prodNo")));
		
		request.setAttribute("product", product);
		
		System.out.println(product);
		modelAndView.setViewName("/product/updateProductView.jsp");
		
		System.out.println("updateProductViewAction end");
		
		return modelAndView;
		
	}//updateProductViewAction
	
	@RequestMapping("addCategory")
	public ModelAndView addCategory(@RequestParam("addCategory") String cateName, HttpSession session) throws Exception {
		
		System.out.println("addCategory start");
		
		ModelAndView modelAndView = new ModelAndView("forward:/product/listProduct?memu=manage");
		
		//List<Category> list = (List)session.getAttribute("listCategory");
		
		/*
		 * for(Category cate : list) { if(cate.getCateName().equals(cateName)) {
		 * System.out.println("already exist");
		 * modelAndView.addObject("duplicationCate", new Boolean(true));
		 * System.out.println("addCategory end");
		 * 
		 * return modelAndView; } }
		 */
		
		productService.addCategory(cateName);
		
		System.out.println("addCategory end");
		
		return modelAndView;
		
	}//end of addCategory
	
	@RequestMapping("removeCategory")
	public ModelAndView removeCategory(@RequestParam("rmCategory") int cateNo) throws Exception {
		
		System.out.println("removeCategory start");
		
		ModelAndView modelAndView = new ModelAndView("forward:/product/listProduct?memu=manage");
		
		productService.updateProdCategoryNull(cateNo);
		
		productService.removeCategory(cateNo);
		
		System.out.println("removeCategory end");
		
		return modelAndView;
		
	}//end of removeCategory
	
}//end of ProductController












