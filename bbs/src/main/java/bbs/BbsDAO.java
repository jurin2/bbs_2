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
		
	//		---------- DB���� ----------  //
	public BbsDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/bbs";//mysql ��ġ
			String dbID = "root";//mysql ID
			String dbPassword = "root";//mysql PASSWORD
			Class.forName("com.mysql.cj.jdbc.Driver");//���� ����̹�
			conn=DriverManager.getConnection(dbURL, dbID, dbPassword);//DB�������� �� ����
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//���� ��¥ ���ϱ�
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
	
	//������ �� ������ȣ ���ϱ�
	public int getNext() {
		String SQL = "SELECT bbsID FROM bbs WHERE bbsAvailable=1 ORDER BY bbsID DESC";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;//������ȣ
			}else {
				return 1;//���۹�ȣ
			}			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1;//������ȣ
	}
	
	//������ �޼ҵ�
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
		return -1;//�����ͺ��̽� ����
	}
	//record count
	//public int rCount() {
	//	String sql = "select * from bbs where bbsAvailable = 1";
	//	try {
	//		PreparedStatement pstmt = conn.prepareStatement(sql);
	//		rs = pstmt.executeQuery();
	//		int cnt=1;
	//		while(rs.next()) {
	//			cnt++;
	//		}
	//		return cnt;
	//	}catch (Exception e) {
	//		e.printStackTrace();
	//	}
	//	return -1;
	//}
	
	//bbs��� �������� �޼ҵ�
	public ArrayList<Bbs> getList(int pageNumber){
		String SQL = "SELECT * FROM bbs WHERE bbsID<? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10";
              //String sql = "select * from bbs where bbsAvailable = 1 order by bbsID desc limit ?,10";
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber-1)*10);
	              //pstmt.setInt(1,rCount()-(rCount()-(pageNumber -1)*10));
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
	
	
	//������ ó�� �޼���
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM bbs WHERE bbsID<? AND bbsAvailable = 1";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber-1)*10);
		      //pstmt.setInt(1, rCount() - (pageNumber-1)*10);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	//������ ������ ��ȣ �޼���
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
	
	//���� �б�
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
	
	
	//�ۼ��� �޼ҵ�
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
		return -1;//�����ͺ��̽� ����
	}
	
	//����¥ ���� �޼ҵ�
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
		return -1;//�����ͺ��̽� ����
	}
	
	//�۰�¥ ���� �޼ҵ�
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
		return -1;//�����ͺ��̽� ����
	}
	
	
}