package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;

import dto.*;

public class CategoryDao {
	
	public ArrayList<Category> selectCategoryListByKind(String kind) throws Exception {
	    ArrayList<Category> list = new ArrayList<>();
	    
	    Class.forName("com.mysql.cj.jdbc.Driver");
	    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");

	    String sql = "SELECT category_no, title FROM category where kind=?";
	    PreparedStatement stmt = conn.prepareStatement(sql);
	    stmt.setString(1, kind);

	    ResultSet rs = stmt.executeQuery();
	    while (rs.next()) {
	        Category c = new Category();
	        c.setCategory_no(rs.getInt("category_no"));
	        c.setTitle(rs.getString("title"));
	        list.add(c);
	    }
	    conn.close();
	    return list;
	}
	
	//updateTitle
	public int updateCategoryTitle(int categoryNo, String newTitle) throws Exception {
	    Class.forName("com.mysql.cj.jdbc.Driver");
	    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		
	    //같은값 못넣게하기
		String sql2 = "SELECT COUNT(*) FROM category WHERE title = ?";
	    PreparedStatement Stmt2 = conn.prepareStatement(sql2);
	    Stmt2.setString(1, newTitle);
	    ResultSet rs2 = Stmt2.executeQuery();
	    rs2.next();
	    int count = rs2.getInt(1);
	    if (count > 0) {
	        conn.close();
	        return 0; // 0이면 insert 안 됐다고 처리
	    }
	    
	    String sql = "UPDATE category SET title = ? WHERE category_no = ?";
	    PreparedStatement stmt = conn.prepareStatement(sql);
	    stmt.setString(1, newTitle);
	    stmt.setInt(2, categoryNo);
	    int row = stmt.executeUpdate();
	    conn.close();
	    return row;
	}
	
	//delete
	public int deleteCategory(int categoryNo) throws ClassNotFoundException, SQLException {
	    int row = 0;
	    Class.forName("com.mysql.cj.jdbc.Driver");
	    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
	    String sql = "DELETE FROM category WHERE category_no = ?";
	    PreparedStatement stmt = conn.prepareStatement(sql);
	    stmt.setInt(1, categoryNo);
	    row = stmt.executeUpdate();
	    conn.close();
	    return row;
	}
	
	//insert
	public int insertCategory(Category category) throws ClassNotFoundException, SQLException{
		int pk=0;
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook","root","java1234");
		PreparedStatement stmt = null;
		
		//같은값 못넣게하기
		String sql2 = "SELECT COUNT(*) FROM category WHERE title = ? and kind = ?";
	    PreparedStatement Stmt2 = conn.prepareStatement(sql2);
	    Stmt2.setString(1, category.getTitle());
	    Stmt2.setString(2, category.getKind());
	    ResultSet rs2 = Stmt2.executeQuery();
	    rs2.next();
	    int count = rs2.getInt(1);
	    if (count > 0) {
	        conn.close();
	        return 0; // 0이면 insert 안 됐다고 처리
	    }
	    
		String sql = "insert into category(kind, title, createdate) values(?,?,?)";
		stmt=conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
		stmt.setString(1, category.getKind());
		stmt.setString(2, category.getTitle());
		stmt.setString(3, category.getCreatedate());
		int row = stmt.executeUpdate();	
		   if (row == 1) {
		        ResultSet rs = stmt.getGeneratedKeys(); 
		        if (rs.next()) {
		            pk = rs.getInt(1); // category_no
		        }
		        rs.close();
		    }

		  return pk;
	}
	
	//select
	public ArrayList<HashMap<String,Object>> selectCategory() throws ClassNotFoundException, SQLException{
		ArrayList<HashMap<String, Object>> list = new ArrayList<>();
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook","root","java1234");
		PreparedStatement stmt = null;
		String sql = "select * FROM category ORDER BY category_no DESC";
		stmt=conn.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
        	HashMap<String,Object> c = new HashMap<String, Object>();
        	c.put("category_no", rs.getInt("category_no"));
        	c.put("kind", rs.getString("kind"));
        	c.put("title", rs.getString("title"));
        	c.put("createdate", rs.getString("createdate"));
        	list.add(c);
        }
        conn.close();
        return list;
	}
	
	//페이징
	public ArrayList<Category> selectCategoryList(Paging p) throws Exception {
	    ArrayList<Category> list = new ArrayList<>();
	    
	    Class.forName("com.mysql.cj.jdbc.Driver");
	    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");

	    String sql = "SELECT category_no, kind, title, createdate FROM category ORDER BY category_no DESC LIMIT ?, ?";
	    PreparedStatement stmt = conn.prepareStatement(sql);
	    stmt.setInt(1, p.getBeginRow());
	    stmt.setInt(2, p.getRowPerPage());

	    ResultSet rs = stmt.executeQuery();
	    while (rs.next()) {
	        Category c = new Category();
	        c.setCategory_no(rs.getInt("category_no"));
	        c.setKind(rs.getString("kind"));
	        c.setTitle(rs.getString("title"));
	        c.setCreatedate(rs.getString("createdate"));
	        list.add(c);
	    }
	    conn.close();
	    return list;
	}
}
