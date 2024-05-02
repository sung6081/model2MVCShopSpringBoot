package spring.controller.product;

import java.lang.reflect.Array;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.plaf.basic.BasicInternalFrameTitlePane.SystemMenuBar;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import spring.common.Category;
import spring.common.CommonProperties;
import spring.common.Page;
import spring.common.Search;
import spring.domain.File;
import spring.domain.Product;
import spring.files.FileService;
import spring.product.ProductService;
import spring.product.impl.ProductServiceImpl;

@RestController
@RequestMapping("/app/product/*")
public class ProductRestController {
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Autowired
	private CommonProperties common;
	
	@Autowired
	@Qualifier("fileServiceImpl")
	private FileService fileService;
	
	public void setFileService(FileService fileService) {
		this.fileService = fileService;
	}
	
	public ProductRestController() {
		System.out.println("Default ProductRestController call...");
	}
	
	@RequestMapping("addPrdouctView")
	public List<Category> addProductView(HttpServletRequest request, HttpSession session) throws Exception {
		
		System.out.println("addProductView");
		
		List<Category> list = productService.getCategoryList();
		
		if(session.getAttribute("listCategory") == null)
			session.setAttribute("listCategory", list);
		
		System.out.println("addProductView");
		
		return list;
		
	}//end of addProductView

	@RequestMapping("addProduct")
	public Product addProductAction(@RequestBody Product product) throws Exception {
		
		System.out.println("addProductAction start");
		
		productService.addProduct(product);
		
		System.out.println("addProductAction end");
		
		return product;
		
	}//end of addProductAction
	
	@RequestMapping("getProduct/{prodNo}")
	public Product getProductAction(@PathVariable("prodNo") int prodNo ) throws Exception {
		
		System.out.println("getProductAction start");
		
		Product product = productService.getProduct(prodNo);
		List<File> files = fileService.getFilesList(prodNo);
		
		System.out.println("getProductAction Realend");
		
		return product;
		
	}//end of getProductAction
	
	@RequestMapping(value="listProduct", method=RequestMethod.GET)
	public Map listProductAction() throws Exception {
		
		System.out.println("listProductAction start");
		
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(common.getPageSize());
		
		Map map = productService.getProductList(search);
		
		System.out.println("listProductAction end");
		
		return map;
		
	}//end of listProductAction
	
	@RequestMapping(value="listProduct", method=RequestMethod.POST)
	public List listProductAction(@RequestBody Search search) throws Exception {
		
		System.out.println("listProductAction start");
		
		search.setPageSize(3);
		
		Map<String, Object> map = productService.getProductList(search);
		
		System.out.println("listProductAction end");
		
		List<Product> list = (List<Product>) map.get("list");
		
		return list;
		
	}//end of listProductAction
	
	@RequestMapping("updateProduct")
	public Product updateProductAction(@RequestBody Product product) throws Exception {
		
		System.out.println("updateProductAction start");
		
		productService.updateProduct(product);
		product = productService.getProduct(product.getProdNo());
		
		System.out.println("updateProductAction end");
		
		return product;
		
	}//end of updateProductAction
	
	@RequestMapping("updateProductView/{prodNo}")
	public Product updateProductViewAction(@PathVariable int prodNo) throws NumberFormatException, Exception {
		
		System.out.println("updateProductViewAction start");
		
		Product product = productService.getProduct(prodNo);
		
		System.out.println("updateProductViewAction end");
		
		return product;
		
	}//updateProductViewAction
	
	@RequestMapping(value="checkCategoryExist/{cateName}", method=RequestMethod.GET)
	public Boolean checkCategoryExist(@PathVariable String cateName) throws Exception {
		
		System.out.println("checkCategoryExist start");
		
		List<Category> list = productService.getCategoryList();
		
		for(Category cate : list) {
			
			if(cate.getCateName().equals(cateName)) {
				return new Boolean(false);
			}
			
		}
		
		System.out.println("checkCategoryExist end");
		
		return new Boolean(true);
	}//end of checkCategoryExist
	
	@RequestMapping(value="getProdNameList/{prodName}", method=RequestMethod.GET)
	public List getProdNameList(@PathVariable String prodName) throws Exception {
		
		System.out.println("getProdNameList start");
		
		List array = productService.getProdNameList(prodName); 
		
		System.out.println("getProdNameList end");
		
		return array;
		
	}//end of getProdNameList
	
}//end of ProductController












