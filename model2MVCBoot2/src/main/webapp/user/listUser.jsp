<%@ page contentType="text/html; charset=euc-kr" %>

<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import="java.util.List"  %>

<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import="spring.domain.User" %>
<%@ page import="spring.common.Search" %>
<%@page import="spring.common.Page"%>
<%@page import="spring.common.util.CommonUtil"%>

<html>
<head>
<title>회원 목록 조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<!-- 참조 : http://getbootstrap.com/css/   -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
       body > div.container{
            margin-top: 100px;
        }
    </style>
<script type="text/javascript">
	// 검색 / page 두가지 경우 모두 Form 전송을 위해 JavaScrpt 이용  
	
	function fncGetUserList(currentPage) {
		$("#currentPage").val(currentPage)
		$("form").attr("method" , "POST").attr("action" , "/user/listUser").submit();
	}
	
	function fncGetUser(event) {
		self.location = "/user/getUser/"+$(event.target).text()+"?option=list&currentPage=${resultPage.currentPage}";
	}
	
	$(function() {
		
		$('.table-hover').css('background-color', '');
		
		//현재 페이지 색 red
		for(var i = 0; i < $('li.movePage_btn a').length; i++){
			//alert($($('li.movePage_btn a')[i]).text());
			if($($('li.movePage_btn a')[i]).text() == ${resultPage.currentPage}){
				$($('li.movePage_btn a')[i]).css('color', 'red');
			}
		}
		
		//alert($('.ct_list_b[width=150]').html().trim());
		$($('.ct_list_b[width=150]')[0]).css('color', 'red');
		
		//alert($('tr.ct_list_pop:nth-child(3n)').html());
		//$('tr.ct_list_pop:nth-child(4n+2)').css('background-color', 'whitesmoke');
		//$('tr.ct_list_pop td[id=userId]').parent(':nth-child(even)').children('td.ct_line02').css('background-color', 'whitesmoke');
		//$('tr.ct_list_pop:nth-child(4n+2)').css('background-color', 'whitesmoke');
		
		//alert( $($('.ct_list_pop td')[2]).html() );
		$($('.ct_list_pop td[id=userId]')).on('click', function(event){
			 //$($('.ct_list_pop td')[2]).attr('href', '/user/getUser/${vo.userId }?option=list');
			 //self.location = "/user/getUser/"+$(event.target).text()+"?option=list&currentPage=${resultPage.currentPage}";
			 fncGetUser(event);
		 });
		$($('.ct_list_pop td[id=userId]')).css('color', 'red');
		
		//alert($('td.ct_btn01:contains("검색")').text().trime());
		$('td.ct_btn01:contains("검색")').on('click', function() {
			
			fncGetUserList('1');
			
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
			
			var userId = $(this).parent().children('#userId').text().trim();
			var url = "/app/user/getUser/"+userId;
			//alert(url);
			$.get(url, function(JSONData, status) {
				
				var displayValue = "<h6>"
					+"아이디 : "+JSONData.userId+"<br/>"
					+"이  름 : "+JSONData.userName+"<br/>"
					+"이메일 : "+JSONData.email+"<br/>"
					+"ROLE : "+JSONData.role+"<br/>"
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
					$('#append_'+userId).html(displayValue);
				
			}, "json");
			
		});
		
		//페이지 네비게이션
		$('li.movePage_btn a').on('click', function() {
			
			//alert($(this).next().val());
			fncGetUserList($(this).next().val());
			
		});
		
		//이전 페이지
		$('.pre_btn').on('click', function() {
			if(${resultPage.beginUnitPage} != 1) {
				//alert($(this).next().val());
				fncGetUserList($(this).next().val());
			}else {
				//alert("disabled");
			}
			
		});
		
		//이후 페이지
		$('.next_btn').on('click', function() {
			if(${resultPage.endUnitPage} != ${resultPage.maxPage}) {
				//alert($(this).next().val());
				fncGetUserList($(this).next().val());
			}else {
				//alert("disabled");
			}
			
		});
		
	});
	
</script>

</head>

<body bgcolor="#ffffff" text="#000000">

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/navigationBar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->

<div class="container" style="width:98%; margin-left:10px;">

<form name="detailForm" action="/user/listUser" method="post">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">회원 목록조회</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37">
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="right">
			<select name="searchCondition" class="ct_input_g" style="width:80px">
				<%-- <option value="0" <%= (searchCondition.equals("0") ? "selected" : "")%>>회원ID</option> --%>
				<option value="0" ${search.searchCondition eq "0" ? "selected" : "" }>회원ID</option>
				<option value="1" ${search.searchCondition eq "1" ? "selected" : "" }>회원명</option>
				<%-- option value="1" <%= (searchCondition.equals("1") ? "selected" : "")%>>회원명</option>--%>
			</select>														<%-- <%= searchKeyword %> --%>
			<input 	type="text" name="searchKeyword" value="${search.searchKeyword }"  class="ct_input_g" 
							style="width:200px; height:20px" >
		</td>
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						검색
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<table class="table" >
	<tr>
		<td colspan="11" >
			전체  ${resultPage.totalCount } 건수,	현재 ${resultPage.currentPage }<%-- resultPage.getCurrentPage() --%> 페이지 
		</td>
	</tr>
	<tr class="success">
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_list_b"></td>
		<td class="ct_list_b" width="150">회원ID<br>
			<h7 >(id click:상세정보)</h7></td>
		<td class="ct_list_b"></td>
		<td class="ct_list_b" width="150">회원명</td>
		<td class="ct_list_b"></td>
		<td class="ct_list_b">이메일</td>
		<td class="ct_list_b"></td>
	</tr>
	<!-- <tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr> -->
	<f:set var="i" value="1" />
	<f:forEach var="vo" items="${list }">
	
	<tr class="ct_list_pop">
		<td align="center">${i}</td>
		<f:set var="i" value="${i+1 }" />
		<td class="ct_line02"></td>
		<td id="userId" align="center">
			<!-- <a href="/user/getUser/${vo.userId }?option=list">${vo.userId }</a> -->
			${vo.userId }
		</td>
		<td class="ct_line02"></td>
		<td align="center">${vo.userName }</td>
		<td class="ct_line02"></td>
		<td align="center">${vo.email }<span></span>
		</td>
		<td align="right" class="btn_extend" id="btn_extend${i }" >펼치기<span class="glyphicon glyphicon-menu-down"></span>
		</td>		
	</tr>
	<tr id="append_${vo.userId }">
	</tr>
	<%-- <tr>
		<td id="append_${vo.userId }" colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr> --%>
	</f:forEach>
	<%-- } --%>
</table>

<!-- PageNavigation Start... -->
<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top:10px;">
	<tr>
		<td align="center">
		   <input type="hidden" id="currentPage" name="currentPage" value=""${resultPage.currentPage }/>
			
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
<!-- PageNavigation End... -->

</form>
</div>

</body>
</html>