package kr.happyjob.chainmaker.scm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class DailyOrderHistoryController {

	
	@RequestMapping("scm/dailyOrderHistory")
	public String getDailyOrderHistroy() {
		String viewLocation = "scm/dailyOrderHistroy";
		
		return viewLocation;
	}
}
