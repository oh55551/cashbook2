package model;

import java.sql.*;
import java.util.*;
import dto.*;

public class CashDao {
	public boolean hasReceit(int cashNo) throws Exception {
	    Class.forName("com.mysql.cj.jdbc.Driver");
	    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook2", "root", "java1234");

	    String sql = "SELECT COUNT(*) FROM receit WHERE cash_no = ?";
	    PreparedStatement stmt = conn.prepareStatement(sql);
	    stmt.setInt(1, cashNo);
	    ResultSet rs = stmt.executeQuery();

	    boolean result = false;
	    if (rs.next()) {
	        result = rs.getInt(1) > 0; // 1 이상이면 true
	    }

	    conn.close();
	    return result;
	}
	
	public ArrayList<HashMap<String, Object>> cashAmountBySelect(int year, int month) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<>();
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook2", "root", "java1234");

		String sql = "SELECT kind, COUNT(*) as cnt , SUM(amount) as sumAmount "
				+ "	 FROM category ct INNER JOIN cash cs "
				+ "	 ON ct.category_no = cs.category_no "
				+ "	 WHERE YEAR(cash_date) = ? AND MONTH(cash_date) = ? "
				+ "	 GROUP BY month(cash_date), ct.kind "
				+ "	 ORDER BY month(cash_date)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, year);
		stmt.setInt(2, month);
		ResultSet rs = stmt.executeQuery();

		while (rs.next()) {
		    HashMap<String, Object> map = new HashMap<>();
		    map.put("kind", rs.getString("kind"));
		    map.put("cnt", rs.getInt("cnt"));
		    map.put("sumAmount", rs.getInt("sumAmount"));
		    list.add(map);
		}

