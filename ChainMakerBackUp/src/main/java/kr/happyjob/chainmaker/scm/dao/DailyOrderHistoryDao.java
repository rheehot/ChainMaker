package kr.happyjob.chainmaker.scm.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.chainmaker.scm.model.DailyOrderListVO;
import kr.happyjob.chainmaker.scm.model.PageDTO;

public interface DailyOrderHistoryDao {
	
	/** 일별 주문 목록 조회 */
	public List<DailyOrderListVO> listDailyOrder(PageDTO pageDTO);
	
	// 일별 주문 총 개수
	public int countListDailyOrder();
	
}
