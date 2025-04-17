package model;
import java.sql.*;

import dto.Admin;

public class AdminDao {
	public Admin loginAdmin(String adminId, String adminPw) throws ClassNotFoundException, SQLException{
		Admin admin = null;
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook2","root","java1234");
		PreparedStatement stmt = null;
		String sql = "select * FROM admin where admin_id = ? and admin_pw = ?";
		stmt=conn.prepareStatement(sql);
		stmt.setString(1, adminId);
		stmt.setString(2, adminPw);
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            admin = new Admin();
            admin.setAdmin_id(rs.getString("admin_id"));
            admin.setAdmin_pw(rs.getString("admin_pw"));
        }
        return admin;
	}
	
    // 비밀번호 변경
    public int updateAdminPw(String adminId, String currentPw, String newPw) throws ClassNotFoundException, SQLException {
    	Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook2","root","java1234");
    	String sql ="UPDATE admin SET admin_pw = ? WHERE admin_id = ? AND admin_pw = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, newPw);
        stmt.setString(2, adminId);
        stmt.setString(3, currentPw);

        int row = stmt.executeUpdate();
        return row;
    }
}
