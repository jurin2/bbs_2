package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import bbs.Bbs;

public class UserDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
		
	//		---------- DB접근 ----------  //
	public UserDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/bbs";//mysql 위치
			String dbID = "root";//mysql ID
			String dbPassword = "root";//mysql PASSWORD
			Class.forName("com.mysql.cj.jdbc.Driver");//접속 드라이버
			conn=DriverManager.getConnection(dbURL, dbID, dbPassword);//DB연결정보 및 연결
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	//     ----------------- 로그인 메소드 -----------------          //
	public int login(String userID,String userPassword) {
		String SQL = "SELECT userPassword FROM user WHERE userID=?";
		try {
			pstmt=conn.prepareStatement(SQL);//DB에서 SQL실행준비
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
		}catch (Exception e){
			e.printStackTrace();
		}
		return -3;
	}

	
//  ----------------- join(회원가입) 메소드 -----------------          //
	public int join(String userID,String userPassword,String userName,String userGender,String userEmail) {
		String SQL = "INSERT INTO user VALUES(?,?,?,?,?)";
		try {
			pstmt=conn.prepareStatement(SQL);//DB에서 SQL실행준비
			pstmt.setString(1, userID);
			pstmt.setString(2, userPassword);
			pstmt.setString(3, userName);
			pstmt.setString(4, userGender);
			pstmt.setString(5, userEmail);			
			return pstmt.executeUpdate();//executeUpdate => 변경,executeQuery => 검색			
		}catch (Exception e){
			e.printStackTrace();
		}
		return -1;
	}
	
	
	//회원정보 읽기
	public User getUser(String userID) {
		String SQL = "SELECT * FROM user WHERE userID = ?";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1,userID);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				User user = new User();
				user.setUserID(rs.getString(1));
				user.setUserPassword(rs.getString(2));
				user.setUserName(rs.getString(3));
				user.setUserGender(rs.getString(4));
				user.setUserEmail(rs.getString(5));					
				return user;
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return null;
		
	}
	
	// 회원탈퇴
	public int deleteUser(String userID,String userPassword) {
		String SQL = "DELETE FROM user WHERE userID=? AND userPassword=?";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1,userID);
			pstmt.setString(2,userPassword);
			return pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	
}