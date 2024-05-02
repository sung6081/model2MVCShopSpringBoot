<!-- 상품목록조회 -->

<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@page import="spring.common.Page"%>
<%@page import="java.util.Map"%>
<%@page import="spring.domain.Product"%>
<%@page import="java.util.List"%>
<%@page import="spring.common.Search"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<html>
<head>
						

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<!-- 참조 : http://getbootstrap.com/css/   -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
  	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
  	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
       body > div.container{
            margin-top: 100px;
        }
        
        img.product-image {
        	
        	width:350px;
        	height:350px;
        	
        }
        
        footer.container-fluid {
        	background-color:white;
        }
		
		
    </style>
<script type="text/javascript">
function fncGetProductList(currentPage) {
	//document.getElementById("currentPage").value = currentPage;
	$("#currentPage").val(currentPage);
   	document.detailForm.submit();		
}

//가격낮은순
function fncGetProductListLow(currentPage){
	
	//console.log(1);
	document.getElementById("currentPage").value = currentPage;
	//$("#currentPage").val(currentPage);
	if(document.getElementById("priceOptionLow").value != null && document.getElementById("priceOptionLow").value != ''){
		document.getElementById("priceOptionLow").value = '';
		//$('#priceOptionLow').val('');
	}else {
		document.getElementById("priceOptionHigh").value = '';
		//$('#priceOptionHigh').val('');
		document.getElementById("priceOptionLow").value = 'high';
		//$('#priceOptionLow').val('high');
	}
	document.detailForm.submit();	
	//$('form').submit();
}

//가격 높은순
function fncGetProductListHigh(currentPage){
	console.log(2);
	document.getElementById("currentPage").value = currentPage;
	//$('#currentPage').val(currentPage);
	if(document.getElementById("priceOptionHigh").value != null && document.getElementById("priceOptionHigh").value != ''){
		document.getElementById("priceOptionHigh").value = '';
		//$('#priceOptionHigh').val('');
	}else {
		document.getElementById("priceOptionLow").value = '';
		//$('#priceOptionLow').val('');
		document.getElementById("priceOptionHigh").value = 'high';
		//$('#priceOptionHigh').val('high');
	}
	document.detailForm.submit();
	//$('form').submit();
}

function fncChangeSearchCondition(currentPage){
	document.getElementById("currentPage").value = currentPage;
	//$('#currentPage').val(currentPage);
   	document.detailForm.submit();
}
function fncaddCategory() {
	popWin 
		= window.open("/product/addCategory.jsp","popWin", "left=300,top=200,width=300,height=200,marginwidth=0,marginheight=0,scrollbars=no,scrolling=no,menubar=no,resizable=no");
}
function fncremoveCategory() {
	popWin 
		= window.open("/product/removeCategory.jsp","popWin", "left=300,top=200,width=300,height=200,marginwidth=0,marginheight=0,scrollbars=no,scrolling=no,menubar=no,resizable=no");
}
function alertFalse() {
	alert("이미 있는 카테고리입니다.");
}

function getProduct(prodNo) {
	$('form').attr('action', '/product/getProduct?prodNo='+prodNo+"&menu=${param.menu}");
	$('form').submit();
}

function isHangulCompleted(input) {
    var pattern = /[\xB0-\xC8][\xA1-\xFE][\xA1-\xFE]/;
    return pattern.test(input);
}

