package dto;
//import java.lang.*; 자동으로붙음

public class Category{ //extends Object{ 가 자동으로붙음 아무것도없으면
	//public Category(){
	//	super(); //Obejct();
	// new생성자 : new heap 영역에 this 필드를 생성하고 초기화
	//	this.category_no = 0;
	//	this.kind=null;
	//	this.title=null;
	//	this.createdate=null;
	//}자동으로생김
	private int category_no;
	private String kind;
	private String title;
	private String createdate;
	public int getCategory_no() {
		return category_no;
	}
	public void setCategory_no(int category_no) {
		this.category_no = category_no;
	}
	public String getKind() {
		return kind;
	}
	public void setKind(String kind) {
		this.kind = kind;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	public String toString() {
		return "Category [category_no=" + category_no + ", kind=" + kind + ", title=" + title + ", createdate="
				+ createdate + "]";
	}
	
}
