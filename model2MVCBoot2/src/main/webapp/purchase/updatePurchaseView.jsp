
<%@page import="spring.domain.Purchase"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
    <%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>



<%--
Purchase purchaseVO = (Purchase)request.getAttribute("purchaseVO");
System.out.println(purchaseVO);
--%>




<html>
<head>
<link rel="stylesheet" href="/css/admin.css" type="text/css">
<!-- 참조 : http://getbootstrap.com/css/   -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
	<link rel="stylesheet" href="/resources/demos/style.css">
	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	
<title>구매정보 수정</title>

<script type="text/javascript" src="../javascript/calendar.js"></script>
<script type="text/javascript">

$(function() {
	
	//달력
	$("#datepicker").datepicker({
		dateFormat: "yy-mm-dd"
	});
	
	//alert($($('ct_btn01')[0]).text());
	$($('.ct_btn01')[0]).on('click', function() {
		
		$('form').submit();
		
	});
	
	$($('.ct_btn01')[1]).on('click', function() {
		
		history.go(-1);
		
	});
	
});

</script>
<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
       body > div.container{
            margin-top: 100px;
        }
    </style>
</head>

<body bgcolor="#ffffff" text="#000000">

<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/navigationBar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
   	
<div class="container">

<form name="updatePurchase" method="post"	action="/purchase/updatePurchase?page=${param.page}&tranNo=${purchase.tranNo }<%-- purchaseVO.getTranNo() --%>">

<table width="100%" height="37" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif"  width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">구매정보수정</td>
					<td width="20%" align="right">&nbsp;</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table>

<table width="600" border="0" cellspacing="0" cellpadding="0"	align="center" style="margin-top: 13px;">
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">구매자아이디</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${user.userId }<%-- purchaseVO.getBuyer().getUserId() --%></td>
		<input type="hidden" name="buyerId" value="user15">
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">구매물품</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${purchase.purchaseProd.prodName }</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">구매물품 이미지</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01"><img src = "/images/uploadFiles/${purchase.purchaseProd.fileName }" width="50" height="50"/></td></td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">구매방법</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<select 	name="paymentOption" 	class="ct_input_g" style="width: 100px; height: 19px" 
							maxLength="20">
				<%-- if(purchaseVO.getPaymentOption().equals("1")) {--%>
				<!--  option value="1" selected="selected">현금구매</option>
				<option value="2">신용구매</option>
				<%-- }else{ --%>
				<option value="1" >현금구매</option>
				<option value="2" selected="selected">신용구매</option -->
				<%-- } --%>
				<option value="1" ${purchase.paymentOption eq '1' ? 'selected' : '' } >현금구매</option>
				<option value="2" ${purchase.paymentOption eq '2' ? 'selected' : '' } >신용구매</option>
			</select>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">구매자이름</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input 	type="text" name="receiverName" 	class="ct_input_g" style="width: 100px; height: 19px" 
							maxLength="20" value="${purchase.receiverName }<%-- purchaseVO.getReceiverName() --%>" />
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">구매자 연락처</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input 	type="text" name="receiverPhone" class="ct_input_g" style="width: 100px; height: 19px" 
							maxLength="20" value="${purchase.receiverPhone }<%-- purchaseVO.getReceiverPhone() --%>" />
		</td>
	</tr>

	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">구매자주소</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input 	type="text" name="receiverAddr" class="ct_input_g" style="width: 100px; height: 19px" 
							maxLength="20" value="${purchase.divyAddr }<%-- purchaseVO.getDivyAddr() --%>" />
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">구매요청사항</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input 	type="text" name="receiverRequest" 	class="ct_input_g" style="width: 100px; height: 19px" 
							maxLength="20" value="${purchase.divyRequest }<%-- purchaseVO.getDivyRequest() --%>" />
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">배송희망일자</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td width="200" class="ct_write01">
			<input id="datepicker" type="text" readonly="readonly" name="divyDate" value="${purchase.divyDate }" class="ct_input_g" 
						style="width: 100px; height: 19px" maxLength="20"/>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
	<tr>
		<td width="53%"></td>
		<td align="right">
		<table border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="17" height="23">
					<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
				</td>
				<td background="/images/ct_btnbg02.gif" class="ct_btn01"	style="padding-top: 3px;">
					수정
				</td>
				<td width="14" height="23">
					<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
				</td>
				<td width="30"></td>
				<td width="17" height="23">
					<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
				</td>
				<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
					취소
				</td>
				<td width="14" height="23">
					<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</form>
</div>
</body>
</html>