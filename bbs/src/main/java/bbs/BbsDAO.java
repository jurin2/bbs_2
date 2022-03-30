package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
		
	//		---------- DB접근 ----------  //
	public BbsDAO() {
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
	
	//오늘 날짜 구하기
	public String getDate() {
		String SQL = "SELECT DATE(NOW())";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}			
		}catch (Exception e) {
			e.printStackTrace();
			
		}
		return "";
	}
	
	//다음에 들어갈 문서번호 구하기
	public int getNext() {
		String SQL = "SELECT bbsID FROM bbs ORDER BY bbsID DESC";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;//다음번호
			}else {
				return 1;//시작번호
			}			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1;//오류번호
	}
	
	//글저장 메소드
	public int write(String bbsTitle,String userID,String bbsContent) {
		String SQL = "INSERT INTO bbs VALUES(?,?,?,?,?,?)";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, bbsTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, bbsContent);
			pstmt.setInt(6, 1);
			return pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1;//데이터베이스 오류
	}
	
	//레코드의 개수
	public int recordCount() {
		String SQL = "SELECT * FROM bbs WHERE bbsAvailable=1";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);				
			rs=pstmt.executeQuery();
			int recordCount = 1;
			while(rs.next()) {
				recordCount++;
			}
			return recordCount;
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	
	//bbs목록 가져오기 메소드
	public ArrayList<Bbs> getList(int pageNumber){
		//String SQL = "SELECT * FROM bbs WHERE bbsID<? AND bbsAvailable = 1";
		String SQL = "SELECT * FROM bbs WHERE bbsAvailable = 1 ORDER BY bbsID DESC LIMIT ?,10";                        
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			//pstmt.setInt(1, getNext() - (pageNumber-1)*10);
			pstmt.setInt(1, recordCount() - (recordCount()-(pageNumber-1)*10));
			rs=pstmt.executeQuery();
			while(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				list.add(bbs);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	
	//페이지 처리 메서드
	public boolean nextPage(int pageNumber) {
		//String SQL = "SELECT * FROM bbs WHERE bbsID<? AND bbsAvailable = 1";
		String SQL = "SELECT * FROM bbs WHERE bbsAvailable = 1 ORDER BY bbsID DESC LIMIT ?,10";
		
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			//pstmt.setInt(1, getNext() - (pageNumber-1)*10);
			pstmt.setInt(1, recordCount() - (recordCount()-(pageNumber-1)*10));
			rs=pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	//마지막 페이지 번호 메서드
		public int getPages() {
			String SQL = "SELECT * FROM bbs WHERE bbsAvailable=1";
			try {
				PreparedStatement pstmt=conn.prepareStatement(SQL);				
				rs=pstmt.executeQuery();
				int recordCount = 0;
				while(rs.next()) {
					recordCount++;
				}
				return (recordCount-1) / 10 + 1;
			}catch(Exception e) {
				e.printStackTrace();
			}
			return -1;
		}
	
	//문서 읽기
	public Bbs getBbs(int bbsID) {
		String SQL = "SELECT * FROM bbs WHERE bbsID = ?";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1,bbsID);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				return bbs;
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return null;
		
	}
	
	
	//글수정 메소드
	public int update(String bbsTitle,String userID,String bbsContent,int bbsID) {
		String SQL = "UPDATE bbs SET bbsTitle=?,bbsContent=? WHERE userID=? AND bbsID=?";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, bbsTitle);
			pstmt.setString(2, bbsContent);
			pstmt.setString(3, userID);
			pstmt.setInt(4, bbsID);
			return pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1;//데이터베이스 오류
	}
	
	//글진짜 삭제 메소드
	public int delete(String userID,int bbsID) {
		String SQL = "DELETE FROM bbs WHERE bbsID=? AND userID=?";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			pstmt.setString(2, userID);			
			return pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1;//데이터베이스 오류
	}
	
	//글가짜 삭제 메소드
	public int delete2(String userID,int bbsID) {
		String SQL = "UPDATE bbs SET bbsAvailable = 0 WHERE bbsID=? AND userID=?";
		try {
			
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			pstmt.setString(2, userID);			
			return pstmt.executeUpdate();			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1;//데이터베이스 오류
	}
	
	
}