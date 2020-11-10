package kr.happyjob.chainmaker.pcm.controller;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/pcm/")
public class PurchaseOrderListController {

	//Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	//Get class name for logger
	private final String className = this.getClass().toString();
	
	@RequestMapping("purchaseOrderList.do")
	public String purchaseOrderList(){
		logger.info("구매담당자 - 제품 발주/반품 목록");
		
		return "pcm/purchaseOrderList";
	}
}
