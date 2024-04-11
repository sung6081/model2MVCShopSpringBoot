<%@ page contentType="text/html; charset=EUC-KR" %>

<html>
<head>
<title>열어본 상품 보기</title>
</head>

<body>
	당신이 열어본 상품을 알고 있다
<br>
<br>
<%
	
	
	String history = null;
	
	Cookie[] cookies = request.getCookies();
	System.out.println("cookie : "+cookies.length);
	
	if (cookies!=null && cookies.length > 0) {
		System.out.println("\n in if \n");
		for (int i = 0; i < cookies.length; i++) {
			Cookie cookie = cookies[i];
			System.out.println(cookie.getName());
			if (cookie.getName().equals("history")) {
				System.out.println("\n in history \n");
				history = cookie.getValue();
			}
		}
		if (history != null) {
			String[] h = history.split("and");
			for (int i = h.length - 1; i >= 0; i--) {
				if (!h[i].equals("null")) {
%>
	<a href="/product/getProduct.do?prodNo=<%=h[i]%>&menu=search"	target="rightFrame"><%=h[i]%></a>
<br>
<%
				}
			}
		}
	}
%>

</body>
</html>