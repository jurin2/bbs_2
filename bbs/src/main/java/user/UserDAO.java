package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs; 
	
	/* DB접근 */
	public UserDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/bbs"; //mysql 위치
			String dbID="root"; // mysql ID
			String dbPassword="root"; // mysql Password
			Class.forName("com.mysql.cj.jdbc.Driver"); // 접속 드라이버
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword); // DB연결정보
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	
	/* 로그인 */
	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM user WHERE userID=?";
		try {
			pstmt=conn.prepareStatement(SQL); // DB에서 SQL실행준비
			pstmt.setString(1, userID);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1;
				}else {
					return -1;
				}
			}else {
				return -2;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -3;
	}
	
	/* 회원가입 */
	public int join(String userID, String userPassword, String userName, String userGender, String userEmail) {
		String SQL = "INSERT INTO user VALUES(?,?,?,?,?)";
		try {
			pstmt=conn.prepareStatement(SQL); // DB에서 SQL실행준비
			pstmt.setString(1, userID);
			pstmt.setString(2, userPassword);
			pstmt.setString(3, userName);
			pstmt.setString(4, userGender);
			pstmt.setString(5, userEmail);
			
			return pstmt.executeUpdate(); // executeUpdate : 변경, executeQuery : 선택
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -3;
	}
	
	
}
