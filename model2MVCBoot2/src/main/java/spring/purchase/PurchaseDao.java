package spring.purchase;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import spring.common.Search;
import spring.domain.Purchase;

@Mapper
public interface PurchaseDao {

	public void addPurchase(Purchase purchase);
	
	public Purchase getPurchase(int tranNo);
	
	public void updatePurchase(Purchase purchase);
	
	public List<Purchase> getPurchaseList(Map<String, Object> map);
	
	public int getTotalCount(Map<String, Object> map);
	
	public void updateTranCode(int tranNo);
	
	public void updateTranCodeByProdAction(int prodNo);
	
}
