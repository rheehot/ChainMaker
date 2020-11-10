package kr.happyjob.chainmaker.scm.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.chainmaker.scm.dao.DailyOrderHistoryDao;
import kr.happyjob.chainmaker.scm.model.DailyOrderListVO;
import kr.happyjob.chainmaker.scm.model.PageDTO;

@Service("DailyOrderHistoryServiceImpl")
public class DailyOrderHistroyServiceImpl implements DailyOrderHistoryService{
	
	@Autowired
	private DailyOrderHistoryDao dailyOrderHistoryDao;

	@Override
	public List<DailyOrderListVO> listDailyOrder(PageDTO pageDTO) {
		return dailyOrderHistoryDao.listDailyOrder(pageDTO);
	}

	@Override
	public int countListDailyOrder() {
		return dailyOrderHistoryDao.countListDailyOrder();
	}
	
	

}
