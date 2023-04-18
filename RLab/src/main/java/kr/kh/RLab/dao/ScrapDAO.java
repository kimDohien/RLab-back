package kr.kh.RLab.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import kr.kh.RLab.pagination.Criteria;
import kr.kh.RLab.vo.BoardVO;
import kr.kh.RLab.vo.ScrapVO;

public interface ScrapDAO {
    ScrapVO findScrap(ScrapVO scrapVO);
    void insertScrap(ScrapVO scrapVO);
    void updateScrap(ScrapVO scrapVO);
    int getScrapCountByBoard(int bo_num);
    
    // 아이디로 스크랩한 게시글 리스트 가져오기
	ArrayList<BoardVO> selectScrapListById(String memberId);
	
	ArrayList<ScrapVO> findScrap2(int bo_num);



}
