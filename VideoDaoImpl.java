package model.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import model.VideoDao;
import model.vo.VideoVO;

public class VideoDaoImpl implements VideoDao{
	
	final static String DRIVER 	="oracle.jdbc.driver.OracleDriver";		//회사에 들어가면 상수로 설정할 것이다.(final static 붙여서, 또한 변수명은 눈에 띄게 대문자로)
	final static String URL 	="jdbc:oracle:thin:@192.168.0.26:1521";
	final static String USER 	="scott";
	final static String PASS 	="tiger";
	
	public VideoDaoImpl() throws Exception{
		// 1. 드라이버로딩
		Class.forName(DRIVER);
		System.out.println("드라이버로딩 성공");
	}	
	/* 함수명 : insertVideo
	 * 인자 : VideoVO vo, int count
	 * 리턴값 : void
	 * 역할 : 비디오 입력값을 받아서 DB에 저장하는 역할 */
	public void insertVideo(VideoVO vo, int count) throws Exception{
		// 2. Connection 연결객체 얻어오기
		Connection con=null;
		//PreparedStatement 객체 생성 및 인자 지정
		PreparedStatement ps = null;
		con = DriverManager.getConnection(URL, USER, PASS);
		// 3. sql 문장 만들기
		String sql = "INSERT INTO VIDEO "
				+ "(VIDEONO, GENRE,VIDEONAME,DIRECTOR, ACTOR,EXP )"
				+ " VALUES(seq_video_no.nextval,?,?,?,?,?)";
		// 4. sql 전송객체 (PreparedStatement)	
		ps = con.prepareStatement(sql);
		//세팅
			ps.setString(1, vo.getGenre());
			ps.setString(2, vo.getVideoName());
			ps.setString(3, vo.getDirector());
			ps.setString(4, vo.getActor());
			ps.setString(5, vo.getExp());
		// 5. sql 전송
		for(int i=0; i<count; i++) {
			ps.executeUpdate();}
	}//end of insertVideo

	/* 함수명 : selectVideo
	 * 인자 : String director, String vname
	 * 리턴값 : ArrayList
	 * 역할 : 영화제목 및 감독 이름으로 VIDEO 의 레코드 검색 */
//	
//	public ArrayList selectVideo(String director, String vname) throws Exception {
//		//저장할 객체 만들기
//		ArrayList data = new ArrayList();
//		//연결객체얻어오기
//			Connection con=null;
//		//PreparedStatement 객체 생성 및 인자 지정
//			PreparedStatement ps = null;
//		con = DriverManager.getConnection(URL, USER, PASS);
//		//sql문장
//		String sql;
//		//아무것도 입력하지 않았을때
//		if(vname.equals("")) {
//			sql="SELECT VIDEONO,VIDEONAME,GENRE,DIRECTOR,ACTOR FROM VIDEO ";
//			//전송객체 얻어오기
//			ps = con.prepareStatement(sql);	
//		}//감독으로 입력했을때
//		else if(director.equals("감독")) {
//			sql ="SELECT VIDEONO,VIDEONAME,GENRE,DIRECTOR,ACTOR FROM VIDEO WHERE DIRECTOR=?";
//			//전송객체 얻어오기
//			ps = con.prepareStatement(sql);	
//			ps.setString(1, vname);
//		}//제목으로 입력했을때
//		else {
//			sql ="SELECT VIDEONO,VIDEONAME,GENRE,DIRECTOR,ACTOR FROM VIDEO WHERE VIDEONAME=?";
//			//전송객체 얻어오기
//			ps = con.prepareStatement(sql);	
//			ps.setString(1, vname);
//		}
//		//전송
//		ResultSet rs = ps.executeQuery();
//		//내용이 많기 때문에 반복문 형식으로 
//		while(rs.next()) {
//			ArrayList temp = new ArrayList();
//			temp.add(rs.getString("VIDEONO"));
//			temp.add(rs.getString("VIDEONAME"));
//			temp.add(rs.getString("GENRE"));
//			temp.add(rs.getString("DIRECTOR"));
//			temp.add(rs.getString("ACTOR"));
//			data.add(temp);
//		}
//		return data;//리턴값을 NULL로하면 아무것도 들어가지 않음
//	}//end of selectVideo
	
	/* 함수명 : selectVideo
	 * 인자 : int idx, String word
	 * 리턴값 : ArrayList
	 * 역할 : 영화제목 및 감독 이름을 인덱스로 설정해서 VIDEO 의 레코드 검색 */
	