		conn.close();
		return list;
	}
	
	
	public ArrayList<HashMap<String, Object>> cashAmountByMonth(int month) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<>();
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook2", "root", "java1234");

		String sql = "SELECT month(cash_date), kind, COUNT(*) as cnt , SUM(amount) as sumAmount "
				+ "	 FROM category ct INNER JOIN cash cs "
				+ "	 ON ct.category_no = cs.category_no "
				+ "  where month(cash_date) = ? "
				+ "	 GROUP BY month(cash_date), ct.kind "
				+ "	 ORDER BY month(cash_date)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, month);
		ResultSet rs = stmt.executeQuery();

		while (rs.next()) {
		    HashMap<String, Object> map = new HashMap<>();
		    map.put("kind", rs.getString("kind"));
		    map.put("cnt", rs.getInt("cnt"));
		    map.put("sumAmount", rs.getInt("sumAmount"));
		    list.add(map);
		}

		conn.close();
		return list;
	}
	
	
	public ArrayList<HashMap<String, Object>> cashAmountByYear(int year) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<>();
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook2", "root", "java1234");

		String sql = "SELECT year(cash_date), kind, COUNT(*) as cnt , SUM(amount) as sumAmount "
				+ "	 FROM category ct INNER JOIN cash cs "
				+ "	 ON ct.category_no = cs.category_no "
				+ "  where year(cash_date) = ? "
				+ "	 GROUP BY year(cash_date), ct.kind "
				+ "	 ORDER BY year(cash_date) asc";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, year);
		ResultSet rs = stmt.executeQuery();

		while (rs.next()) {
		    HashMap<String, Object> map = new HashMap<>();
		    map.put("kind", rs.getString("kind"));
		    map.put("cnt", rs.getInt("cnt"));
		    map.put("sumAmount", rs.getInt("sumAmount"));
		    list.add(map);
		}

		conn.close();
		return list;
	}
	
	public ArrayList<HashMap<String, Object>> cashAmount() throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<>();
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook2", "root", "java1234");

		String sql = "SELECT kind, COUNT(*) AS cnt, SUM(amount) AS sumAmount " +
		             "FROM category ct INNER JOIN cash cs ON ct.category_no = cs.category_no " +
		             "GROUP BY ct.kind";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();

		while (rs.next()) {
		    HashMap<String, Object> map = new HashMap<>();
		    map.put("kind", rs.getString("kind"));
		    map.put("cnt", rs.getInt("cnt"));
		    map.put("sumAmount", rs.getInt("sumAmount"));
		    list.add(map);
		}

		conn.close();
		return list;
	}
	
	public HashMap<String, Object> cashOneByNo(int cashNo) throws Exception{
		HashMap<String, Object> map = new HashMap<String, Object>();
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook2", "root", "java1234");
		String sql = "SELECT ct.kind, ct.title, c.amount, c.memo, c.createdate, c.color, c.updatedate, c.category_no, c.cash_no " +
                "FROM cash c " +
                "INNER JOIN category ct ON c.category_no = ct.category_no " +
                "WHERE c.cash_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cashNo);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			map.put("cash_no", rs.getInt("cash_no")); 
	        map.put("category_no", rs.getInt("category_no"));
	        map.put("kind", rs.getString("kind"));
	        map.put("title", rs.getString("title"));
	        map.put("amount", rs.getInt("amount"));
	        map.put("memo", rs.getString("memo"));
	        map.put("color", rs.getString("color"));
	        map.put("createdate", rs.getString("createdate"));
	        map.put("updatedate", rs.getString("updatedate"));
		}
		return map;	
	}
	
	public int updateCash(Cash c, String kind, String title) throws Exception{
		Class.forName("com.mysql.cj.jdbc.Driver");
	    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook2", "root", "java1234");
	    String sql = "update cash set updatedate = now(), category_no = ?, amount = ?, memo = ?, color = ? where cash_no = ?";
	    PreparedStatement stmt = conn.prepareStatement(sql);
	    stmt.setInt(1, c.getCategory_no());
		stmt.setInt(2, c.getAmount());
		stmt.setString(3, c.getMemo());
		stmt.setString(4, c.getColor());
		stmt.setInt(5, c.getCash_no());
	    int row = stmt.executeUpdate();
	    
	    String sql2 = "update category set kind = ?, title = ? where category_no = ?";
	    PreparedStatement stmt2 = conn.prepareStatement(sql2);
	    stmt2.setString(1, kind);
		stmt2.setString(2, title);
		stmt2.setInt(3, c.getCategory_no());
	    int row2 = stmt2.executeUpdate();
		
	    conn.close();
		return row+row2;
	}
	
	public int deleteCash(int cash_no) throws Exception{
		int row = 0;
	    Class.forName("com.mysql.cj.jdbc.Driver");
	    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook2", "root", "java1234");
	    String sql = "DELETE FROM cash WHERE cash_no = ?";
	    PreparedStatement stmt = conn.prepareStatement(sql);
	    stmt.setInt(1, cash_no);
	    row = stmt.executeUpdate();
	    conn.close();
	    return row;
	}
	
	public HashMap<String, Object> insertCashAndGetCategory(Cash cash) throws Exception {
	    HashMap<String, Object> map = new HashMap<>();

	    Class.forName("com.mysql.cj.jdbc.Driver");
	    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook2", "root", "java1234");

	    // 1. cash insert
	    String insertSql = "INSERT INTO cash (category_no, cash_date, amount, memo, color) VALUES (?, ?, ?, ?, ?)";
	    PreparedStatement insertStmt = conn.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS);
	    insertStmt.setInt(1, cash.getCategory_no());
	    insertStmt.setString(2, cash.getCash_date());
	    insertStmt.setInt(3, cash.getAmount());
	    insertStmt.setString(4, cash.getMemo());
	    insertStmt.setString(5, cash.getColor());
	    insertStmt.executeUpdate();

	    // 2. category 정보 조회
	    Category category = null;
	    String selectSql = "INSERT INTO category (kind, title) VALUES (?, ?)";
	    PreparedStatement selectStmt = conn.prepareStatement(selectSql);
	    selectStmt.setString(1, category.getKind());
	    selectStmt.setString(1, category.getTitle());
	    int row = selectStmt.executeUpdate();

	    conn.close();
	    return map;
	}
	
	public int insertCash(Cash cash) throws Exception {
	    Class.forName("com.mysql.cj.jdbc.Driver");
	    Connection conn = DriverManager.getConnection(
	        "jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
	    String sql = "INSERT INTO cash (category_no, cash_date, amount, memo, color, createdate, updatedate) " +
	                 "VALUES (?, ?, ?, ?, ?, NOW(), NOW())";
	    PreparedStatement stmt = conn.prepareStatement(sql);
	    stmt.setInt(1, cash.getCategory_no());
	    stmt.setString(2, cash.getCash_date());
	    stmt.setInt(3, cash.getAmount());
	    stmt.setString(4, cash.getMemo());
	    stmt.setString(5, cash.getColor());
	    int row = stmt.executeUpdate();
	    conn.close();
	    return row;
	}
	
	public ArrayList<HashMap<String, Object>> selectCashListByDate(String date) throws Exception {
	    ArrayList<HashMap<String, Object>> list = new ArrayList<>();
	    Class.forName("com.mysql.cj.jdbc.Driver");
	    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook2", "root", "java1234");

	    String sql = "SELECT ct.kind, ct.title, c.amount, c.createdate, c.cash_no " +
	                 "FROM cash c " +
	                 "INNER JOIN category ct ON c.category_no = ct.category_no " +
	                 "WHERE DATE(c.cash_date) = ?";
	    PreparedStatement stmt = conn.prepareStatement(sql);
	    stmt.setString(1, date);
	    ResultSet rs = stmt.executeQuery();

	    while (rs.next()) {
	        HashMap<String, Object> map = new HashMap<>();
	        map.put("kind", rs.getString("kind"));
	        map.put("title", rs.getString("title"));
	        map.put("amount", rs.getInt("amount"));
	        map.put("createdate", rs.getString("createdate"));
	        map.put("cash_no", rs.getInt("cash_no"));
	        list.add(map);
	    }

	    conn.close();
	    return list;
	}
	
	public HashMap<Integer, ArrayList<HashMap<String, Object>>> selectCashListMonth(int year, int month) throws ClassNotFoundException, SQLException{
		HashMap<Integer, ArrayList<HashMap<String,Object>>> list = new HashMap<>();
		//Integer : 날짜(날짜별로 묶기위해 또한번 hashMap)
		//ArrayList : 그 날짜안의 cash데이터들(hashmap으로 만들어낸 cash들이 여러개있을수있으니)
		//HashMap : cash 하나의 정보
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook2","root","java1234");
		String sql = "SELECT "
				+ "c.cash_no, "
				+ "c.category_no, "
				+ "c.cash_date, "
				+ "c.amount, "
				+ "c.memo, "
				+ "c.color, "
				+ "ct.title, "
				+ "ct.kind, "
				+ "ct.createdate "
				+ "FROM cash c "
				+ "INNER JOIN category ct "
				+ "ON c.category_no = ct.category_no WHERE YEAR(cash_date) = ? AND MONTH(cash_date) = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, year);
	    stmt.setInt(2, month+1);
		rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> c = new HashMap<String, Object>();
			c.put("cash_no", rs.getInt("cash_no"));
			c.put("category_no", rs.getInt("category_no"));
			c.put("cash_date", rs.getString("cash_date"));
			c.put("amount", rs.getInt("amount"));
			c.put("memo", rs.getString("memo"));
			c.put("color", rs.getString("color"));
			c.put("category_title", rs.getString("title"));
			c.put("category_kind", rs.getString("kind"));
			int day = Integer.parseInt(rs.getString("cash_date").substring(8, 10));
			list.computeIfAbsent(day, k -> new ArrayList<>()).add(c);
		}
		conn.close();
		return list;
	}
	
	public ArrayList<HashMap<String, Object>> selectCashList(int cash_no) throws ClassNotFoundException, SQLException{
		ArrayList<HashMap<String,Object>> list = new ArrayList<>();
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM cash where cash_no=?";
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook2","root","java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cash_no);
		rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> c = new HashMap<String, Object>();
			c.put("category_no", rs.getInt("category_no"));
			c.put("cash_date", rs.getString("cash_date"));
			c.put("amount", rs.getInt("amount"));
			c.put("memo", rs.getString("memo"));
			c.put("color", rs.getString("color"));
			c.put("createdate", rs.getString("createdate"));
			c.put("updatedate", rs.getString("updatedate"));
			list.add(c);
		}
		conn.close();
		return list;
	}
}
