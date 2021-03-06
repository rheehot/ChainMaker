<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Insert title here</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>


<script>

var pageSizeComnGrpCod = 5;
var pageBlockSizeComnGrpCod = 5;

// 상세코드 페이징 설정
var pageSizeComnDtlCod = 5;
var pageBlockSizeComnDtlCod = 10;


/** OnLoad event */ 
$(function() {

	// 그룹코드 조회
	fListComnGrpCod();
	
	// 버튼 이벤트 등록
	fRegisterButtonClickEvent();
});


/** 버튼 이벤트 등록 */
function fRegisterButtonClickEvent() {
	$('a[name=btn]').click(function(e) {
		e.preventDefault();

		var btnId = $(this).attr('id');

		switch (btnId) {
			case 'btnSaveGrpCod' :
				fSaveGrpCod();
				break;
			case 'btnDeleteGrpCod' :
				fDeleteGrpCod();
				break;
			case 'btnSaveDtlCod' :
				fSaveDtlCod();
				break;
			case 'btnDeleteDtlCod' :
				fDeleteDtlCod();
				break;
			case 'btnCloseGrpCod' :
			case 'btnCloseDtlCod' :
				gfCloseModal();
				break;
		}
	});
}


/** 그룹코드 폼 초기화 */
function fInitFormGrpCod(object) {
	$("#grp_cod").focus();
	if( object == "" || object == null || object == undefined) {
		
		$("#grp_cod").val("");
		$("#grp_cod_nm").val("");
		$("#grp_cod_eplti").val("");
		$("#grp_tmp_fld_01").val("");
		$("#grp_tmp_fld_02").val("");
		$("#grp_tmp_fld_03").val("");
		$("input:radio[name=grp_use_poa]:input[value='Y']").attr("checked", true);
		$("#grp_cod").attr("readonly", false);
		$("#grp_cod").css("background", "#FFFFFF");
		$("#grp_cod").focus();
		$("#btnDeleteGrpCod").hide();
		
	} else {
		
		$("#grp_cod").val(object.grp_cod);
		$("#grp_cod_nm").val(object.grp_cod_nm);
		$("#grp_cod_eplti").val(object.grp_cod_eplti);
		$("#grp_tmp_fld_01").val(object.tmp_fld_01);
		$("#grp_tmp_fld_02").val(object.tmp_fld_02);
		$("#grp_tmp_fld_03").val(object.tmp_fld_03);
		$("input:radio[name=grp_use_poa]:input[value="+object.use_poa+"]").attr("checked", true);
		$("#grp_cod").attr("readonly", true);
		$("#grp_cod").css("background", "#F5F5F5");
		$("#grp_cod_nm").focus();
		$("#btnDeleteGrpCod").show();
	}
}


/** 그룹코드 저장 validation */
function fValidateGrpCod() {

	var chk = checkNotEmpty(
			[
					[ "grp_cod", "그룹 코드를 입력해 주세요." ]
				,	[ "grp_cod_nm", "그룹 코드 명을 입력해 주세요" ]
				,	[ "grp_cod_eplti", "그룹 코드 설명을 입력해 주세요." ]
			]
	);

	if (!chk) {
		return;
	}

	return true;
}


/** 그룹코드 모달 실행 */
function fPopModalComnGrpCod(grp_cod) {
	
	// 신규 저장
	if (grp_cod == null || grp_cod=="") {
	
		// Tranjection type 설정
		$("#action").val("I");
		
		// 그룹코드 폼 초기화
		fInitFormGrpCod();
		
		// 모달 팝업
		gfModalPop("#layer1");

	// 수정 저장
	} else {
		
		// Tranjection type 설정
		$("#action").val("U");
		
		// 그룹코드 단건 조회
		fSelectGrpCod(grp_cod);
	}
}


/** 그룹코드 조회 */
function fListComnGrpCod(currentPage) {
	
	currentPage = currentPage || 1;
	
	var param = {
				currentPage : currentPage
			,	pageSize : pageSizeComnGrpCod
	}
	
	var resultCallback = function(data) {
		flistGrpCodResult(data, currentPage);
	};
	//Ajax실행 방식
	//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
	callAjax("/system/listComnGrpCod.do", "post", "text", true, param, resultCallback);
}


