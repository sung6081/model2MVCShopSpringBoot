package spring.product.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import spring.common.Category;
import spring.common.Search;
import spring.domain.File;
import spring.domain.Product;
import spring.files.FileDao;
import spring.files.FileService;
import spring.files.impl.FileServiceImpl;
import spring.product.ProductDao;
import spring.product.ProductService;

@Service("productServiceImpl")
public class ProductServiceImpl implements ProductService {

	@Autowired
	@Qualifier("productDao")
	private ProductDao productDao;
	
	@Autowired
	@Qualifier("fileServiceImpl")
	private FileService fileService;
	
	public void setProductDao(ProductDao productDao) {
		this.productDao = productDao;
	}

	public void setFileService(FileService fileService) {
		this.fileService = fileService;
	}

	public ProductServiceImpl() {
		// TODO Auto-generated constructor stub
		System.out.println("default ProductServiceImpl Constructor call...");
	}

	@Override
	@Transactional
	public int addProduct(Product product) throws Exception {
		// TODO Auto-generated method stub
		return productDao.addProduct(product);

	}

	@Override
	public Product getProduct(int prodNo) throws Exception {
		// TODO Auto-generated method stub
		Product product = productDao.getProduct(prodNo);
		List<File> files = fileService.getFilesList(prodNo);
		
		product.setFiles(files);
		
		return product;
	}

	@Override
	public Map<String, Object> getProductList(Search search) throws Exception {
		// TODO Auto-generated method stub
		List<Product> list = productDao.getProductList(search);
		List<Category> listCategory = productDao.getCategoryList();
		
		System.out.println("dao categoryList : "+listCategory);
		
		for(int i = 0; i < list.size(); i++) {
			
			List<File> files = fileService.getFilesList(list.get(i).getProdNo());
			list.get(i).setFiles(files);
			
			if(list.get(i).getProTranCode() != null)
				list.get(i).setProTranCode(list.get(i).getProTranCode().trim());
		}
		
		int totalCount = productDao.getTotalCount(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("listCategory", listCategory);
		map.put("totalCount", new Integer(totalCount));
		System.out.println("totalCount in service : "+totalCount);
		
		return map;
	}

	@Override
	@Transactional
	public void updateProduct(Product product) throws Exception {
		// TODO Auto-generated method stub
		productDao.updateProduct(product);

	}

	@Override
	@Transactional
	public void addCategory(String cateName) throws Exception {
		// TODO Auto-generated method stub
		productDao.addCategory(cateName);
	}
	
	@Override
	public List<Category> getCategoryList() throws Exception {
		// TODO Auto-generated method stub
		return productDao.getCategoryList();
	}

	@Override
	@Transactional
	public void removeCategory(int cateNo) throws Exception {
		// TODO Auto-generated method stub
		productDao.removeCategory(cateNo);
	}

	@Override
	@Transactional
	public void updateProdCategoryNull(int cateNo) throws Exception {
		// TODO Auto-generated method stub
		productDao.updateProdCategoryNull(cateNo);
	}

	@Override
	public List getProdNameList(String prodName) throws Exception {
		// TODO Auto-generated method stub
		return productDao.getProdNameList(prodName);
	}

}
