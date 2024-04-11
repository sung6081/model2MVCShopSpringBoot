<%@ page contentType="text/html; charset=euc-kr" %>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- ///////////////////////////// 로그인시 Forward  /////////////////////////////////////// -->
 <c:if test="${ ! empty user }">
 	<jsp:forward page="home.jsp"/>
 </c:if>
 <!-- //////////////////////////////////////////////////////////////////////////////////////////////////// -->


<html>
<head>
<title>Model2 MVC Shop</title>
</head>

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

<body>
	
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="./layout/navigationBar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	
	<div class="container">
	<div class="row">
		<div class="jumbotron">
        	<h1>Model2MVCShop</h1>
        	<p>로그인 후 사용가능...</p>
			<p>로그인 전 검색만 가능합니다.</p>
			<p>회원가입 하세요.</p>
      	</div>
	</div>
	</div>
		

</body>

</html>