package model.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Vector;

import model.RentDao;


public class RentDaoImpl implements RentDao {
	//멤버변수
	final static String DRIVER 	="oracle.jdbc.driver.OracleDriver";		//회사에 들어가면 상수로 설정할 것이다.(final static 붙여서, 또한 변수명은 눈에 띄게 대문자로)
	final static String URL 	="jdbc:oracle:thin:@192.168.0.26:1521";
	final static String USER 	="scott";
	final static String PASS 	="tiger";


	public RentDaoImpl() throws Exception{
		// 1. 드라이버로딩
		Class.forName(DRIVER);
		System.out.println("드라이버로딩 성공");
	}
	/* 함수명 : rentVideo
	 * 인자 : String tel, int vNum
	 * 리턴값 : void
	 * 역할 : 전화번호와 비디오 번호로 VIDEO 대여 정보 입력 */
	public void rentVideo(String tel, int vNum) throws Exception {
		//연결객체얻어오기
		Connection con=null;
		//PreparedStatement 객체 생성 및 인자 지정
		PreparedStatement ps = null;
		con = DriverManager.getConnection(URL, USER, PASS);
		//SQL문
		String sql = "INSERT INTO RENT(RENTNO, VIDEONO, CUSTTEL1, BORROWDAY, RETURN ) VALUES(seq_rent_no.NEXTVAL,?,?,SYSDATE,'N')";
		//전송객체 얻어오기
		ps = con.prepareStatement(sql);
		//값 세팅
		ps.setInt(1,vNum);
		ps.setString(2,tel);
		// 5. sql 전송
		ps.executeUpdate();
	}//end of rentVideo

	/* 함수명 : returnVideo
	 * 인자 : int vNum(비디오번호)
	 * 리턴값 : void
	 * 역할 : 비디오 번호로 VIDEO 반납 정보 입력 */
	public void returnVideo(int vNum) throws Exception {
		//연결객체얻어오기
		Connection con=null;
		//PreparedStatement 객체 생성 및 인자 지정
		PreparedStatement ps = null;
		con = DriverManager.getConnection(URL, USER, PASS);
		//sql문 
		String sql = "UPDATE RENT SET RETURN='Y' WHERE VIDEONO=? AND RETURN ='N'";
		//전송객체 얻어오기
		ps = con.prepareStatement(sql);
		//값 세팅
		ps.setInt(1,vNum);
		//전송
		ps.executeUpdate();
	}//end of returnVideo

	/* 함수명 : selectList
	 * 인자 : 
	 * 리턴값 : ArrayList(비디오 정보: 번호, 제목,고객이름, 고객번호, 반납일, 반납여부)
	 * 역할 : 대여한 사람들 중에서 미납한 사람,비디오, 대여 정보를 출력*/
	public ArrayList selectList() throws Exception {
		ArrayList data = new ArrayList();
		//연결객체얻어오기
		Connection con=null;
		//PreparedStatement 객체 생성 및 인자 지정
		PreparedStatement ps = null;
		con = DriverManager.getConnection(URL, USER, PASS);
		//sql문장
		String sql= "SELECT v.videono VIDEONO, v.videoname VIDEONAME, c.custname CUSTOMERNAME, "
				+ " c.custtel1 CUSTOMERTEL, r.borrowday+3 RETURNDAY, r.return 미납"
				+ " FROM CUSTOMER c INNER JOIN RENT r "
				+ " ON c.custtel1=r.custtel1 "
				+ " INNER JOIN VIDEO v"
				+ " ON r.videono = v.videono "
				+ " WHERE r.return = 'N'";
		System.out.println(sql);
		//여기서 ?를 쓰면 ''이 붙는다. 
		//전송객체 얻어오기
		ps = con.prepareStatement(sql);	
		//전송(ResultSet에 저장)
		ResultSet rs = ps.executeQuery();
		//내용이 많기 때문에 반복문 형식으로 
		while(rs.next()) {//nextint 느낌으로 받아들이자
			ArrayList temp = new ArrayList();
			temp.add(rs.getString("VIDEONO"));
			temp.add(rs.getString("VIDEONAME"));
			temp.add(rs.getString("CUSTOMERNAME"));
			temp.add(rs.getString("CUSTOMERTEL"));
			temp.add(rs.getString("RETURNDAY"));
			temp.add(rs.getString("미납"));
			data.add(temp);//data에 추가하기
		}
		return data;//data에 있는 값들을 리턴

	}//end of selectList

	/* 함수명 : selectByTel
	 * 인자 : String tel(전화번호) 입력
	 * 리턴값 : String(이름)
	 * 역할 : 전화번호를 입력하면 고객이름을 출력*/
	public String selectByTel(String tel){
		//연결객체얻어오기
		Connection  con=null;
		//PreparedStatement 객체 생성 및 인자 지정
		PreparedStatement ps = null;
		//이름을 넣어줄 변수 생성
		String name =null;
		try {
			con = DriverManager.getConnection(URL, USER, PASS);
			//SQL문	
			String sql = "SELECT CUSTNAME FROM CUSTOMER WHERE CUSTTEL1=?";
			//전송객체 얻어오기
			ps = con.prepareStatement(sql);
			//값 세팅	
			ps.setString(1, tel);
			//전송	
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				name = rs.getString("CUSTNAME");
			}
		} catch (SQLException e){
		}return name;//이름으로 리턴
	}//end of selectByTel
}//end of RentDaoImpl
