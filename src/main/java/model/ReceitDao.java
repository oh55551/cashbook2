package model;

import java.sql.*;
import java.util.*;
import dto.*;

public class ReceitDao {
	public Receit selectReceitByCashNo(int cashNo) throws Exception {
	    Receit r = null;
	    Class.forName("com.mysql.cj.jdbc.Driver");
	    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook2", "root", "java1234");
	    String sql = "SELECT filename, createdate FROM receit WHERE cash_no = ?";
	    PreparedStatement stmt = conn.prepareStatement(sql);
	    stmt.setInt(1, cashNo);
	    ResultSet rs = stmt.executeQuery();
	    if (rs.next()) {
	        r = new Receit();
	        r.setCash_no(cashNo);
	        r.setFilename(rs.getString("filename"));
	        r.setCreatedate(rs.getString("createdate"));
	    }
	    conn.close();
	    return r;
	}
	
	public void deleteImage(int num) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook2","root","java1234");
		String sql = "delete from receit where cash_no = ?";
		
		stmt= conn.prepareStatement(sql); // 
		stmt.setInt(1, num);
		int row = stmt.executeUpdate();
		
		conn.close();		
	}
	
	public ArrayList<Receit> selectImageList(Paging p) throws ClassNotFoundException, SQLException {
		ArrayList<Receit> list = new ArrayList<Receit>();
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook2","root","java1234");
		String sql = "select * from receit order by num desc limit ?, ?";
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, p.getBeginRow());
		stmt.setInt(2, p.getRowPerPage());
		rs = stmt.executeQuery();
		while(rs.next()) {
			Receit r = new Receit();
			r.setCash_no(rs.getInt("cash_no"));
			r.setFilename(rs.getString("filename"));
			r.setCreatedate(rs.getString("createdate"));
			list.add(r);
		}
		conn.close();
		return list;
	}
	
	public void insertImage(Receit r) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook2","root","java1234");
		String sql = "insert IGNORE into receit(cash_no, filename, createdate) values(?, ?, now())";
		
		stmt= conn.prepareStatement(sql); // 
		stmt.setInt(1, r.getCash_no());
		stmt.setString(2, r.getFilename());
		int row = stmt.executeUpdate();
		
		conn.close();		
	}
}
