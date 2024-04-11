<%@ page contentType="text/html; charset=euc-kr" %>

<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/core" %>

<%--
	boolean result=false;
	if(request.getAttribute("result") != null){
		result=((Boolean)request.getAttribute("result")).booleanValue();
	}
	String userId=(String)request.getAttribute("userId");
--%>

<html>
<head>
<title>카테고리 삭제</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">

function fncRmCate() {
	if(opener) {
		opener.document.detailForm.rmCategory.value = document.getElementById("cateGoryList").value;
		opener.document.detailForm.action = "/product/removeCategory?menu=manage&page=1";
		opener.document.detailForm.submit();
	}
	window.close();
}

$(function() {
	
	$($('.ct_btn01')[0]).on('click', function() {
		
		fncRmCate();
		
	});
	
	$($('.ct_btn01')[1]).on('click', function() {
		
		window.close();
		
	});
	
});

</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<form name="detailForm"  method="post">

<!-- 타이틀 시작 -->
<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37" />
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">삭제할 카테고리</td>
					<td width="20%" align="right">&nbsp;</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table>
<!-- 타이틀 끝 -->

<!-- 등록 테이블시작 -->
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:13px;">
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			카테고리 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<!-- 테이블 시작 -->
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="105">
					<%--	if(result) { --%>
					<select id="cateGoryList" name="category" class="ct_input_g" style="width:120px"> 
							<option value="0" ></option>
							<f:forEach var="item" items="${listCategory }">
							<option value="${item.cateNo }" ${searchVO.cateNo eq item.cateNo ? 'selected' : '' } >
								${item.cateName }
							</option>
							</f:forEach>
							</select>
					<%--	} --%>		
					</td>
					<td>
					</td>
				</tr>
			</table>
			<!-- 테이블 끝 -->
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
</table>
<!-- 등록테이블 끝 -->

<!-- 버튼 시작 -->
<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top:10px;">
	<tr>
		<td align="center">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
				<%--	if(result){ --%>
							
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23" />
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						<a href="javascript:fncRmCate();">삭제</a>
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23" />
					</td>
				<%--	} --%>				
					<td width="30"></td>					
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23" />
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						<a href="javascript:window.close();">닫기</a>
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23" />
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- 버튼 끝 -->
</form>

</body>
</html>