package spring.product;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import spring.common.Category;
import spring.common.Search;
import spring.domain.Product;

@Mapper
public interface ProductDao {

	public int addProduct(Product product) throws Exception;
	
	public Product getProduct(int prodNo) throws Exception;
	
	public List<Product> getProductList(Search search) throws Exception;
	
	public void updateProduct(Product product) throws Exception;
	
	public int getTotalCount(Search search) throws Exception;
	
	public void addCategory(String cateName) throws Exception;
	
	public List<Category> getCategoryList() throws Exception;
	
	public void removeCategory(int cateNo) throws Exception;
	
	public void updateProdCategoryNull(int cateNo) throws Exception;
	
	public List getProdNameList(String prodName) throws Exception;
	
}
