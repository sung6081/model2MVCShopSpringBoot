package spring.common;

public class Category {

	//Field
	private int cateNo;
	private String cateName;
	
	//Constructor
	public Category() {}

	public int getCateNo() {
		return cateNo;
	}

	public void setCateNo(int cateNo) {
		this.cateNo = cateNo;
	}

	public String getCateName() {
		return cateName;
	}

	public void setCateName(String cateName) {
		this.cateName = cateName;
	}

	@Override
	public String toString() {
		return "Category [cateNo=" + cateNo + ", cateName=" + cateName + "]";
	}
	
}//end of class
