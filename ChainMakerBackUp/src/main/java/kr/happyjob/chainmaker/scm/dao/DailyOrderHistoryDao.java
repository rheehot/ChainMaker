package kr.happyjob.chainmaker.scm.dao;

import java.util.List;
import java.util.Map;

public interface DailyOrderHistoryDao {
	
	/** 그룹코드 목록 조회 */
	//listComnGrpCod 가 쿼리문 ID가 됌.
	public List<ComnGrpCodModel> listComnGrpCod(Map<String, Object> paramMap);
	
}
