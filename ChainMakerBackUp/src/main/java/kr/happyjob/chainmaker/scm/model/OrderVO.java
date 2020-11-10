package kr.happyjob.chainmaker.scm.model;

import java.util.Date;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NonNull;

@Getter
@EqualsAndHashCode(of = "order_no")
public class OrderVO {

	@NonNull
	private int order_no;
	@NonNull
	private String pro_no;
	private int order_qty;
	private String order_cd;
	private String deposit_cd;
	private Date order_date;
	private Date order_expdate;
	private Date order_mod_date;
	private String loginID;
}
