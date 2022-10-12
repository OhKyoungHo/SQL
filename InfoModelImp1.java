package c_info2;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class InfoModelImp1 implements InfoModel {

	final static String DRIVER 	="oracle.jdbc.driver.OracleDriver";		//회사에 들어가면 상수로 설정할 것이다.(final static 붙여서, 또한 변수명은 눈에 띄게 대문자로)
	final static String URL 	="jdbc:oracle:thin:@192.168.0.26:1521";
	final static String USER 	="scott";
	final static String PASS 	="tiger";
	//식을 나타낼때 간격 맞춰져서 해주기

	public InfoModelImp1() throws ClassNotFoundException {
		//1. 드라이버 로딩
		Class.forName(DRIVER);
		System.out.println("드라이버로딩 성공");
	}
	
	/* 함수명 : insertInfo
	 * 인자 : InfoVO 
	 * 리턴값 : void
	 * 역할 : 사용자 입력값을 받아서 DB에 저장하는 역할 */
	@Override
	public void insertInfo(InfoVO vo) throws SQLException{
		// 2. 연결객체 얻어오기
		Connection con=null;
		//PreparedStatement 객체 생성 및 인자 지정
		PreparedStatement ps = null;
		try {
			con = DriverManager.getConnection(URL, USER, PASS);

			//3.sql 문장
			String sql ="INSERT INTO info_tab(name, jumin, tel, gender, age, home)	"
					+ "VALUES(?,?,?,?,?,?)";
			//4. 전송객체
			ps = con.prepareStatement(sql);
			//세팅
			ps.setString(1, vo.getName());
			ps.setString(2, vo.getId());
			ps.setString(3, vo.getTel());
			ps.setString(4, vo.getGender());
			ps.setInt(5, vo.getAge());
			ps.setString(6, vo.getHome());

			//5. 전송
			ps.executeUpdate();


		}finally {//finally로 인해서 정상적이든 비정상적이든 무조건 닫아줌
			//6. 닫기(정상적이든 비정상적이든 무조건 닫아주기!!, 만약 안닫아주면 한정된 커넥션 갯수 때문에 딜레이 발생)
			ps.close();
			con.close();
		}
	}
	/* 함수명 : selectAll
	 * 인자 : <InfoVO> 
	 * 리턴값 : ArrayList
	 * 역할 : 전체 Info_tab 의 레코드 검색 */

	@Override
	public ArrayList<InfoVO> selectAll() throws SQLException {
		// 2. 연결객체 얻어오기
		Connection con=null;
		//PreparedStatement 객체 생성 및 인자 지정
		PreparedStatement ps = null;
		//ResultSet 객체 생성 및 인자 지정
		ResultSet rs = null;
		try {
			con = DriverManager.getConnection(URL, USER, PASS);
			//3.sql 문장
			String sql ="SELECT *FROM info_tab";

			//4. 전송객체 얻어오기
			ps = con.prepareStatement(sql);

			//5. 전송
			//ResultSet에서 값을 읽어서 ArrayList에 저장
			rs = ps.executeQuery();

			ArrayList<InfoVO> list = new ArrayList<InfoVO>();
			//반복문 형태로 이용
			while(rs.next()) {		
				InfoVO vo = new InfoVO();
				vo.setName(rs.getString("NAME"));
				vo.setId(rs.getString("JUMIN"));
				vo.setTel(rs.getString("TEL"));
				vo.setGender(rs.getString("GENDER"));
				vo.setAge(rs.getInt("AGE"));
				vo.setHome(rs.getString("HOME"));

				list.add(vo);
			}//end of SelectAll

			return list; //list 값은 ArrayList<InfoVO>이다

		}finally {//finally로 인해서 정상적이든 비정상적이든 무조건 닫아줌
			//6. 닫기(정상적이든 비정상적이든 무조건 닫아주기!!, 만약 안닫아주면 한정된 커넥션 갯수 때문에 딜레이 발생)
			rs.close();
			ps.close();
			con.close();
		}

	}
	/* 함수명 : selectByTel
	 * 인자 : String tel
	 * 리턴값 : InfoVO
	 * 역할 : 전화번호로 Info_tab 의 레코드 검색 */
	
	@Override
	public InfoVO selectByTel(String tel) throws SQLException {
		// 2. 연결객체 얻어오기
		Connection con=null;
		//PreparedStatement 객체 생성 및 인자 지정
		PreparedStatement ps = null;
		InfoVO vo = new InfoVO();
		try {
			con = DriverManager.getConnection(URL, USER, PASS);
			//3.sql문장
			String sql ="SELECT *FROM info_tab WHERE tel=?";
			//4. 전송객체 얻어오기
			ps = con.prepareStatement(sql);
			ps.setString(1, tel);
			//5. 전송	
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				vo.setName(rs.getString("NAME"));
				vo.setId(rs.getString("JUMIN"));
				vo.setTel(rs.getString("TEL"));
				vo.setGender(rs.getString("GENDER"));
				vo.setAge(rs.getInt("AGE"));
				vo.setHome(rs.getString("HOME"));
			}

		}finally {
			//6. 닫기
			ps.close();
			con.close();
		}
		return vo;
	}

	/*
	 * 메소드명 	: delete
	 * 인자 		: 전화번호
	 * 리턴값 	: 삭제한 행 수
	 * 역할 		: 전화번호를 넘겨받아 해당 전화번호의 레코드를 삭제
	 */
	//- int executeUpdate() : INSERT/DELETE/UPDATE
	public int delete(String tel) throws SQLException {
		// 2. 연결객체 얻어오기
		Connection con=null;
		PreparedStatement ps = null;
		InfoVO vo = new InfoVO();
		try {
			con = DriverManager.getConnection(URL, USER, PASS);
			//3.sql	
			String sql ="DELETE FROM info_tab WHERE tel=?";
			//4. 전송객체 얻어오기
			ps = con.prepareStatement(sql);
			ps.setString(1, tel);	
			//5. 전송		
			int result = ps.executeUpdate();
			System.out.println(result + " 행 삭제");
		}finally {
			//6. 닫기
			ps.close();
			con.close();
		}
		return 1;		//TEL이 PK라서 없어지는 게 1개라서 1로 설정한거다
	}
	
	/*
	 * 메소드명 	: modify
	 * 인자 		: InfoVO vo
	 * 리턴값 	: void
	 * 역할 		: 입력된 내용을 수정
	 */

	@Override
	public void modify(InfoVO vo) throws SQLException {
		Connection con=null;
		PreparedStatement ps = null;
		try {
			con = DriverManager.getConnection(URL, USER, PASS);
			String sql ="UPDATE info_tab SET NAME =?, JUMIN=?, GENDER=?,"
					+ 	"	AGE=?, HOME=? WHERE TEL=?" ;	
			//4. 전송객체 얻어오기
			ps = con.prepareStatement(sql);
			//세팅
			ps.setString(1, vo.getName());
			ps.setString(2, vo.getId());
			ps.setString(3, vo.getGender());
			ps.setInt(4, vo.getAge());
			ps.setString(5, vo.getHome());
			ps.setString(6, vo.getTel());
			ps.executeUpdate();
		}
		finally {
			//6. 닫기
			ps.close();
			con.close();
		}

	}	
}



