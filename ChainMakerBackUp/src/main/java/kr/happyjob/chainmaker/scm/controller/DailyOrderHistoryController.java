package kr.happyjob.chainmaker.scm.controller;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.chainmaker.scm.model.DailyOrderListVO;
import kr.happyjob.chainmaker.scm.model.PageDTO;
import kr.happyjob.chainmaker.scm.service.DailyOrderHistoryService;
import kr.happyjob.chainmaker.scm.service.DailyOrderHistroyServiceImpl;
import kr.happyjob.chainmaker.system.model.ComnDtlCodModel;
import kr.happyjob.chainmaker.system.model.ComnGrpCodModel;

@Controller
@RequestMapping("/scm/dailyOrderHistory.do")
public class DailyOrderHistoryController {

	
	@Resource(name="DailyOrderHistoryServiceImpl")
	private DailyOrderHistoryService dailyOrderHistoryService;
	
	// 일별 수주 내역 접속 URL
	@RequestMapping("")
	public String getDailyOrderHistroyPage() {
		String viewLocation = "/scm/dailyOrderHistory";
		return viewLocation;
	}
	
	/**
	 * 일별 수주 내역 리스트 조회 
	 */
	@GetMapping
	@RequestMapping("/list/{listInfo}")
	public String getListDailyOrderHistoryOrDetail (@PathVariable(value = "listInfo") String listInfo
			
			, Model model, @ModelAttribute PageDTO pageDTO, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		
		//int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		//int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int currentPage = pageDTO.getCurrentPage();
		int pageSize = pageDTO.getPageSize();
		//int currentPage = 1;
		//int pageSize = 5;
		
		int pageIndex = (currentPage-1)*pageSize;	// 페이지 시작 row 번호

		pageDTO.setPageIndex(pageIndex);
		
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPageComnGrpCod",currentPage);
		
		
		//paramMap.put("pageIndex", pageIndex);
		//paramMap.put("pageSize", pageSize);
		
		String viewLocation = "";
		
		
		// pathValue listInfo 타입 별로, 일별 리스트 조회 내역 or 해당 주문의 상세 내역 리스트 메소드 호출 
		Map<String, Object> resultMap = new HashMap<>();
		
		if(listInfo.equals("dailyOrder")) {
			
			//resultMap에 담아서 결과 리스트 가져온다.
			resultMap = getListDailyOrder(pageDTO);
			
			// resultMap의 key들을 set에 가져온다.
			Set<String> keySet = resultMap.keySet();
			Iterator<String> keyIterator = keySet.iterator();
			
			// model에 key와 value에 해당하는 값을 담아준다.
			while(keyIterator.hasNext()) {
				String key = keyIterator.next();
				Object value = resultMap.get(key);
				model.addAttribute(key, value);
			}
			
			//viewLocation = (String)resultMap.get("viewLocation");
			
			viewLocation = "/scm/dailyOrderList";
			
		} else if(listInfo.equals("detailOrder")) {
		
			resultMap = getListDetailOrder();
		}
		
		
		
		// 공통 그룹코드 목록 조회
		//List<ComnGrpCodModel> listComnGrpCodModel = comnCodService.listComnGrpCod(paramMap);
		//model.addAttribute("listComnGrpCodModel", listComnGrpCodModel);
		
		// 공통 그룹코드 목록 카운트 조회
		//int totalCount = comnCodService.countListComnGrpCod(paramMap);
		//model.addAttribute("totalCntComnGrpCod", totalCount);
		


		return viewLocation;
	}
	
	
	
	
	/**
	 * 공통 상세 코드 목록 조회
	 */
	@RequestMapping("listComnDtlCod.do")
	public String listComnDtlCod(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;												// 페이지 시작 row 번호
		

		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		// 공통 상세코드 목록 조회
		//List<ComnDtlCodModel> listComnDtlCodModel = comnCodService.listComnDtlCod(paramMap);
		//model.addAttribute("listComnDtlCodModel", listComnDtlCodModel);
		
		// 공통 상세코드 목록 카운트 조회
		//int totalCount = comnCodService.countListComnDtlCod(paramMap);
		//model.addAttribute("totalCntComnDtlCod", totalCount);
		
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPageComnDtlCod",currentPage);

		
		
		return "/system/comnDtlCodList";
	}	
	
	
	
	
	
	
	// 주문 내역 리스트 조회 method
	public Map<String, Object> getListDailyOrder(PageDTO pageDTO) {
		
		Map<String, Object> resultMap = new HashMap<>();
		
		//resultMap.put("viewLocation", "/scm/dailyOrderHistroy");
		
		// 일별 주문 목록 조회
		List<DailyOrderListVO> listDailyOrder = dailyOrderHistoryService.listDailyOrder(pageDTO);
		resultMap.put("listDailyOrder", listDailyOrder);
		
		// 일별 주문 목록 카운트 조회
		int totalCount = dailyOrderHistoryService.countListDailyOrder();
		resultMap.put("totalCntDailyOrder", totalCount);
		//int totalCount = comnCodService.countListComnGrpCod(paramMap);
		//model.addAttribute("totalCntComnGrpCod", totalCount);
		
		return resultMap;
	}
	