/** 그룹코드 조회 콜백 함수 */
function flistGrpCodResult(data, currentPage) {
	
	//alert(data);
	
	// 기존 목록 삭제
	$('#listComnGrpCod').empty();
	//$('#listComnGrpCod').find("tr").remove() 
	
	var $data = $( $(data).html() );

	// 신규 목록 생성
	var $listComnGrpCod = $data.find("#listComnGrpCod");		
	$("#listComnGrpCod").append($listComnGrpCod.children());
	
	// 총 개수 추출
	var $totalCntComnGrpCod = $data.find("#totalCntComnGrpCod");
	var totalCntComnGrpCod = $totalCntComnGrpCod.text(); 
	
	// 페이지 네비게이션 생성
	var paginationHtml = getPaginationHtml(currentPage, totalCntComnGrpCod, pageSizeComnGrpCod, pageBlockSizeComnGrpCod, 'fListComnGrpCod');
	
	//alert(paginationHtml);
	$("#comnGrpCodPagination").empty().append( paginationHtml );
	
	// 현재 페이지 설정
	$("#currentPageComnGrpCod").val(currentPage);
}


/** 그룹코드 단건 조회 */
function fSelectGrpCod(grp_cod) {
	
	var param = { grp_cod : grp_cod };
	
	var resultCallback = function(data) {
		fSelectGrpCodResult(data);
	};
	
	callAjax("/system/selectComnGrpCod.do", "post", "json", true, param, resultCallback);
}


/** 그룹코드 단건 조회 콜백 함수*/
function fSelectGrpCodResult(data) {

	if (data.result == "SUCCESS") {

		// 모달 팝업
		gfModalPop("#layer1");
		
		// 그룹코드 폼 데이터 설정
		fInitFormGrpCod(data.comnGrpCodModel);
		
	} else {
		alert(data.resultMsg);
	}	
}


/** 그룹코드 저장 */
function fSaveGrpCod() {

	// vaildation 체크
	if ( ! fValidateGrpCod() ) {
		return;
	}
	
	var resultCallback = function(data) {
		fSaveGrpCodResult(data);
	};
	
	callAjax("/system/saveComnGrpCod.do", "post", "json", true, $("#myForm").serialize(), resultCallback);
}


/** 그룹코드 저장 콜백 함수 */
function fSaveGrpCodResult(data) {
	
	// 목록 조회 페이지 번호
	var currentPage = "1";
	if ($("#action").val() != "I") {
		currentPage = $("#currentPageComnGrpCod").val();
	}
	
	if (data.result == "SUCCESS") {
		
		// 응답 메시지 출력
		alert(data.resultMsg);
		
		// 모달 닫기
		gfCloseModal();
		
		// 목록 조회
		fListComnGrpCod(currentPage);
		
	} else {
		// 오류 응답 메시지 출력
		alert(data.resultMsg);
	}
	
	// 입력폼 초기화
	fInitFormGrpCod();
}


/** 그룹코드 삭제 */
function fDeleteGrpCod() {
	
	var resultCallback = function(data) {
		fDeleteGrpCodResult(data);
	};
	
	callAjax("/system/deleteComnGrpCod.do", "post", "json", true, $("#myForm").serialize(), resultCallback);
}


/** 그룹코드 삭제 콜백 함수 */
function fDeleteGrpCodResult(data) {
	
	var currentPage = $("#currentPageComnGrpCod").val();
	
	if (data.result == "SUCCESS") {
		
		// 응답 메시지 출력
		alert(data.resultMsg);
		
		// 모달 닫기
		gfCloseModal();
		
		// 그룹코드 목록 조회
		fListComnGrpCod(currentPage);
		
	} else {
		alert(data.resultMsg);
	}	
}

</script>



