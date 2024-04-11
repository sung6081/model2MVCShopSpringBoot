<%@ page contentType="text/html; charset=euc-kr" %>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<script type="text/javascript">
		
	/* function history(){
		popWin = window.open("/history.jsp","popWin","left=300, top=200, width=300, height=200, marginwidth=0, marginheight=0, scrollbars=no, scrolling=no, menubar=no, resizable=no");
	} */
	
	
	$(function() {
		
		$('a:contains("�α׾ƿ�")').attr('href', '/user/logout');
		
		$('a:contains("ȸ������")').attr('href', '/user/addUserView.jsp');
		
		$('a:contains("�α���")').on('click', function() {
			self.location = "/user/login";
		});
		
		$('a:contains("����������ȸ")').on('click', function() {
			self.location = "/user/getUser/${user.userId}";
		});
		
		$('a:contains("ȸ��������ȸ")').on('click', function() {
			self.location = "/user/listUser";
		});
		
		$('a:contains("�ǸŻ�ǰ���")').on('click', function() {
			self.location = "/product/addPrdouctView";
		});
		
		$('ul.dropdown-menu a:contains("�ǸŻ�ǰ����")').on('click', function() {
			self.location = "/product/listProduct?menu=manage";
		});
		
		$('ul.dropdown-menu a:contains("�� ǰ �� ��")').on('click', function() {
			self.location = "/product/listProduct?menu=search";
		});
		
		$('ul.dropdown-menu a:contains("�� ǰ �� ��")').on('click', function() {
			self.location = "/product/listProduct?menu=search";
		});
		
		$('ul.dropdown-menu a:contains("�ֱٺ���ǰ")').on('click', function() {
			popWin = window.open("/history.jsp","popWin","left=300, top=200, width=300, height=200, marginwidth=0, marginheight=0, scrollbars=no, scrolling=no, menubar=no, resizable=no");
		});
		
		$('ul.dropdown-menu a:contains("�����̷���ȸ")').on('click', function() {
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
	         
	         	<!-- Tool Bar �� �پ��ϰ� ����ϸ�.... -->
	             <ul class="nav navbar-nav">
	             <c:if test="${!empty user }">
	              <!--  ȸ������ DrowDown -->
	              <li class="dropdown">
	                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
	                         <span >ȸ������</span>
	                         <span class="caret"></span>
	                     </a>
	                     <ul class="dropdown-menu">
	                         <li><a href="#">����������ȸ</a></li>
	                         
	                         <c:if test="${sessionScope.user.role == 'admin'}">
	                         	<li><a href="#">ȸ��������ȸ</a></li>
	                         </c:if>
	                     </ul>
	                 </li>
	                 
	              <!-- �ǸŻ�ǰ���� DrowDown  -->
	               <c:if test="${sessionScope.user.role == 'admin'}">
		              <li class="dropdown">
		                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
		                         <span >�ǸŻ�ǰ����</span>
		                         <span class="caret"></span>
		                     </a>
		                     <ul class="dropdown-menu">
		                         <li><a href="#">�ǸŻ�ǰ���</a></li>
		                         <li><a href="#">�ǸŻ�ǰ����</a></li>
		                     </ul>
		                </li>
	                 </c:if>
	                 </c:if>
	              <!-- ���Ű��� DrowDown -->
	              <li class="dropdown">
	                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
	                         <span >��ǰ����</span>
	                         <span class="caret"></span>
	                     </a>
	                     <ul class="dropdown-menu">
	                         <li><a href="#">�� ǰ �� ��</a></li>
	                         
	                         <c:if test="${sessionScope.user.role == 'user'}">
	                           <li><a href="#">�����̷���ȸ</a></li>
	                         </c:if>
	                         <c:if test="${!empty user }">
	                         <li class="divider"></li>
	                         
	                         <li><a href="#">�ֱٺ���ǰ</a></li>
	                         </c:if>
	                     </ul>
	                 </li>
	                 
	             </ul>
	             
	             <c:if test="${!empty user }">
	             <ul class="nav navbar-nav navbar-right">
	                <li><a href="#">�α׾ƿ�</a></li>
	            </ul>
	            </c:if>
	            <c:if test="${empty user }">
	             <ul class="nav navbar-nav navbar-right">
	                <li><a href="#">�α���</a></li>
	                <li><a href="#">ȸ������</a></li>
	            </ul>
	            </c:if>
	            
		</div>
		<!-- dropdown hover END -->	       
	    
	</div>
</div>
		<!-- ToolBar End /////////////////////////////////////-->

</body>
