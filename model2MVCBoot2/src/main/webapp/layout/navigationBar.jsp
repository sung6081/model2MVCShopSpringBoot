<%@ page contentType="text/html; charset=euc-kr" %>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<script type="text/javascript">
		
	/* function history(){
		popWin = window.open("/history.jsp","popWin","left=300, top=200, width=300, height=200, marginwidth=0, marginheight=0, scrollbars=no, scrolling=no, menubar=no, resizable=no");
	} */
	
	
	$(function() {
		
		$('a:contains("로그아웃")').attr('href', '/user/logout');
		
		$('a:contains("회원가입")').attr('href', '/user/addUserView.jsp');
		
		$('a:contains("로그인")').on('click', function() {
			self.location = "/user/login";
		});
		
		$('a:contains("개인정보조회")').on('click', function() {
			self.location = "/user/getUser/${user.userId}";
		});
		
		$('a:contains("회원정보조회")').on('click', function() {
			self.location = "/user/listUser";
		});
		
		$('a:contains("판매상품등록")').on('click', function() {
			self.location = "/product/addPrdouctView";
		});
		
		$('ul.dropdown-menu a:contains("판매상품관리")').on('click', function() {
			self.location = "/product/listProduct?menu=manage";
		});
		
		$('ul.dropdown-menu a:contains("상 품 검 색")').on('click', function() {
			self.location = "/product/listProduct?menu=search";
		});
		
		$('ul.dropdown-menu a:contains("상 품 검 색")').on('click', function() {
			self.location = "/product/listProduct?menu=search";
		});
		
		$('ul.dropdown-menu a:contains("최근본상품")').on('click', function() {
			popWin = window.open("/history.jsp","popWin","left=300, top=200, width=300, height=200, marginwidth=0, marginheight=0, scrollbars=no, scrolling=no, menubar=no, resizable=no");
		});
		
		$('ul.dropdown-menu a:contains("구매이력조회")').on('click', function() {
			self.location = "/purchase/listPurchase";	
		});
		
	   // $('.dropdown-toggle').dropdown();
	        
	});
	
	</script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style></style>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
<div class="navbar  navbar-inverse navbar-fixed-top">
	
	<div class="container">
	       
		<a class="navbar-brand" href="/index.jsp"><span class="glyphicon glyphicon-home"></span></a>
		
		<!-- toolBar Button Start //////////////////////// -->
		<div class="navbar-header">
		    <button class="navbar-toggle collapsed" data-toggle="collapse" data-target="#target">
		        <span class="sr-only">Toggle navigation</span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		    </button>
		</div>
		<!-- toolBar Button End //////////////////////// -->
		
	    <!--  dropdown hover Start -->
		<div 	class="collapse navbar-collapse" id="target" 
	       			data-hover="dropdown" data-animations="fadeInDownNew fadeInRightNew fadeInUpNew fadeInLeftNew">
	         
	         	<!-- Tool Bar 를 다양하게 사용하면.... -->
	             <ul class="nav navbar-nav">
	             <c:if test="${!empty user }">
	              <!--  회원관리 DrowDown -->
	              <li class="dropdown">
	                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
	                         <span >회원관리</span>
	                         <span class="caret"></span>
	                     </a>
	                     <ul class="dropdown-menu">
	                         <li><a href="#">개인정보조회</a></li>
	                         
	                         <c:if test="${sessionScope.user.role == 'admin'}">
	                         	<li><a href="#">회원정보조회</a></li>
	                         </c:if>
	                     </ul>
	                 </li>
	                 
	              <!-- 판매상품관리 DrowDown  -->
	               <c:if test="${sessionScope.user.role == 'admin'}">
		              <li class="dropdown">
		                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
		                         <span >판매상품관리</span>
		                         <span class="caret"></span>
		                     </a>
		                     <ul class="dropdown-menu">
		                         <li><a href="#">판매상품등록</a></li>
		                         <li><a href="#">판매상품관리</a></li>
		                     </ul>
		                </li>
	                 </c:if>
	                 </c:if>
	              <!-- 구매관리 DrowDown -->
	              <li class="dropdown">
	                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
	                         <span >상품구매</span>
	                         <span class="caret"></span>
	                     </a>
	                     <ul class="dropdown-menu">
	                         <li><a href="#">상 품 검 색</a></li>
	                         
	                         <c:if test="${sessionScope.user.role == 'user'}">
	                           <li><a href="#">구매이력조회</a></li>
	                         </c:if>
	                         <c:if test="${!empty user }">
	                         <li class="divider"></li>
	                         
	                         <li><a href="#">최근본상품</a></li>
	                         </c:if>
	                     </ul>
	                 </li>
	                 
	             </ul>
	             
	             <c:if test="${!empty user }">
	             <ul class="nav navbar-nav navbar-right">
	                <li><a href="#">로그아웃</a></li>
	            </ul>
	            </c:if>
	            <c:if test="${empty user }">
	             <ul class="nav navbar-nav navbar-right">
	                <li><a href="#">로그인</a></li>
	                <li><a href="#">회원가입</a></li>
	            </ul>
	            </c:if>
	            
		</div>
		<!-- dropdown hover END -->	       
	    
	</div>
</div>
		<!-- ToolBar End /////////////////////////////////////-->

</body>
