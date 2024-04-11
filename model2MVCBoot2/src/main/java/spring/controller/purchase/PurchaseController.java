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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import spring.common.CommonProperties;
import spring.common.Page;
import spring.domain.Product;
import spring.domain.Purchase;
import spring.domain.User;
import spring.product.ProductService;
import spring.purchase.PurchaseService;

@Controller
@RequestMapping("/purchase/*")
public class PurchaseController {
	
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productServiceImpl;

	@Autowired
	private CommonProperties common;
	
	public PurchaseController() {
		System.out.println("Default PurchaseController call...");
	}
	
	@RequestMapping("addPurchase")
	public ModelAndView addPurchaseAction(HttpSession session, HttpServletRequest request) throws Exception {
		
		System.out.println("addPurchaseAction start");
		
		ModelAndView modelAndView = new ModelAndView("/purchase/addPurchase.jsp");
		
		Purchase purchase = new Purchase();
		
		User user = (User)session.getAttribute("user");
		
		purchase.setBuyer(user);
		Product product = new Product();
		product.setProdNo(Integer.parseInt(request.getParameter("prodNo")));
		purchase.setPurchaseProd(product);
		
		purchase.setDivyAddr(request.getParameter("receiverAddr"));
		purchase.setDivyDate(request.getParameter("receiverDate"));
		purchase.setDivyRequest(request.getParameter("receiverRequest"));
		purchase.setPaymentOption(request.getParameter("paymentOption"));
		purchase.setReceiverName(request.getParameter("receiverName"));
		purchase.setReceiverPhone(request.getParameter("receiverPhone"));
		purchase.setTranNo(0);
		purchase.setTranCode("0");//판매완료
		
		purchaseService.addPurchase(purchase);
		
		modelAndView.addObject("purchase", purchase);
		
		System.out.println("addPurchaseAction end");
		
		return modelAndView;
		
	}//end of addPurchaseAction
	
	@RequestMapping("addPurchaseView")
	public ModelAndView addPurchaseViewAction(HttpSession session,
										@RequestParam("prod_no") String prodNo) throws Exception {
		
		System.out.println("addPurchaseViewAction start");
		
		ModelAndView modelAndView = new ModelAndView("/purchase/addPurchaseView.jsp");
		
		Product product = productServiceImpl.getProduct(Integer.parseInt(prodNo));
		User user = (User)session.getAttribute("user");
		
		modelAndView.addObject("user", user);
		modelAndView.addObject("product", product);
		
		System.out.println("addPurchaseViewAction end");
		
		return modelAndView;
		
	}//end of addPurchaseViewAction
	
	@RequestMapping("getPurchase")
	public ModelAndView getPurchaseAction(@RequestParam("tranNo") String tranNo) throws Exception {
		
		System.out.println("getPurchaseAction start");
		
		ModelAndView modelAndView = new ModelAndView("/purchase/getPurchase.jsp");
		
		Purchase purchase = purchaseService.getPurchase(Integer.parseInt(tranNo));
		purchase.setTranNo(Integer.parseInt(tranNo));
		//System.out.println("divlDate : "+purchase.getDivyDate().split(" ")[0].replaceAll("-", ""));
		purchase.setDivyDate(purchase.getDivyDate().split(" ")[0]);
		//purchase.setPaymentOption(purchase.getPaymentOption().trim());
		
		modelAndView.addObject("purchase", purchase);
		
		System.out.println("getPurchaseAction end");
		
		return modelAndView;
		
	}//end of getPurchaseAction
	
	@RequestMapping("listPurchase")
	public ModelAndView listPurchaseAction(HttpSession session, HttpServletRequest request) throws Exception {
		
		System.out.println("listPurchaseAction start");
		
		ModelAndView modelAndView = new ModelAndView("/purchase/listPurchase.jsp");
		
		int page = 1;
		if(request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", ((User)session.getAttribute("user")).getUserId());
		map.put("begin", common.getPageSize() * page - common.getPageSize() + 1);
		map.put("end", common.getPageSize() * page);
		
		Map<String, Object> result = purchaseService.getPurchaseList(map);
		
		Page resultPage	= 
				new Page( page, ((Integer)result.get("Integer")).intValue(), common.getPageUnit(), common.getPageSize());
		System.out.println("ListPurcahseAction ::"+resultPage);
		
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("map", result);
		
		System.out.println("listPurchaseAction end");
		
		return modelAndView;
		
	}//end of listPurchaseAction
	
	@RequestMapping("listSale")
	public ModelAndView listSaleAction() throws Exception {
		
		System.out.println("listSaleAction start");
		
		ModelAndView modelAndView = new ModelAndView();
		
		System.out.println("listSaleAction end");
		
		return modelAndView;
		
	}//end of listSaleAction
	
	@RequestMapping("updatePurchase")
	public ModelAndView updatePurchaseAction(HttpServletRequest request) throws Exception {
		
		System.out.println("updatePurchaseAction start");
		
		ModelAndView modelAndView = new ModelAndView("forward:/purchase/getPurchase?option=update&page="+request.getParameter("page"));
		
		Purchase purchase = new Purchase();
		
		purchase.setPaymentOption(request.getParameter("paymentOption"));
		purchase.setReceiverName(request.getParameter("receiverName"));
		purchase.setReceiverPhone(request.getParameter("receiverPhone"));
		purchase.setDivyAddr(request.getParameter("receiverAddr"));
		purchase.setDivyRequest(request.getParameter("receiverRequest"));
		purchase.setDivyDate(request.getParameter("divyDate"));
		purchase.setTranNo(Integer.parseInt(request.getParameter("tranNo")));
		
		System.out.println("update Purchase : "+purchase);
		
		purchaseService.updatePurchase(purchase);
		
		System.out.println("updatePurchaseAction end");
		
		return modelAndView;
		
	}//end of updatePurchaseAction
	
	@RequestMapping("updatePurchaseView")
	public ModelAndView updatePurchaseViewAction(@RequestParam("tranNo") int tranNo,
			@RequestParam("page") String page) throws Exception {
		
		System.out.println("updatePurchaseViewAction start");
		
		ModelAndView modelAndView = new ModelAndView("/purchase/updatePurchaseView.jsp?page="+page);
		
		Purchase purchase = purchaseService.getPurchase(tranNo);
		purchase.setDivyDate(purchase.getDivyDate().split(" ")[0].replaceAll("-", ""));
		
		modelAndView.addObject("purchase", purchase);
		
		System.out.println("updatePurchaseViewAction end");
		
		return modelAndView;
		
	}//end of updatePurchaseViewAction
	
	@RequestMapping("updateTranCode")
	public ModelAndView updateTranCodeAction(@RequestParam("tranNo") int tranNo) throws Exception {
		
		System.out.println("updateTranCodeAction start");
		
		ModelAndView modelAndView = new ModelAndView("forward:/purchase/listPurchase");
		
		purchaseService.updateTranCode(tranNo);
		
		System.out.println("updateTranCodeAction end");
		
		return modelAndView;
		
	}//end of updateTranCodeAction
	
	@RequestMapping("updateTranCodeByProd")
	public ModelAndView updateTranCodeByProdAction(@RequestParam("prodNo") int prodNo) throws Exception {
		
		System.out.println("updateTranCodeByProdAction start");
		
		ModelAndView modelAndView = new ModelAndView("forward:/product/listProduct?menu=manage");
		
		purchaseService.updateTranCodeByProdAction(prodNo);
		
		System.out.println("updateTranCodeByProdAction end");
		
		return modelAndView;
		
	}//end of updateTranCodeByProdAction

}//end of PurchaseController















