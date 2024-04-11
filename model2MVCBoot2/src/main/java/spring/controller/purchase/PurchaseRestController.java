package spring.controller.purchase;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import spring.common.CommonProperties;
import spring.common.Page;
import spring.domain.Product;
import spring.domain.Purchase;
import spring.domain.User;
import spring.product.ProductService;
import spring.purchase.PurchaseService;
import spring.user.UserService;

@Controller
@RequestMapping("/app/purchase/*")
public class PurchaseRestController {
	
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productServiceImpl;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userServiceImpl;

	@Autowired
	private CommonProperties common;
	
	public PurchaseRestController() {
		System.out.println("Default PurchaseRestController call...");
	}
	
	@RequestMapping(value="addPurchase", method=RequestMethod.POST)
	public Purchase addPurchaseAction(@RequestBody Purchase purchase) throws Exception {
		
		System.out.println("addPurchaseAction start");
		
		purchase.setTranCode("0");//판매완료
		
		purchaseService.addPurchase(purchase);
		
		System.out.println("addPurchaseAction end");
		
		return purchase;
		
	}//end of addPurchaseAction
	
	@RequestMapping("addPurchaseView")
	public Map addPurchaseViewAction(@RequestParam("buyerId") String userId,
										@RequestParam("prod_no") String prodNo) throws Exception {
		
		System.out.println("addPurchaseViewAction start");
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		Product product = productServiceImpl.getProduct(Integer.parseInt(prodNo));
		User user = userServiceImpl.getUser(userId);
		
		map.put("user", user);
		map.put("product", product);
		
		System.out.println("addPurchaseViewAction end");
		
		return map;
		
	}//end of addPurchaseViewAction
	
	@RequestMapping("getPurchase/{tranNo}")
	public Purchase getPurchaseAction(@PathVariable("tranNo") String tranNo) throws Exception {
		
		System.out.println("getPurchaseAction start");
		
		Purchase purchase = purchaseService.getPurchase(Integer.parseInt(tranNo));
		purchase.setTranNo(Integer.parseInt(tranNo));
		//System.out.println("divlDate : "+purchase.getDivyDate().split(" ")[0].replaceAll("-", ""));
		purchase.setDivyDate(purchase.getDivyDate().split(" ")[0]);
		
		System.out.println("getPurchaseAction end");
		
		return purchase;
		
	}//end of getPurchaseAction
	
	@RequestMapping("listPurchase/{page}")
	public Map listPurchaseAction(@PathVariable(required = false) int page, HttpSession session) throws Exception {
		
		System.out.println("listPurchaseAction start");
		
		if(page == 0)
			page = 1;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", ((User)session.getAttribute("user")).getUserId());
		map.put("begin", common.getPageSize() * page - common.getPageSize() + 1);
		map.put("end", common.getPageSize() * page);
		
		Map<String, Object> result = purchaseService.getPurchaseList(map);
		
		Page resultPage	= 
				new Page( page, ((Integer)result.get("Integer")).intValue(), common.getPageUnit(), common.getPageSize());
		System.out.println("ListPurcahseAction ::"+resultPage);
		
		map.put("resultPage", resultPage);
		map.put("map", result);
		
		System.out.println("listPurchaseAction end");
		
		return map;
		
	}//end of listPurchaseAction
	
	@RequestMapping("listSale")
	public ModelAndView listSaleAction() throws Exception {
		
		System.out.println("listSaleAction start");
		
		ModelAndView modelAndView = new ModelAndView();
		
		System.out.println("listSaleAction end");
		
		return modelAndView;
		
	}//end of listSaleAction
	
	@RequestMapping(value="updatePurchase", method=RequestMethod.POST)
	public Purchase updatePurchaseAction(@RequestBody Purchase purchase) throws Exception {
		
		System.out.println("updatePurchaseAction start");
		
		System.out.println("update Purchase : "+purchase);
		
		purchaseService.updatePurchase(purchase);
		
		purchase = purchaseService.getPurchase(purchase.getTranNo());
		
		System.out.println("updatePurchaseAction end");
		
		return purchase;
		
	}//end of updatePurchaseAction
	
	@RequestMapping("updatePurchaseView")
	public Purchase updatePurchaseViewAction(@RequestParam("tranNo") int tranNo) throws Exception {
		
		System.out.println("updatePurchaseViewAction start");
		
		Purchase purchase = purchaseService.getPurchase(tranNo);
		purchase.setDivyDate(purchase.getDivyDate().split(" ")[0].replaceAll("-", ""));
		
		System.out.println("updatePurchaseViewAction end");
		
		return purchase;
		
	}//end of updatePurchaseViewAction
	
	@RequestMapping(value="updateTranCode", method=RequestMethod.POST)
	public void updateTranCodeAction(@RequestParam("tranNo") int tranNo) throws Exception {
		
		System.out.println("updateTranCodeAction start");
		
		purchaseService.updateTranCode(tranNo);
		
		System.out.println("updateTranCodeAction end");
		
	}//end of updateTranCodeAction
	
	@RequestMapping(value="updateTranCodeByProd", method=RequestMethod.POST)
	public void updateTranCodeByProdAction(@RequestParam("prodNo") int prodNo) throws Exception {
		
		System.out.println("updateTranCodeByProdAction start");
		
		purchaseService.updateTranCodeByProdAction(prodNo);
		
		System.out.println("updateTranCodeByProdAction end");
		
	}//end of updateTranCodeByProdAction

}//end of PurchaseController















