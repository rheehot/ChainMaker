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
/*	//���� ����¡ ����
	var pageSizeCourse = 5;
	var pageBlockSizeCourse = 5;
	
	// �л� ����¡ ����
	var pageSizeStudent = 5;
	var pageBlockSizeStudent = 10;
	
	// �̼��� �л� ����¡ ����
	var pageSizeunStudent = 5;
	var pageBlockSizeunStudent = 10;*/
	
	//Vue.js ��� ���� ����
	var whvm;
	var whprovm;
	
	//�������ε� �۵� �޼���
	$(document).ready(function(){
		
		init();
		
		//â�� ��ǰ ��� ��ȸ		
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
							
							<!-- �޴� ��� ���� -->
							<p class="Location">
								<a href="../dashboard/dashboard.do" class="btn_set home">��������</a> <a href="#"
									class="btn_nav">�ŷ�����</a> <span class="btn_nav bold">â�� ��� ��Ȳ</span> <a href="#" class="btn_set refresh">���ΰ�ħ</a>
							</p>
							
							<!-- �˻� ���� -->
							<p class="search">
	
							</p>
							<p class="conTitle" id="searcharea">
								 <span>â�� ��� ��Ȳ</span>
								 <span class="fr"> 
									<select id="searchKey" name="searchKey" style="width: 80px;" v-model="searchKey">
									    <option value="all" id="option1" selected="selected">��ü</option>
										<option value="ware_nm" id="option1">â���</option>
										<option value="pro_nm" id="option2">��ǰ��</option>
									</select> 
									<input type="text" id="searchWord" name="searchWord" v-model="searchWord"
										placeholder="" style="height: 28px;"> <a
										class="btnType blue" href="javascript:fListcourse()"
										onkeydown="enterKey()" name="search"><span id="searchEnter">�˻�</span></a>			
								</span>
							</p>
							
							<!-- ��� ���̺� ���� -->
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
										    <th scope="col">â�� �ڵ�</th>
											<th scope="col">��ǰ ��ȣ</th>
											<th scope="col">â�� ��</th>
											<th scope="col">��ǰ ��</th>
											<th scope="col">��� ����</th>
											<th scope="col">â�� ��ġ</th>
										</tr>
									</thead>
									
									<!-- ������̺� DB������ ��� ���� -->
									<tbody id="listWHInventory">
										<tr>
											<td>1</td>
											<td>1</td>
											<td>���̽� Ʈ��</td>
											<td>UPS</td>
											<td>10</td>
											<td>����� ���α�</td>
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
							</div>	<!-- .divWhInventoryList ���� -->
							
							<!-- ������̺� Pagenation ���� -->
							<div class="pagingArea"  id="WHInventoryPagination"> </div>
							
							<p class="conTitle mt50">
								<span>��ǰ�� ����� ����</span> 
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
										    <th scope="col">��ǰ ��ȣ</th>
											<th scope="col">��ǰ ��</th>
											<th scope="col">�԰� ��</th>
											<th scope="col">��� ��</th>
										</tr>
									</thead>
									
									<!-- �ϴ����̺� DB ������ ��� ���� -->
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
											    <td colspan=5>��� �����ϴ�.</td>
											</tr>
										</template> -->
									</tbody>
								</table>
							</div>
						<!-- �ϴ����̺� Pagenation ���� -->
						<div class="pagingArea"  id="WHProductPagination"> </div>
						</div>	<!-- .content ���� -->
					</li>	<!-- .content ���� -->
				</ul>				
			</div>	<!-- #container ���� -->
			
			<!-- footer Include -->
			<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
			
		</div>	<!-- #wrap_area ���� -->
	</form>	
</body>
</html>