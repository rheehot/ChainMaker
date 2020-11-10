<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>purchaseOrderList</title>

<!-- common Include -->
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script>

	//datepicker 정보
	var startDate;
	var endDate;
	
	$("#enddate").datepicker({defaultDate: $.datepicker.formatDate('yyyy.mm.dd', new Date())});
	$("#startdate").datepicker({ dateFormat: 'yyyy.mm.dd' }).bind("change",function(){
        var minValue = $(this).val();
        minValue = $.datepicker.parseDate("yyyy.mm.dd", minValue);
        minValue.setDate(minValue.getDate()+1);
        $("#enddate").datepicker( "option", "minDate", minValue );
    });
</script>
</head>
<body>
	<form id="myForm" action=""  method="">
		<input type="hidden" name="currentPagePurchaseOrderList" id="currentPagePurchaseOrderList" value="">
		
		<div id="wrap_area">
			
			<!-- header Include -->
			<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
			
			<div id="container">
				<ul>
					<li class="lnb">
					
						<!-- lnb Include -->
						<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include>
						
					</li>
					<li class="content">
						<div class="content">
							<!-- 메뉴 경로 영역 -->
							<p class="Location">
								<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> <a href="#"
									class="btn_nav">제품 발주/반품</a> <span class="btn_nav bold">발주 지시서 목록</span> <a href="#" class="btn_set refresh">새로고침</a>
							</p>
							
							<!-- 검색 영역 -->
							<p class="search">
							
							</p>							
							<p class="conTitle" id="searchArea">
								 <span class="fr"> 
									<select id="searchKey" name="searchKey" style="width: 80px;" v-model="searchKey">
									    <option value="all" id="option1" selected="selected">전체</option>
										<option value="ware_nm" id="option2">업체</option>
										<option value="ware_nm" id="option3">제품</option>
										<option value="ware_nm" id="option4">미승인</option>
										<option value="pro_nm" id="option5">승인</option>
									</select> 
									<input type="text" id="searchWord" name="searchWord" v-model="searchWord"
										placeholder="" style="height: 28px;"> 
										<a class="btnType blue" href="javascript:fListcourse()"
										onkeydown="enterKey()" name="search"><span id="searchEnter">검색</span></a>			
								</span>
							</p>
							
							<!-- 테이블 영역 -->
							<div class="divPurchaseOrderList" id="divPurchaseOrderList">
								<table class="col">
									<colgroup>
										<col width="10%">
										<col width="20%">
										<col width="10%">
										<col width="10%">
										<col width="20%">
										<col width="10%">
										<col width="10%">
									</colgroup>
									<thead>
										<tr>
											<th scope="col">발주번호</th>
											<th scope="col">발주회사</th>
											<th scope="col">발주제품</th>
											<th scope="col">발주수량</th>
											<th scope="col">발주날짜</th>
											<th scope="col">임원승인여부</th>
											<th scope="col">입금확인</th>
										</tr>
									</thead>
									
									<!--  -->
									<tbody id="listPurchaseOrder">
									
									</tbody>									
								</table>
							</div>	<!-- .divPurchaseOrderList 종료 -->
							
							<!-- 테이블 페이지 네비게이션 영역 -->
							<div class="pagingArea" id="PurchaseOrderPagination"></div>							
						</div>
					</li>
				</ul>
			</div>
		</div>
		
	</form>
</body>
</html>