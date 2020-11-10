package kr.happyjob.chainmaker.scm.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.chainmaker.scm.model.DailyOrderListVO;
import kr.happyjob.chainmaker.scm.model.PageDTO;

public interface DailyOrderHistoryService {

	/** 일별 주문 목록 조회 */
	public List<DailyOrderListVO> listDailyOrder(PageDTO pageDTO);
	
	public int countListDailyOrder();
}
