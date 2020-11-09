package kr.happyjob.chainmaker.supportD.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.chainmaker.supportD.model.NoticeDModel;


public interface NoticeDDao {

	List<NoticeDModel> noticeList(Map<String, Object> paramMap);

	int noticeTotalCnt(Map<String, Object> paramMap);

	NoticeDModel detailNotice(Map<String, Object> paramMap);

}