</head>
<body>
	<a href="/sss/sssTest.do">vue-quill-editor_Test</a>
	<br>
	<a href="/sss/sssTest2.do">Vue-NoticeList_Test</a>
	
	<form id="myForm" action=""  method="">
	<input type="hidden" id="currentPageComnGrpCod" value="1">
	<input type="hidden" id="currentPageComnDtlCod" value="1">
	<input type="hidden" id="tmpGrpCod" value="">
	<input type="hidden" id="tmpGrpCodNm" value="">
	<input type="hidden" name="action" id="action" value="">
	
	<!-- 모달 배경 -->
	<div id="mask"></div>

	<div id="wrap_area">

		<h2 class="hidden">header 영역</h2>
		<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

		<h2 class="hidden">컨텐츠 영역</h2>
		<div id="container">
			<ul>
				<li class="lnb">
					<!-- lnb 영역 --> <jsp:include
						page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
				</li>
				<li class="contents">
					<!-- contents -->
					<h3 class="hidden">contents 영역</h3> <!-- content -->
					<div class="content">

						<p class="Location">
							<a href="#" class="btn_set home">메인으로</a> <a href="#"
								class="btn_nav">시스템 관리</a> <span class="btn_nav bold">공통코드
								관리</span> <a href="#" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>공지 사항</span> <span class="fr"> <a
								class="btnType blue" href="javascript:fPopModalComnGrpCod();" name="modal"><span>신규등록</span></a>
							</span>
						</p>
						
						<div class="divComGrpCodList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="6%">
									<col width="14%">
									<col width="14%">
									<col width="5%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="*">
									<col width="7%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">번호</th>
										<th scope="col">그룹 코드 ID</th>
										<th scope="col">그룹 코드 명</th>
										<th scope="col">사용</th>
										<th scope="col">임시 필드 01</th>
										<th scope="col">임시 필드 01</th>
										<th scope="col">임시 필드 03</th>
										<th scope="col">코드 설명</th>
										<th scope="col">비고</th>
									</tr>
								</thead>
								<tbody id="listComnGrpCod"></tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="comnGrpCodPagination"> </div>
	
						
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>

	<!-- 모달팝업 -->
	<div id="layer1" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>그룹코드 관리</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="120px">
						<col width="*">
						<col width="120px">
						<col width="*">
					</colgroup>

					<tbody>
						<tr>
							<th scope="row">그룹 코드 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="grp_cod" id="grp_cod" /></td>
							<th scope="row">그룹 코드 명 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="grp_cod_nm" id="grp_cod_nm" /></td>
						</tr>
						<tr>
							<th scope="row">코드 설명 <span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100"
								name="grp_cod_eplti" id="grp_cod_eplti" /></td>
						</tr>
						<tr>
							<th scope="row">임시 필드 01</th>
							<td colspan="3"><input type="text" class="inputTxt p100"
								name="grp_tmp_fld_01" id="grp_tmp_fld_01" /></td>
						</tr>
						<tr>
							<th scope="row">임시 필드 02</th>
							<td colspan="3"><input type="text" class="inputTxt p100"
								name="grp_tmp_fld_02" id="grp_tmp_fld_02" /></td>
						</tr>
						<tr>
							<th scope="row">임시 필드 03</th>
							<td colspan="3"><input type="text" class="inputTxt p100"
								name="grp_tmp_fld_03" id="grp_tmp_fld_03" /></td>
						</tr>
						<tr>
							<th scope="row">사용 유무 <span class="font_red">*</span></th>
							<td colspan="3"><input type="radio" id="radio1-1"
								name="grp_use_poa" id="grp_use_poa_1" value='Y' /> <label for="radio1-1">사용</label>
								&nbsp;&nbsp;&nbsp;&nbsp; <input type="radio" id="radio1-2"
								name="grp_use_poa" id="grp_use_poa_2" value="N" /> <label for="radio1-2">미사용</label></td>
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSaveGrpCod" name="btn"><span>저장</span></a> 
					<a href="" class="btnType blue" id="btnDeleteGrpCod" name="btn"><span>삭제</span></a> 
					<a href=""	class="btnType gray"  id="btnCloseGrpCod" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>

	<!--// 모달팝업 -->
</form>
</body>
</html>