$(function() {
	
	$('a:contains("배송하기")').css('color', 'red');
	
	//autoComplete
	$('input[name=searchKeyword]').on('keyup', function(e) {
		
		if (e.isComposing || e.keyCode === 229) return;
		
		let url = "/app/product/getProdNameList/"+$(this).val();
		$.get(url, function(JSONData, status) {
			
			console.log(JSONData);
			$(function() {
				var availableTags = JSONData;
				$('input[name=searchKeyword]').autocomplete({
					source : availableTags
				});
			});
			
		}, 'json');
		
	});
	
	var body = new Object();
	var appendCnt = 1;
	body.currentPage = $('#currentPage').val()*2;
	body.searchCondition = $('#searchCondition').val();
	body.searchRange;
	if(body.searchCondition == '2') {
		body.searchRange = $('#searchRange').val();
	}
	body.searchKeyword = $('input[name=searchKeyword]').val();
	body.cateNo = $('#cateGoryList').val();
	var priceOptionLow = $('#priceOptionLow').val();
	var priceOptionHigh = $('#priceOptionHigh').val();
	
	//var data = $('form').serialize();
	//alert(data);
	
	//스크롤 발생 이벤트
	//alert($('div#listBody').html());
	$(document).scroll(function() {
		
		if($(this).scrollTop() >= $(document).height() - $('#listBody').height())
		{
			let url = '/app/product/listProduct';
			let data = new Array();
			body.currentPage = body.currentPage + appendCnt;
			if(body.searchCondition == '2') {
				body.searchRange = searchRange;
			}
			if(priceOptionLow == 'low'){
				body.priceOption = 'low';
			}
			if(priceOptionHigh == 'high'){
				body.priceOption = 'high';
			}
			data.push(body);
			let json = JSON.stringify(body);
			console.log(json);
			$.ajax({
				type : 'post',
				url : url,
				data : json,
				contentType : 'application/json',
				headers:{
					"Accept":"application/json",
					"Content-Type" : "application/json"
				},
				success : (JSONData, status) => {
					console.log(JSONData);
					
					if(JSONData.length == 0){
						return;
					}
					
					for(let i = 0; i < 3; i++){
						
						let append = '<div class="col-xs-4">\n'
							+'<div class="thumbnail">\n'
		         			+'<img class="product-image" src="/images/uploadFiles/'+JSONData[i].fileName+'" alt="Generic placeholder thumbnail">\n'
		          			+'<div class="caption">\n'
		            		+'<h3>'+JSONData[i].prodName+'</h3>\n'
		            		+'<p><a href="javascript:getProduct('+JSONData[i].prodNo+')" class="btn btn-primary" role="button" >상세정보보기</a></p>\n'
		          			+'</div>\n'
						    +'</div>\n'
						    +'</div>';
				
						$('div.row').append(append);
						
					}
				}
			});
			
		}
		
	});
	
	//현재 페이지 색 red
	for(var i = 0; i < $('li.movePage_btn a').length; i++){
		//alert($($('li.movePage_btn a')[i]).text());
		if($($('li.movePage_btn a')[i]).text() == ${resultPage.currentPage}){
			$($('li.movePage_btn a')[i]).css('color', 'red');
		}
	}
	
	//alert($($('tr.ct_list_pop td')[2]));
	$('tr.ct_list_pop td.getProdNo_btn').on('click', function() {
		
		//alert($(this).children().val());
		self.location = "/product/getProduct?prodNo="+$(this).children().val()+"&menu=${param.menu }";
		
	});
	
	//서치컨디션에 따라 검색창과 가격범위 변환
	$('#searchCondition').on('change', function() {
		
		if($(this).val() == "2"){
		
			//alert($('input[name="searchCondition"]').html());
			//$('input.ct_input_g').remove();
			$('input.ct_input_g').attr('type', 'hidden');
			$('.search_btn').remove();
			
			var append = '<select id="searchRange" name="searchRange" class="ct_input_g" style="width:200px" onChange="fncGetProductList(${resultPage.currentPage})">'
			+'<option value="0" ${searchVO.searchRange eq "0" ? "selected" : ""}>공짜</option>'
			+'<option value="1" ${searchVO.searchRange eq "1" ? "selected" : ""}>1원~10,000원</option>'
			+'<option value="2" ${searchVO.searchRange eq "2" ? "selected" : ""}>10,001원~100,000원</option>'
			+'<option value="3" ${searchVO.searchRange eq "3" ? "selected" : ""}>100,001원~1,000,000원</option>'
			+'<option value="4" ${searchVO.searchRange eq '4' ? "selected" : ""}>백만원~</option>'
		+'</select>';
			
			//alert(append);
			$(this).parent().append(append);
			
		}else{
			
			//var append = '<input type="text" name="searchKeyword"  class="ct_input_g" style="width:200px; height:19px" />';
			var append2 = '<td align="right" width="70" class="search_btn" >'
				+'<table border="0" cellspacing="0" cellpadding="0">'
				+'<tr>'
				+'<td width="17" height="23">'
				+'<img src="/images/ct_btnbg01.gif" width="17" height="23">'
				+'</td>'
				+'<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">'
				+'<a href="javascript:fncGetProductList(1);">검색</a>'
				+'</td>'
				+'<td width="14" height="23">'
				+'<img src="/images/ct_btnbg03.gif" width="14" height="23">'
				+'</td>'
				+'</tr>'
				+'</table>'
				+'</td>';
			//alert(append);
			//alert(append2);
			
			//$('input.ct_input_g').remove();
			$('.search_btn').remove();
			$('#searchRange').remove();
			//$(this).parent().append(append);
			$('input.ct_input_g').attr('type', 'text');
			$(this).parent().parent().append(append2);
			
		}
		
	});
	
	//ajax
	$('td.btn_extend').css('color', 'red');
	$('td.btn_extend').on('click', function(event) {
		
		//alert($(this).text().trim());
		//alert($(this).attr('id'));
		var thisId = $(this).attr('id');
		
		if($(this).text().trim() == '닫기') {
			
			$(this).html('펼치기<span class="glyphicon glyphicon-menu-down"></span>');
			$('h6').remove();
			return;
			
		}
		
		var prodNo = $(this).parent().children('.getProdNo_btn').children().val();
		var url = "/app/product/getProduct/"+prodNo;
		//alert(url);
		$.get(url, function(JSONData, status) {
			
			var displayValue = "<h6>"
				+"상품명 : "+JSONData.prodName+"<br/>"
				+"상품상세정보 : "+JSONData.prodDetail+"<br/>"
				+"제조일자 : "+JSONData.manuDate+"<br/>"
				+"등록일 : "+JSONData.regDateString+"<br/>"
				+"</h6>";
				//Debug...									
				//alert(displayValue);
				//$('td.btn_extend').html('펼치기<img width="12px" height="12px" src="/images/up_and_down.jpg">');
				//$(this).html('닫기<img width="12px" height="12px" src="/images/up_and_down.jpg">');
				
				$($('td.btn_extend')).html('펼치기<span class="glyphicon glyphicon-menu-down"></span>');
				//alert($(event.target).html());
				$("#"+thisId).html('닫기<span class="glyphicon glyphicon-menu-up"></span>');
				$('h6').remove();
				//alert($('#append_'+userId).text());
				//alert($(event.target).parents().children('#append_'+userId).html());
				$('#append_'+prodNo).html(displayValue);
			
		}, "json");
		
	});
	
	$('tr.ct_list_pop td.getProdNo_btn').css('color', 'red');
	
	$($('tr td.ct_list_b')[1]).css('color', 'red');
	
	//페이지 네비게이션
	$('li.movePage_btn a').on('click', function() {
		
		//alert($(this).next().val());
		fncGetProductList($(this).next().val());
		
	});
	
	//이전 페이지
	$('.pre_btn').on('click', function() {
		if(${resultPage.beginUnitPage} != 1) {
			//alert($(this).next().val());
			fncGetProductList($(this).next().val());
		}else {
			//alert($(this).next().val());
		}
		
	});
	
	//이후 페이지
	$('.next_btn').on('click', function() {
		if(${resultPage.endUnitPage} != ${resultPage.maxPage}) {
			//alert($(this).next().val());
			fncGetProductList($(this).next().val());
		}else {
			//alert($(this).next().val());
		}
		
	});
	
	$('.btn-primary').css('color', 'white');
});