	public ArrayList selectVideo(int idx, String word) throws Exception {
		ArrayList data = new ArrayList();
		//연결객체얻어오기
			Connection con=null;
		//PreparedStatement 객체 생성 및 인자 지정
			PreparedStatement ps = null;
		con = DriverManager.getConnection(URL, USER, PASS);
		//sql문장
		String []colNames= {"VIDEONAME","DIRECTOR"};
		//아무것도 입력하지 않았을때
			String sql="SELECT VIDEONO,VIDEONAME,GENRE,DIRECTOR,ACTOR FROM VIDEO WHERE " +colNames[idx]+" LIKE '%"+ word +"%'";
			System.out.println(sql);
			//여기서 ?를 쓰면 ''이 붙는다. 
			//전송객체 얻어오기
			ps = con.prepareStatement(sql);	
			//전송
			ResultSet rs = ps.executeQuery();
			//내용이 많기 때문에 반복문 형식으로 
			while(rs.next()) {
				ArrayList temp = new ArrayList();
				temp.add(rs.getString("VIDEONO"));
				temp.add(rs.getString("VIDEONAME"));
				temp.add(rs.getString("GENRE"));
				temp.add(rs.getString("DIRECTOR"));
				temp.add(rs.getString("ACTOR"));
				data.add(temp);
			}
		return data;
	}//end of selectVideo
	/* 함수명 : selectByVnum
	 * 인자 : String vNum
	 * 리턴값 : VideoVO
	 * 역할 : 비디오 번호로 VIDEO 의 레코드 검색 */
	//번호로 비디오 정보 출력
	public VideoVO selectByVnum(String vNum)throws Exception{
		VideoVO vo = new VideoVO();
		//연결객체얻어오기
		Connection con=null;
		//PreparedStatement 객체 생성 및 인자 지정
		PreparedStatement ps = null;
		con = DriverManager.getConnection(URL, USER, PASS);
		//SQL문
		String sql = "SELECT* FROM VIDEO WHERE VIDEONO=?";
		//전송객체 얻어오기
		ps = con.prepareStatement(sql);	
		//값 세팅
		ps.setString(1, vNum);
		//전송
		ResultSet rs = ps.executeQuery();
		//값 세팅
		while(rs.next()) {
			vo.setVideoNo(rs.getString("VIDEONO"));
			vo.setVideoName(rs.getString("VIDEONAME"));
			vo.setGenre(rs.getString("GENRE"));
			vo.setDirector(rs.getString("DIRECTOR"));
			vo.setActor(rs.getString("ACTOR"));
			vo.setExp(rs.getString("EXP"));
		}
		return vo;
	}//end of selectByNum
	/* 함수명 : modifyVideo
	 * 인자 : VideoVO vo
	 * 리턴값 : int
	 * 역할 : 비디오 번호를 이용해서 비디오 정보를 수정 */

	public int modifyVideo(VideoVO vo) throws Exception {
		int result = 0;
		//연결객체얻어오기
		Connection con=null;
		//PreparedStatement 객체 생성 및 인자 지정
		PreparedStatement ps = null;
		con = DriverManager.getConnection(URL, USER, PASS);
		//sql문
		String sql="UPDATE VIDEO SET VIDEONAME=?,GENRE=?,DIRECTOR=?,ACTOR=?,EXP=? WHERE VIDEONO=?";
		//전송객체 얻어오기
		ps = con.prepareStatement(sql);
		//세팅
		ps.setString(1, vo.getVideoName());
		ps.setString(2, vo.getGenre());
		ps.setString(3, vo.getDirector());
		ps.setString(4, vo.getActor());
		ps.setString(5, vo.getExp());
		ps.setString(6, vo.getVideoNo());
		ps.executeUpdate();
		
		return result;
	}//end of modifyVideo
	/*
	public void modifyVideo(VideoVO vo, String director, String vname) throws Exception{
		int result = 0;
		Connection con=null;
		PreparedStatement ps = null;
		con = DriverManager.getConnection(URL, USER, PASS);
		String sql;
		if(vname.equals("")) {
			sql="UPDATE VIDEO SET VIDEONO,VIDEONAME,GENRE,DIRECTOR,ACTOR FROM VIDEO ";
			ps = con.prepareStatement(sql);
			ps.setString(1, vo.getVideoNo());
			ps.setString(2, vo.getVideoName());
			ps.setString(3, vo.getGenre());
			ps.setString(4, vo.getDirector());
			ps.setString(5, vo.getActor());
		}
		else if(director.equals("감독")) {
			sql ="UPDATE VIDEO SET VIDEONO,VIDEONAME,GENRE,DIRECTOR,ACTOR FROM VIDEO WHERE DIRECTOR=?";
			//전송객체 얻어오기
			ps = con.prepareStatement(sql);	
			ps.setString(1, vo.getVideoNo());
			ps.setString(2, vo.getVideoName());
			ps.setString(3, vo.getGenre());
			ps.setString(4, vo.getActor());
			ps.setString(5, vo.getDirector());
		}
		else {
			sql ="UPDATE VIDEO SET VIDEONO,GENRE,DIRECTOR,ACTOR FROM VIDEO WHERE VIDEONAME=?";
			//전송객체 얻어오기
			ps = con.prepareStatement(sql);	
			ps.setString(1, vo.getVideoNo());
			ps.setString(2, vo.getGenre());
			ps.setString(3, vo.getDirector());
			ps.setString(4, vo.getActor());
			ps.setString(5, vo.getVideoName());

		}
		ps.executeUpdate();
	}*/
	/* 함수명 : deleteVideo
	 * 인자 : String vNum
	 * 리턴값 : int
	 * 역할 : 비디오 번호를 이용해서 비디오 정보를 삭제 */
	@Override
	public int deleteVideo(String vNum) throws Exception {
		int result = 0;
		//연결객체얻어오기
		Connection con=null;
		//PreparedStatement 객체 생성 및 인자 지정
		PreparedStatement ps = null;
		con = DriverManager.getConnection(URL, USER, PASS);
		//sql문
		String sql ="DELETE FROM VIDEO WHERE VIDEONO=?";
		//전송객체 얻어오기
		ps = con.prepareStatement(sql);
		//값세팅
		ps.setString(1, vNum);	
		//전송
		ps.executeUpdate();
		System.out.println(result + " 행 삭제");
		
		return result;
	}//end of deleteVideo
	
	
}
