package model;

import java.util.ArrayList;

public interface RentDao {
	
	//대여
	public void rentVideo(String tel, int vnum) throws Exception;
	//반납
	public void returnVideo(int vNum) throws Exception;
	//미납목록검색
	public ArrayList selectList() throws Exception;
	//전화번호를 통해 이름 검색
	public String selectByTel(String tel) throws Exception;
}