</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/navigationBar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->

<div class="container" id="body" style="width:98%; margin-left:10px;">

<form name="detailForm" action="/product/listProduct?menu=${param.menu }" method="post">

<f:if test="${!empty duplicationCate }">
	<script type="text/javascript">
		alert("이미 있는 카테고리입니다.");
	</script>
</f:if>

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">
					
							상품 목록조회
					
					</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table>

<input type="hidden" id="rmCategory" name="rmCategory" value="0" >
<input type="hidden" id="addCategory" name="addCategory" >

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		
		<td align="left">카테고리
			<select id="cateGoryList" name="category" class="ct_input_g" style="width:120px" onchange="fncGetProductList(${resultPage.currentPage})" > 
				<option value="0" ></option>
				<f:forEach var="item" items="${listCategory }">
					<option value="${item.cateNo }" ${searchVO.cateNo eq item.cateNo ? 'selected' : '' } >
						${item.cateName }
					</option>
				</f:forEach>
			</select>
			<f:if test="${param.menu eq 'manage' }">
			<a href="javascript:fncaddCategory();" id="addCate_btn">추가</a>
			</select>
			<a href="javascript:fncremoveCategory();" id="removeCate_btn">삭제</a>
			</select>
		
		</f:if>
		</td>
		
		<td align="right">
			<select id="searchCondition" name="searchCondition" class="ct_input_g" style="width:80px"> <!--  onChange="fncChangeSearchCondition(${resultPage.currentPage})" --> 
			
			<%-- if(searchVO.getSearchCondition() != null) { --%>
				<f:if test="${!empty searchVO.searchCondition }">
				<option value="1" ${searchVO.searchCondition eq "1" ? 'selected' : '' } >상품명</option>
				<option value="2" ${searchVO.searchCondition eq "2" ? 'selected' : '' } >상품가격</option>
				</f:if>
			<%-- }else { --%>
			<f:if test="${empty searchVO.searchCondition }">
				<option value="1" >상품명</option>
				<option value="2" >상품가격</option>
			</f:if>
			</select>
			<%-- } --%>
			
			<f:choose>
			<%-- if(searchVO.getSearchKeyword() != null) {--%>	
			
			<f:when test="${!empty searchVO.searchCondition and searchVO.searchCondition eq '2'}">
				<select id="searchRange" name="searchRange" class="ct_input_g" style="width:200px" onChange="fncGetProductList(${resultPage.currentPage})">
					<option value="0" ${searchVO.searchRange eq '0' ? 'selected' : ''}>공짜</option>
					<option value="1" ${searchVO.searchRange eq '1' ? 'selected' : ''}>1원~10,000원</option>
					<option value="2" ${searchVO.searchRange eq '2' ? 'selected' : ''}>10,001원~100,000원</option>
					<option value="3" ${searchVO.searchRange eq '3' ? 'selected' : ''}>100,001원~1,000,000원</option>
					<option value="4" ${searchVO.searchRange eq '4' ? 'selected' : ''}>백만원~</option>
				</select>
			</f:when>
																			<%-- <%=searchVO.getSearchKeyword() %> --%>
			<f:when test="${!empty searchVO.searchKeyword }">
			<input type="text" name="searchKeyword"  class="ct_input_g" style="width:200px; height:19px" value=${searchVO.searchKeyword } />
			</f:when>
			<f:otherwise>
			<input type="text" name="searchKeyword"  class="ct_input_g" style="width:200px; height:19px"  />
			</f:otherwise>
			</f:choose>
		</td>
		
		<f:if test="${searchVO.searchCondition != '2' }">
		<td align="right" width="70" class="search_btn" >
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
				
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23">
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						<a href="javascript:fncGetProductList(1);">검색</a>
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
				
				</tr>
			</table>
		</td>
		</f:if>
	</tr>
</table>

&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
<input type="checkBox" id="priceOptionLow" name="low" value="${searchVO.priceOption eq 'low' ? 'low' : '' }" onClick="fncGetProductListLow(1)" ${!empty searchVO.priceOption and searchVO.priceOption eq 'low' ? 'checked' : '' } >가격 낮은 순
<input type="checkBox" id="priceOptionHigh" name="high" value="${searchVO.priceOption eq 'high' ? 'high' : '' }" onClick="fncGetProductListHigh(1)" ${!empty searchVO.priceOption and searchVO.priceOption eq 'high' ? 'checked' : '' } >가격 높은 순


<table class="table">
	<tr>
		<td colspan="11" >전체 ${map.totalCount }<%-- map.get("count") --%> 건수, 현재 ${searchVO.currentPage }<%-- searchVO.getCurrentPage() --%> 페이지</td>
	</tr>
	</table>
	</div>
	
	<div class="container" id="listBody">
	<div class="row">
	<f:forEach var="product" items="${list }">
	<div class="col-xs-4">
	<div class="thumbnail">
		  
		  <!-- carousel 사용부분 -->
		  <!-- <div id="carousel-example-generic-${product.prodNo} }" class="carousel slide" data-ride="carousel" >
		  	<ol class="carousel-indicators" >
		  	<f:forEach var="i" begin="0" end="${fn:length(product.files) - 1 }" >
		  		<li data-target="#carousel-example-generic-${product.prodNo}" data-slide-to="${i }" ${i eq 1 ? "class='active'" : "" } ></li>
		  	</f:forEach>
		  	</ol>
		  	<div class="carousel-inner" role="listbox" >
		  		<f:forEach var="i" begin="0" end="${fn:length(product.files) - 1 }">
		  			<div ${i eq 0 ? "class='item active'" : "class='item'" } >
		  				<img class="d-block w-100" src="/images/uploadFiles/${product.files[i].fileName }" alt="Generic placeholder thumbnail">
		  			</div>
		  		</f:forEach>
		  	</div>
		  	<!-- 화살표 표시 -->
		  	<!-- <a class="left carousel-control" href="#carousel-example-generic-${product.prodNo}" role="button" data-slide="prev">
	          <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
	          <span class="sr-only">Previous</span>
	        </a>
	        <a class="right carousel-control" href="#carousel-example-generic-${product.prodNo}" role="button" data-slide="next">
	          <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
	          <span class="sr-only">Next</span>
	        </a>
		  	</div> -->
          	<img class="product-image" src="/images/uploadFiles/${product.files[0].fileName }" alt="Generic placeholder thumbnail">
          
          <div class="caption">
            <h3>${product.prodName }</h3>
            <p><a href="javascript:getProduct(${product.prodNo })" class="btn btn-primary" role="button" >상세정보보기</a></p>
          </div>
    </div>
    </div>
    </f:forEach>
    </div>
    </div>

<div class="container footer">
<footer class="container-fluid navbar-fixed-bottom">
<table class="paging" width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="center">
		<input type="hidden" id="currentPage" name="page" value="${resultPage.currentPage }"/>
		<input type="hidden" id="menu" name="menu" value="${param.menu }"/>
		
		<nav aria-label="Page navigation">
  				<ul class="pagination">
			    <li ${resultPage.beginUnitPage == 1 ? 'class="disabled"' : '' }>
			      <a href="#" aria-label="Previous" class="pre_btn" >
			        <span aria-hidden="true">&laquo;</span>
			      </a>
			      <input type="hidden" value="${ resultPage.beginUnitPage - 1}">
			    </li>
			    <f:forEach var="i" begin="${resultPage.beginUnitPage }" end="${resultPage.endUnitPage }" >
			    	<li class="movePage_btn">
			    		<a href="#">${i }</a>
			    		<input type="hidden" id="page_${i }" value="${ i}">
			    	</li>
			    </f:forEach>
			    <li ${resultPage.endUnitPage == resultPage.maxPage ? 'class="disabled"' : '' }>
			      <a href="#" aria-label="Next" class="next_btn" >
			        <span aria-hidden="true">&raquo;</span>
			      </a>
			      <input type="hidden" value="${ resultPage.endUnitPage + 1}">
			    </li>
			  </ul>
			</nav>
		
    	</td>
	</tr>
</table>
<!--  페이지 Navigator 끝 -->

</form>
</footer>
</div>



</body>
</html>