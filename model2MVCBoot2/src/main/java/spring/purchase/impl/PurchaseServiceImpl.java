package spring.purchase.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import spring.domain.Purchase;
import spring.files.FileService;
import spring.purchase.PurchaseDao;
import spring.purchase.PurchaseService;

@Service("purchaseServiceImpl")
public class PurchaseServiceImpl implements PurchaseService {

	@Autowired
	@Qualifier("purchaseDao")
	private PurchaseDao purchaseDao;
	
	@Autowired
	@Qualifier("fileServiceImpl")
	private FileService fileService;
	
	public void setPurchaseDao(PurchaseDao purchaseDao) {
		this.purchaseDao = purchaseDao;
	}

	public void setFileService(FileService fileService) {
		this.fileService = fileService;
	}
	
	public PurchaseServiceImpl() {
		// TODO Auto-generated constructor stub
		System.out.println("Default PurchaseServiceImpl Constructor call...");
	}

	@Override
	@Transactional
	public void addPurchase(Purchase purchase) {
		// TODO Auto-generated method stub
		purchaseDao.addPurchase(purchase);

	}

	@Override
	public Purchase getPurchase(int tranNo) {
		// TODO Auto-generated method stub
		return purchaseDao.getPurchase(tranNo);
	}

	@Override
	@Transactional
	public void updatePurchase(Purchase purchase) {
		// TODO Auto-generated method stub
		purchaseDao.updatePurchase(purchase);

	}

	@Override
	public Map<String, Object> getPurchaseList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		Map<String, Object> result = new HashMap<String, Object>();
		
		List<Purchase> list = purchaseDao.getPurchaseList(map);
		
		for(int i = 0; i < list.size(); i++) {
			list.get(i).setTranCode(list.get(i).getTranCode().trim());
			list.get(i).getPurchaseProd().setFiles(fileService.getFilesList(list.get(i).getPurchaseProd().getProdNo()));
		}
		
		int totalCount = purchaseDao.getTotalCount(map);
		System.out.println("totalCount : "+totalCount);
		
		result.put("list", list);
		result.put("Integer", new Integer(totalCount));
		
		return result;
	}

	@Override
	@Transactional
	public void updateTranCode(int tranNo) {
		// TODO Auto-generated method stub
		purchaseDao.updateTranCode(tranNo);

	}

	@Override
	@Transactional
	public void updateTranCodeByProdAction(int prodNo) {
		// TODO Auto-generated method stub
		purchaseDao.updateTranCodeByProdAction(prodNo);

	}

}
