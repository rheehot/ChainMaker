package kr.happyjob.chainmaker.scm.controller;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/scm/")
public class WHInventoryFormController {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
		
	//창고별 재고 현황 페이지 연결
	@RequestMapping("whInventoryForm.do")
	public String whInventoryForm(){
		logger.info("창고별 재고 현황 페이지");
		
		return "scm/whInventoryForm";
	}
}
