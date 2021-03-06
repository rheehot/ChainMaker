package kr.happyjob.chainmaker.scm.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.chainmaker.scm.dao.WHInventoryFormDao;
import kr.happyjob.chainmaker.scm.model.WHInventoryFormModel;


@Service
public class WHInventoryFormServiceImpl implements WHInventoryFormService {

	@Autowired
	WHInventoryFormDao whInventoryFormDao;
	
	@Override
	public List<WHInventoryFormModel> whInventoryList(Map<String, Object> paramMap) {
		List<WHInventoryFormModel> listWHInventory=whInventoryFormDao.whInventoryList(paramMap);
		return listWHInventory;
	}

	@Override
	public int countWHInventoryList(Map<String, Object> paramMap) {
		int total=whInventoryFormDao.countWHInventoryList(paramMap);
		return total;
	}

}