	// 해당 주문 상세 내역 리스트 조회 method
	public Map<String, Object> getListDetailOrder() {
		
		Map<String, Object> resultMap = new HashMap<>();
		
		resultMap.put("viewLocation", "detailOrderHistroy");
		
		return resultMap;
	}
	
	
	

	
	
	
	
	
	/**
	 *  공통 그룹 코드 저장
	 */
	@RequestMapping("saveComnGrpCod.do")
	//Map 형태 redirect안할때 씀 즉 값만 바꾸겠다.라는 이야기
	@ResponseBody
	public Map<String, Object> saveComnGrpCod(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		String action = (String)paramMap.get("action");
		String result = "SUCCESS";
		String resultMsg = "저장 되었습니다.";
		
		// 사용자 정보 설정
		paramMap.put("fst_rgst_sst_id", session.getAttribute("usrSstId"));
		paramMap.put("fnl_mdfr_sst_id", session.getAttribute("usrSstId"));
		
		if ("I".equals(action)) {
			// 그룹코드 신규 저장
			//comnCodService.insertComnGrpCod(paramMap);
		} else if("U".equals(action)) {
			// 그룹코드 수정 저장
			//comnCodService.updateComnGrpCod(paramMap);
		} else {
			result = "FALSE";
			resultMsg = "알수 없는 요청 입니다.";
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);

		
		
		
		return resultMap;
	}
	
	

	/**
	 *  공통 그룹 코드 단건 조회
	 */
	@RequestMapping("selectComnGrpCod.do")
	@ResponseBody
	public Map<String, Object> selectComnGrpCod (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		String result = "SUCCESS";
		String resultMsg = "조회 되었습니다.";
		
		// 공통 그룹 코드 단건 조회
		//ComnGrpCodModel comnGrpCodModel = comnCodService.selectComnGrpCod(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		//resultMap.put("comnGrpCodModel", comnGrpCodModel);

		
		
		return resultMap;
	}
	
	/**
	 *  그룹코드 삭제
	 */
	@RequestMapping("deleteComnGrpCod.do")
	@ResponseBody
	public Map<String, Object> deleteComnGrpCod(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		String result = "SUCCESS";
		String resultMsg = "삭제 되었습니다.";
		
		// 그룹코드 삭제
		//comnCodService.deleteComnGrpCod(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);

		
		
		return resultMap;
	}
	
	


	
	/**
	 *  공통 상세 코드 단건 조회
	 */
	@RequestMapping("selectComnDtlCod.do")
	@ResponseBody
	public Map<String, Object> selectComnDtlCod (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		
		
		String result = "SUCCESS";
		String resultMsg = "조회 되었습니다.";
		
		// 공통 상세 코드 단건 조회
		//ComnDtlCodModel comnDtlCodModel = comnCodService.selectComnDtlCod(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		//resultMap.put("comnDtlCodModel", comnDtlCodModel);

		
		
		return resultMap;
	}
	
	
	/**
	 *  공통 상세 코드 저장
	 */
	@RequestMapping("saveComnDtlCod.do")
	@ResponseBody
	public Map<String, Object> saveComnDtlCod(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		

		
		
		String action = (String)paramMap.get("action");
		String result = "SUCCESS";
		String resultMsg = "저장 되었습니다.";
		
		// 사용자 정보 설정
		paramMap.put("fst_rgst_sst_id", session.getAttribute("usrSstId"));
		paramMap.put("fnl_mdfr_sst_id", session.getAttribute("usrSstId"));
		
		if ("I".equals(action)) {
			// 상세코드 신규 저장
			//comnCodService.insertComnDtlCod(paramMap);
		} else if("U".equals(action)) {
			// 상세코드 수정 저장
			//comnCodService.updateComnDtlCod(paramMap);
		} else {
			result = "FALSE";
			resultMsg = "알수 없는 요청 입니다.";
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);

		
		
		
		return resultMap;
	}
	
		
	/**
	 *  상세코드 삭제
	 */
	@RequestMapping("deleteComnDtlCod.do")
	@ResponseBody
	public Map<String, Object> deleteComnDtlCod(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		
		
		
		String result = "SUCCESS";
		String resultMsg = "삭제 되었습니다.";
		
		// 상세코드 삭제
		//comnCodService.deleteComnDtlCod(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);

		
		
		
		
		return resultMap;
	}
	
}
