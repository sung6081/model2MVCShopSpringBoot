package spring.purchase;

import java.util.Map;

import spring.domain.Purchase;

public interface PurchaseService {

	public void addPurchase(Purchase purchase);
	
	public Purchase getPurchase(int tranNo);
	
	public void updatePurchase(Purchase purchase);
	
	public Map<String, Object> getPurchaseList(Map<String, Object> map);
	
	public void updateTranCode(int tranNo);
	
	public void updateTranCodeByProdAction(int prodNo);
	
}
