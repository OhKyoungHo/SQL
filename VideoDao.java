package model;

import java.util.ArrayList;

import model.vo.VideoVO;

public interface VideoDao {
	public void 		insertVideo(VideoVO vo, int count) throws Exception;
	//public ArrayList selectVideo(String director, String vname)throws Exception;//둘다 string으로 찾는 버전
	public ArrayList 	selectVideo(int idx, String word)throws Exception;//index로 하는 버전
	public int			modifyVideo(VideoVO vo) throws Exception;
	public int 			deleteVideo(String vNum) throws Exception;
	public VideoVO 		selectByVnum(String vNum)throws Exception;

}
