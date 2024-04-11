<%@ page contentType="text/html; charset=euc-kr" %>

<%@ page import="spring.domain.User" %>

<%
	User vo=(User)session.getAttribute("user");
	String role="";
	
	if(vo != null) {
		role=vo.getRole();
	}
%>

<html>
<head>
<title>Model2 MVC Shop</title>

<link href="/css/left.css" rel="stylesheet" type="text/css">
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">

function history(){
	popWin = window.open("/history.jsp","popWin","left=300, top=200, width=300, height=200, marginwidth=0, marginheight=0, scrollbars=no, scrolling=no, menubar=no, resizable=no");
}

$(function() {
	
	//alert( $( 'td.Depth03:contains("개인정보조회")' ).html().trim() );
	$( 'td.Depth03:contains("개인정보조회")' ).on('click', function() {
		
		$(window.parent.frames["rightFrame"].document.location).attr("href","/user/getUser/{user.userId}");
		
	});
	
	$( 'td.Depth03:contains("회원정보조회")' ).on('click', function() {
		
		$(window.parent.frames["rightFrame"].document.location).attr("href","/user/listUser");
		
	});
	
	$( 'td.Depth03:contains("판매상품등록")' ).on('click', function() {
		
		$(window.parent.frames["rightFrame"].document.location).attr("href","/product/addPrdouctView");
		
	});
	
	$( 'td.Depth03:contains("판매상품관리")' ).on('click', function() {
		
		$(window.parent.frames["rightFrame"].document.location).attr("href","/product/listProduct?menu=manage");
		
	});
	
	$( 'td.Depth03:contains("상 품 검 색")' ).on('click', function() {
		
		$(window.parent.frames["rightFrame"].document.location).attr("href","/product/listProduct?menu=search");
		
	});
	
	$( 'td.Depth03:contains("구매이력조회")' ).on('click', function() {
		
		$(window.parent.frames["rightFrame"].document.location).attr("href","/purchase/listPurchase");
		
	});
	
	$( 'td.Depth03:contains("최근 본 상품")' ).on('click', function() {
		
		history();
		
	});
	
});

</script>

</head>

<body background="/images/left/imgLeftBg.gif" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  >

<table width="159" border="0" cellspacing="0" cellpadding="0">

<!--menu 01 line-->
<tr>
<td valign="top"> 
	<table  border="0" cellspacing="0" cellpadding="0" width="159" >	
		<% 	if(vo != null){ %>
		<tr>
			<td class="Depth03">
				개인정보조회
			</td>
		</tr>
		<%	}  %>
		<% if(role.equals("admin")){%>
		<tr>
			<td class="Depth03" >
				회원정보조회
			</td>
		</tr>
		<% } %>
		<tr>
			<td class="DepthEnd">&nbsp;</td>
		</tr>
	</table>
</td>
</tr>

<%	if(role.equals("admin")){ %>
<!--menu 02 line-->
<tr>
	<td valign="top"> 
		<table  border="0" cellspacing="0" cellpadding="0" width="159">
			<tr>
				<td class="Depth03">
					판매상품등록
				</td>
			</tr>
			<tr>
				<td class="Depth03">
					판매상품관리
				</td>
			</tr>
			<tr>
				<td class="DepthEnd">&nbsp;</td>
			</tr>
		</table>
	</td>
</tr>
<% } %>

<!--menu 03 line-->
<tr>
	<td valign="top"> 
		<table  border="0" cellspacing="0" cellpadding="0" width="159">
			<tr>
				<td class="Depth03">
					상 품 검 색
				</td>
			</tr>
			<%	if(vo != null && role.equals("user")){%>
			<tr>
				<td class="Depth03">
					구매이력조회
				</td>
			</tr>
			<%  }%>
			<tr>
				<td class="DepthEnd">&nbsp;</td>
			</tr>
			<tr>
				<td class="Depth03">
					최근 본 상품
				</td>
			</tr>
		</table>
	</td>
</tr>

</table>

</body>
</html>
