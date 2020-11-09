<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>WhInventoryForm</title>

<!-- common Include -->
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<script>
/*	//과정 페이징 설정
	var pageSizeCourse = 5;
	var pageBlockSizeCourse = 5;
	
	// 학생 페이징 설정
	var pageSizeStudent = 5;
	var pageBlockSizeStudent = 10;
	
	// 미수강 학생 페이징 설정
	var pageSizeunStudent = 5;
	var pageBlockSizeunStudent = 10;*/
	
	//Vue.js 사용 변수 설정
	var whvm;
	var whprovm;
	
	//페이지로드 작동 메서드
	$(document).ready(function(){
		
		init();
		
		//창고별 제품 목록 조회		
		whInventoryListAll();
	});
	
	function init(){
		whvm = new Vue({
			
		});
		
		whprovm = new Vue({
			
		});
	}


</script>

</head>
<body>	
	<form id="myForm" action=""  method="">
		<input type="hidden">
		
		<div id="wrap_area">
		
			<!-- header Include -->
			<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
			
			<div id="container">
				<ul>
					<li class="lnb">
					
						<!-- lnb Include --> 
						<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include>
						
					</li>
					<li class="contents">						
						<div class="content">
							
							<!-- 메뉴 경로 영역 -->
							<p class="Location">
								<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> <a href="#"
									class="btn_nav">거래내역</a> <span class="btn_nav bold">창고별 재고 현황</span> <a href="#" class="btn_set refresh">새로고침</a>
							</p>
							
							<!-- 검색 영역 -->
							<p class="search">
	
							</p>
							<p class="conTitle" id="searcharea">
								 <span>창고별 재고 현황</span>
								 <span class="fr"> 
									<select id="searchKey" name="searchKey" style="width: 80px;" v-model="searchKey">
									    <option value="all" id="option1" selected="selected">전체</option>
										<option value="ware_nm" id="option1">창고명</option>
										<option value="pro_nm" id="option2">제품명</option>
									</select> 
									<input type="text" id="searchWord" name="searchWord" v-model="searchWord"
										placeholder="" style="height: 28px;"> <a
										class="btnType blue" href="javascript:fListcourse()"
										onkeydown="enterKey()" name="search"><span id="searchEnter">검색</span></a>			
								</span>
							</p>
							
							<!-- 상단 테이블 영역 -->
							<div class="divWHInventoryList" id="divWHInventoryList">
								<table class="col">
									<colgroup>
									    <col width="10%">
										<col width="10%">
										<col width="15%">
										<col width="15%">
										<col width="10%">
										<col width="45%">
									</colgroup>
					
									<thead>
										<tr>
										    <th scope="col">창고 코드</th>
											<th scope="col">제품 번호</th>
											<th scope="col">창고 명</th>
											<th scope="col">제품 명</th>
											<th scope="col">재고 수량</th>
											<th scope="col">창고 위치</th>
										</tr>
									</thead>
									
									<!-- 상단테이블 DB데이터 출력 영역 -->
									<tbody id="listWHInventory">
										<tr>
											<td>1</td>
											<td>1</td>
											<td>에이스 트윈</td>
											<td>UPS</td>
											<td>10</td>
											<td>서울시 구로구</td>
										</tr>
										<!-- <template v-for="(row, index) in items" v-if="items.length">
											<tr onclick="vm.rowClicked(this)">
											    <td>{{ row.no }}</td>
												<td>{{ row.title }}</td>
												<td>{{ row.startdate }} - {{ row.enddate }}</td>
												<td>{{ row.teacher }}</td>
												<td>{{ row.teacher }}</td>
												<td>{{ row.teacher }}</td>						
											</tr>
										</template> -->
									</tbody>
								</table>
							</div>	<!-- .divWhInventoryList 종료 -->
							
							<!-- 상단테이블 Pagenation 영역 -->
							<div class="pagingArea"  id="WHInventoryPagination"> </div>
							
							<p class="conTitle mt50">
								<span>제품별 입출고 내역</span> 
								<span class="fr"></span>
							</p>
							
							<div class="divWHProductList" id="divWHProductList">
								<table class="col">
									<colgroup>
										<col width="20%">
										<col width="20%">
										<col width="20%">
										<col width="20%">
									</colgroup>
		
									<thead>
										<tr>
										    <th scope="col">제품 번호</th>
											<th scope="col">제품 명</th>
											<th scope="col">입고 량</th>
											<th scope="col">출고 량</th>
										</tr>
									</thead>
									
									<!-- 하단테이블 DB 데이터 출력 영역 -->
									<tbody id="listWHProduct">
										<!-- <template v-for="(row, index) in items"  v-if="items.length">
											<tr>
												<td>{{ row.loginID }}</td>
												<td>{{ row.name }}</td>
												<td>{{ row.sex }}</td>
												<td>{{ row.age }}</td>
												<td>{{ row.school }}</td>
											</tr>
										</template>
										<template v-else>
											<tr>
											    <td colspan=5>재고가 없습니다.</td>
											</tr>
										</template> -->
									</tbody>
								</table>
							</div>
						<!-- 하단테이블 Pagenation 영역 -->
						<div class="pagingArea"  id="WHProductPagination"> </div>
						</div>	<!-- .content 종료 -->
					</li>	<!-- .content 종료 -->
				</ul>				
			</div>	<!-- #container 종료 -->
			
			<!-- footer Include -->
			<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
			
		</div>	<!-- #wrap_area 종료 -->
	</form>	
</body>
</html>