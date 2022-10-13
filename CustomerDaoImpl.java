package model.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.CustomerDao;
import model.vo.CustomerVO;

public class CustomerDaoImpl implements CustomerDao{

	final static String DRIVER 	="oracle.jdbc.driver.OracleDriver";		//회사에 들어가면 상수로 설정할 것이다.(final static 붙여서, 또한 변수명은 눈에 띄게 대문자로)
	final static String URL 	="jdbc:oracle:thin:@192.168.0.26:1521";
	final static String USER 	="scott";
	final static String PASS 	="tiger";
	
	public CustomerDaoImpl() throws Exception{
	 	// 1. 드라이버로딩
		Class.forName(DRIVER);
		System.out.println("드라이버로딩 성공");
	}//end of CustomerDaoImpl
	
	/* 함수명 : insertCustomer
	 * 인자 : CustomerVO
	 * 리턴값 : void
	 * 역할 : 고객의 입력값을 받아서 DB에 저장하는 역할 */
	public void insertCustomer(CustomerVO vo) throws Exception{
		// 2. Connection 연결객체 얻어오기
		Connection con=null;
		PreparedStatement ps = null;
		try {
			con = DriverManager.getConnection(URL, USER, PASS);
		// 3. sql 문장 만들기
		String sql = "INSERT INTO CUSTOMER(CUSTNAME, CUSTTEL1, CUSTTEL2, CUSTADDR, CUSTEMAIL ) VALUES(?,?,?,?,?)";
		// 4. sql 전송객체 (PreparedStatement)	
		ps = con.prepareStatement(sql);
		//세팅
		ps.setString(1, vo.getCustName());
		ps.setString(2, vo.getCustTel1());
		ps.setString(3, vo.getCustTel2());
		ps.setString(4, vo.getCustAddr());
		ps.setString(5, vo.getCustEmail());

		// 5. sql 전송
		ps.executeUpdate();
		// 6. 닫기 
		}finally {//finally로 인해서 정상적이든 비정상적이든 무조건 닫아줌
			//6. 닫기(정상적이든 비정상적이든 무조건 닫아주기!!, 만약 안닫아주면 한정된 커넥션 갯수 때문에 딜레이 발생)
			ps.close();
			con.close();
		}
	}//end of insertCustomer
	
	/*
	 * 메소드명 : selectByTel
	 * 인자 : 검색할 전화번호
	 * 리턴값 : 전화번호 검색에 따른 고객정보
	 * 역할 : 사용자가 입력한 전화번호를 받아서 해당하는 고객정보를 리턴
	 */
	
	public CustomerVO selectByTel(String tel) throws Exception{
		//저장할 객체 생성
		CustomerVO dao = new CustomerVO();
		//2. 연결객체얻어오기
		Connection con=null;
		//PreparedStatement 객체 생성 및 인자 지정
		PreparedStatement ps = null;
		con = DriverManager.getConnection(URL, USER, PASS);
		//3.sql문장
		String sql ="SELECT *FROM CUSTOMER WHERE CUSTTEL1=?";
		//4. 전송객체 얻어오기
		ps = con.prepareStatement(sql);
		ps.setString(1, tel);
		ResultSet rs = ps.executeQuery();
		if(rs.next()) {
			dao.setCustName(rs.getString("CUSTNAME"));
			dao.setCustTel1(rs.getString("CUSTTEL1"));
			dao.setCustTel2(rs.getString("CUSTTEL2"));
			dao.setCustAddr(rs.getString("CUSTADDR"));
			dao.setCustEmail(rs.getString("CUSTEMAIL"));
		}
		return dao;// dao에 저장한 내용들을 리턴
	}//end of selectByTel
	
	/*
	 * 메소드명 : selectByName
	 * 인자 : 검색할 이름
	 * 리턴값 : 이름 검색에 따른 고객정보(CustomerVO)
	 * 역할 : 사용자가 입력한 이름을 받아서 해당하는 고객정보를 리턴
	 */
	public CustomerVO selectByName(String CustName) throws Exception{
		//내용 저장할 객체 생성
		CustomerVO dao = new CustomerVO();
		//2. 연결객체얻어오기
		Connection con=null;
		//PreparedStatement 객체 생성 및 인자 지정
		PreparedStatement ps = null;
		con = DriverManager.getConnection(URL, USER, PASS);
		//3.sql문장
		String sql ="SELECT *FROM CUSTOMER WHERE CUSTNAME=?";
		//4. 전송객체 얻어오기
		ps = con.prepareStatement(sql);
		//5.값 세팅
		ps.setString(1, CustName);
		ResultSet rs = ps.executeQuery();
		if(rs.next()) {
			dao.setCustName(rs.getString("CUSTNAME"));
			dao.setCustTel1(rs.getString("CUSTTEL1"));
			dao.setCustTel2(rs.getString("CUSTTEL2"));
			dao.setCustAddr(rs.getString("CUSTADDR"));
			dao.setCustEmail(rs.getString("CUSTEMAIL"));
		}
		return dao;//dao에 저장한 내용들을 리턴
	}//end of selectByName
	/*
	 * 메소드명 : updateCustomer
	 * 인자 : CustomerVO
	 * 리턴값 : 수정한 고객정보
	 * 역할 : 사용자가 입력한 전화번호를 받아서 해당하는 고객정보 수정해서 리턴
	 */
	public int updateCustomer(CustomerVO vo) throws Exception{
		int result = 0;//update는 int로 받기 때문에 리턴을 int값으로 받아야한다.
		//연결객체 얻어오기
		Connection con=null;
		PreparedStatement ps = null;
		try {
		con = DriverManager.getConnection(URL, USER, PASS);
		//sql문
		String sql ="UPDATE CUSTOMER SET CUSTNAME =?, CUSTTEL2=?,"
				+ "	CUSTADDR=?, CUSTEMAIL=?  WHERE CUSTTEL1=?";	

		//4. 전송객체 얻어오기
		ps = con.prepareStatement(sql);
		//세팅
		ps.setString(1, vo.getCustName());
		ps.setString(2, vo.getCustTel2());
		ps.setString(3, vo.getCustAddr());
		ps.setString(4, vo.getCustEmail());
		ps.setString(5, vo.getCustTel1());
		//5. 전송
		ps.executeUpdate();
		
	}finally {
			//6. 닫기
			ps.close();
			con.close();
		}return result;
	}//end of updateCustomer
}
