package spring.product;

import java.util.List;
import java.util.Map;

import spring.common.Category;
import spring.common.Search;
import spring.domain.Product;

public interface ProductService {

	public void addProduct(Product product) throws Exception;
	
	public Product getProduct(int prodNo) throws Exception;
	
	public Map<String, Object> getProductList(Search search) throws Exception;
	
	public void updateProduct(Product product) throws Exception;
	
	public void addCategory(String cateName) throws Exception;
	
	public List<Category> getCategoryList() throws Exception;
	
	public void removeCategory(int cateNo) throws Exception;
	
	public void updateProdCategoryNull(int cateNo) throws Exception;
	
	public List getProdNameList(String prodName) throws Exception;
	
}
