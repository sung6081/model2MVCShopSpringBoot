<%@ page contentType="text/html; charset=euc-kr" %>

<%@ page import="spring.domain.User" %>

<%
	User user=(User)session.getAttribute("user");
%>

<html>
<head>
<title>Model2 MVC Shop</title>

<link href="/css/left.css" rel="stylesheet" type="text/css">
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">
	
		//==> jQuery 利侩 眠啊等 何盒
		 $(function() {
			 
			//==> login Event 楷搬贸府何盒
			//==> DOM Object GET 3啊瘤 规过 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		 	$( "td[width='115']:contains('login')" ).on("click" , function() {
				//Debug..
				//alert(  $( "td[width='115']:contains('login')" ).html() );
				$(window.parent.frames["rightFrame"].document.location).attr("href","/user/login");
			});
			
			
			//==> login Event 楷搬贸府何盒
			//==> DOM Object GET 3啊瘤 规过 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		 	$( "td[width='56']:contains('logout')" ).on("click" , function() {
				//Debug..
				//alert(  $( "td[width='56']:contains('logout')" ).html() );
				$(window.parent.document.location).attr("href","/user/logout");
			}); 
		});	
		 
	</script>

</head>

<body topmargin="0" leftmargin="0">
 
<table width="100%" height="50" border="0" cellpadding="0" cellspacing="0">
  <tr>
	<td height="10"></td>
	<td height="10" >&nbsp;</td>
  </tr>
  <tr>
    <td width="800" height="30"><h2>Model2 MVC Shop</h2></td>
  </tr>
  <tr>
    <td height="20" align="right" background="/images/img_bg.gif">
	    <table width="200" border="0" cellspacing="0" cellpadding="0">
	        <tr> 
	          <td width="115">
		          <%	if(user == null) { %>
		             login
		          <%}%>        
	          </td>
	          <td width="14">&nbsp;</td>
	          <td width="56">
		          <% if(user != null) {  %>
		            	logout
		           <% } %>
	          </td>
	        </tr>
	      </table>
      </td>
    <td height="20" background="/images/img_bg.gif">&nbsp;</td>
  </tr>
</table>

</body>
</html>