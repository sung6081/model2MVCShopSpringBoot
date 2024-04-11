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
<title>카테고리 추가</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">

function fncRmCate() {
	
	if($($('input:text')[0]).val() == ''){
		alert('추가할 카테고리를 입력해주세요.');
		return;
	}
	
	if(opener) {
		opener.document.detailForm.addCategory.value = document.getElementById("newCate").value;
		opener.document.detailForm.action = "/product/addCategory?menu=manage&page=1";
		opener.document.detailForm.submit();
	}
	window.close();
}

function isHangulCompleted(input) {
    var pattern = /[\xB0-\xC8][\xA1-\xFE][\xA1-\xFE]/;
    return pattern.test(input);
}

$(function() {
	
	$($('input:text')[0]).focus();
	
	$($('input:text')[0]).on('keyup', function(e) {
		
		if (e.isComposing || e.keyCode === 229) return; 
		
		var url = "/app/product/checkCategoryExist/"+$(this).val();
		//alert(url);
		
		//if (isHangulCompleted($(this).val())) {
			$.get(url, function(serverData, status) 
			{
				console.log(serverData);
				console.log(typeof serverData);
				if(serverData) {
					$('.ct_ttl02').html('');
					$($('.ct_btn01')[0]).html('추가');
				}else {
					$('.ct_ttl02').html('이미 있는 카테고리입니다.');
					$($('.ct_btn01')[0]).html('');
				}
			
			});
		//}
		
	});
	
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
					<td width="93%" class="ct_ttl01">추가할 카테고리</td>
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
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td background="/images/ct_line_ttl.gif" height="1"></td>
	</tr>
	
	<tr>
		<td height="32" style="padding-left:12px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:3px;">
				<tr>
					<td width="8" style="padding-bottom:3px;"><img src="/images/ct_bot_ttl01.gif" width="4" height="7"></td>
					<td class="ct_ttl02">
						
					</td>
				</tr>
			</table>
		</td>
	</tr>
	
	<tr>
		<td background="/images/ct_line_ttl.gif" height="1"></td>
	</tr>
	
</table>

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
					<input type="text" id="newCate" name="newCate" class="ct_input_g" style="width:150px; height:19px" >	
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
					<td width="17" height="23" class="add_btn" >
						<img src="/images/ct_btnbg01.gif" width="17" height="23" />
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						<!-- <a href="javascript:fncRmCate();">추가</a> -->
						추가
					</td>
					<td width="14" height="23" class="add_btn" >
						<img src="/images/ct_btnbg03.gif" width="14" height="23" />
					</td>				
					<td width="30"></td>					
					<td width="17" height="23" >
						<img src="/images/ct_btnbg01.gif" width="17" height="23" />
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						<!-- <a href="javascript:window.close();">닫기</a> -->
						닫기
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