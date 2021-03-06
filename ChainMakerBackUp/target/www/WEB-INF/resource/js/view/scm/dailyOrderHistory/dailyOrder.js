/**
* 공통코드 부분
*/


// 그룹코드 페이징 설정
var pageSizeComnGrpCod = 5;
var pageBlockSizeComnGrpCod = 5;

/** 일별 수주 내역 폼 초기화 */
function fInitFormDiailyOrderHistory(object) {
  $("#grp_cod").focus();
  if (object == "" || object == null || object == undefined) {

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
    $("input:radio[name=grp_use_poa]:input[value=" + object.use_poa + "]").attr("checked", true);
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
      ["grp_cod", "그룹 코드를 입력해 주세요."],
      ["grp_cod_nm", "그룹 코드 명을 입력해 주세요"],
      ["grp_cod_eplti", "그룹 코드 설명을 입력해 주세요."]
    ]);
  if (!chk) {
    return;
  }
  return true;
}

/** 그룹코드 모달 실행 */
function fPopModalComnGrpCod(grp_cod) {

  // 신규 저장
  if (grp_cod == null || grp_cod == "") {

    // Tranjection type 설정
    $("#action").val("I");

    // 그룹코드 폼 초기화
    fInitFormDiailyOrderHistory();

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

/** 일별 수주 내역 조회 */
function fListDailyOrderHistroy(currentPage) {

  currentPage = currentPage || 1;

  console.log("currentPage : " + currentPage);

  var param = {
    currentPage: currentPage
    , pageSize: pageSizeComnGrpCod
  }

  var resultCallback = function(data) {
    flistDailyOrderHistroyResult(data, currentPage);
  };
  //Ajax실행 방식
  //callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
  //html로 받을거라 text
  callAjax("/scm/dailyOrderHistory.do", "post", "text", true, param, resultCallback);
}

/** 일별 수주 내역 조회 콜백 함수 */
function flistDailyOrderHistroyResult(data, currentPage) {

  //alert(data);
  console.log(data);

  // 기존 목록 삭제
  $('#listDailyOrderHistroy').empty();

  var $data = $($(data).html());

  $("#listDailyOrderHistroy").append($data);

  // 총 개수 추출
  var $totalCntComnGrpCod = $data.find("#totalCntComnGrpCod");
  var totalCntComnGrpCod = $totalCntComnGrpCod.text();

  // 페이지 네비게이션 생성
  var paginationHtml = getPaginationHtml(currentPage, totalCntComnGrpCod, pageSizeComnGrpCod, pageBlockSizeComnGrpCod, 'fListDailyOrderHistroy');
  console.log("paginationHtml : " + paginationHtml);

  $("#comnGrpCodPagination").empty().append(paginationHtml);

  // 현재 페이지 설정
  $("#currentPageComnGrpCod").val(currentPage);
}


/** 그룹코드 단건 조회 */
function fSelectGrpCod(grp_cod) {

  var param = { grp_cod: grp_cod };

  var resultCallback = function(data) {
    fSelectDailyOrderHistroyResult(data);
  };

  callAjax("/system/selectComnGrpCod.do", "post", "json", true, param, resultCallback);
}


/** 그룹코드 단건 조회 콜백 함수*/
function fSelectDailyOrderHistroyResult(data) {

  if (data.result == "SUCCESS") {

    // 모달 팝업
    gfModalPop("#layer1");

    // 일별 수주내역 폼 데이터 설정
    fInitFormDiailyOrderHistory(data.comnGrpCodModel);

  } else {
    alert(data.resultMsg);
  }
}


/** 그룹코드 저장 */
function fSaveGrpCod() {

  // vaildation 체크
  if (!fValidateGrpCod()  {
    return;
  }

  var resultCallback = function(data) {
    fSaveDailyOrderHistoryResult(data);
  };

  callAjax("/system/saveComnGrpCod.do", "post", "json", true, $("#myForm").serialize(), resultCallback);
}


/** 그룹코드 저장 콜백 함수 */
function fSaveDailyOrderHistoryResult(data) {

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
    fListDailyOrderHistroy(currentPage);

  } else {
    // 오류 응답 메시지 출력
    alert(data.resultMsg);
  }

  // 입력폼 초기화
  fInitFormDiailyOrderHistory();
}


/** 그룹코드 삭제 */
function fDeleteDailyOrderHistroy() {

  var resultCallback = function(data) {
    fDeleteDailyOrderHistroyResult(data);
  };

  callAjax("/system/deleteComnGrpCod.do", "post", "json", true, $("#myForm").serialize(), resultCallback);
}


/** 그룹코드 삭제 콜백 함수 */
function fDeleteDailyOrderHistroyResult(data) {

  var currentPage = $("#currentPageComnGrpCod").val();

  if (data.result == "SUCCESS") {

    // 응답 메시지 출력
    alert(data.resultMsg);

    // 모달 닫기
    gfCloseModal();

    // 일별수주 목록 조회
    fListDailyOrderHistroy(currentPage);

  } else {
    alert(data.resultMsg);
  }
}


