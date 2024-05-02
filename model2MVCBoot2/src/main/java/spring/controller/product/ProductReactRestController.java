package spring.controller.product;

import java.io.IOException;
import java.lang.reflect.Array;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
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
import org.springframework.stereotype.Controller;
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
import org.springframework.web.multipart.MultipartFile;
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

@CrossOrigin(origins = "*")
@RestController
@RequestMapping("/react/product/*")
public class ProductReactRestController {
	
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
	
	public ProductReactRestController() {
		System.out.println("Default ProductReactRestController call...");
	}
	
	@GetMapping(value = "homeCarousel")
	public List HomeCarouselProductImage() throws Exception {
		
		System.out.println("HomeCarouselProductImage start");
		
		Search search = new Search();
		
		search.setCurrentPage(1);
		search.setPageSize(3);
		search.setMenu("search");
		
		Map map = productService.getProductList(search);
		
		List<File> result = new ArrayList<File>();
		
		List<Product> list = (List<Product>)map.get("list");
		
		for(Product product : list) {
			
			List<File> files = fileService.getFilesList(product.getProdNo());
			
			result.add(files.get(0));
			
		}
		
		System.out.println("HomeCarouselProductImage end");
		
		return result;
		
	}
	
	@GetMapping(value = "homeProductList/{currentPage}")
	public Map<String, Object> HomeProductList(@PathVariable int currentPage) throws Exception {
		
		System.out.println("HomeProductList start");
		
		Search search = new Search();
		
		search.setCurrentPage(currentPage);
		search.setPageSize(common.getPageSize());
		search.setMenu("search");
		
		Map<String, Object> map = productService.getProductList(search);
		
		Page resultPage	= new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), common.getPageUnit(), common.getPageSize());
		
		map.put("resultPage", resultPage);
		
		System.out.println("HomeProductList end");
		
		return map;
	
	}
	
	@PostMapping(value="productList")
	public Map<String, Object> getProductList(@RequestBody Search search) throws Exception {
		
		System.out.println("getProductList start");
		
		search.setPageSize(common.getPageSize());
		//search.setMenu("manage");
		
		Map<String, Object> map = productService.getProductList(search);
		
		Page resultPage	= new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), common.getPageUnit(), common.getPageSize());
		
		map.put("resultPage", resultPage);
		
		System.out.println("getProductList end");
		
		return map;
		
	}
	
	@GetMapping(value="getProduct/{prodNo}")
	public Product getProduct(@PathVariable int prodNo) throws Exception {
		
		System.out.println("getProduct start");
		
		System.out.println("getProduct end");
		
		Product product =  productService.getProduct(prodNo);
		
		if(product.getProTranCode() == null) {
			product.setProTranCode("판매중");
		}else if(product.getProTranCode().equals("0")) {
			product.setProTranCode("판매완료");
		}else if(product.getProTranCode().equals("1")) {
			product.setProTranCode("배송중");
		}else {
			product.setProTranCode("배송완료");
		}
		
		return product;
		
	}
	
	@GetMapping(value="getCategoryList")
	public List<Category> getCateList() throws Exception {
		
		System.out.println("getCateList start");
		
		System.out.println("getCateList end");
		
		return productService.getCategoryList();
		
	}
	
	@GetMapping(value="autoCompleteList/{prodName}")
	public List<Product> autoCompleteList(@PathVariable String prodName) throws Exception {
		
		System.out.println("autoCompleteList start");
		
		
		
		System.out.println("autoCompleteList end");
		
		return productService.getProdNameList(prodName);
		
	}
	
	@PostMapping(value="addProduct")
	public Product addProduct(@RequestParam(value="file", required=false) MultipartFile[] inputFiles, 
			@ModelAttribute Product product) throws Exception {
		
		System.out.println("addProduct start");
		
		System.out.println("product : "+product);
		//System.out.println("files : " +inputFiles[0]);
		
		product.setProdName(URLDecoder.decode(product.getProdName(), "UTF-8"));
		product.setProdDetail(URLDecoder.decode(product.getProdDetail(), "UTF-8"));
		
		System.out.println("product : "+product);
		
		productService.addProduct(product);
		
		if(inputFiles == null) {
			spring.domain.File inputFile = new spring.domain.File();
			inputFile.setFileName("no_image.png");
			inputFile.setProdNo(product.getProdNo());
			fileService.addFile(inputFile);
		}else {
			
			for(int i = 0; i < inputFiles.length; i++) {
				
				System.out.println(inputFiles[i].getOriginalFilename());

				MultipartFile file = inputFiles[i];
				
				System.out.println("fileName :"+file.getOriginalFilename()+"_");
				
				System.out.println("filePath:"+common.getUploadPath());
				
				if(file.getOriginalFilename() != null && !file.getOriginalFilename().equals("")) {
					UUID uuid = UUID.randomUUID();
					System.out.println("fileName :"+file.getOriginalFilename()+"_");
					String extension = file.getOriginalFilename().split("\\.")[1];
					String fileName = file.getOriginalFilename().split("\\.")[0] + uuid +"."+ extension;
					product.setFileName(fileName);
					
					//File destination = new File(common.getUploadPath()+"\\"+fileName);
					java.io.File destination = new java.io.File(common.getUploadPath(), fileName);
					try {
						file.transferTo(destination);
					}catch(IOException e) {
						e.printStackTrace();
					}
					
					spring.domain.File inputFile = new spring.domain.File();
					inputFile.setProdNo(product.getProdNo());
					inputFile.setFileName(fileName);
					fileService.addFile(inputFile);
					
				}
				
			}
		}
		
		System.out.println("addProduct end");
		
		return product;
		
	}
	
}//end of ProductController












