package c_info2;

import java.sql.SQLException;
import java.util.ArrayList;

public interface InfoModel {

	
	//원래는 인터페이스를 만들고 이를 구현하는 클래스를 만드는게 순서 
	/*
	 *  사용자 입력값을 받아서 DB에 저장하는 역할
	 */
	
	void insertInfo(InfoVO vo) throws SQLException;
	/*
	 * 전체 Info_tab 의 레코드 검색
	 */

	ArrayList<InfoVO> selectAll() throws SQLException;
	
	/*
	 *  전화번호를 넘겨받아서 해당하는 사람의 정보를 검색
	 */
	InfoVO selectByTel(String tel) throws SQLException;
	
	/*
	 *  전화번호를 넘겨받아서 해당하는 사람의 정보를 삭제
	 */
	
	int delete(String tel) throws SQLException;
	
	/*
	 *  사람의 정보를 수정
	 */

	void modify(InfoVO vo) throws SQLException; 
	
}