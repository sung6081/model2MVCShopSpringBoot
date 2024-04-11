<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!DOCTYPE html>
<html>

<head>
	<meta charset="EUC-KR">
	
	<title>회원가입</title>
	
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
		
		//=====기존Code 주석 처리 후  jQuery 변경 ======//
		function fncAddUser() {
			
			var id=$("input[name='userId']").val();
			var pw=$("input[name='password']").val();
			var pw_confirm=$("input[name='password2']").val();
			var name=$("input[name='userName']").val();
			
			
			if(id == null || id.length <1){
				alert("아이디는 반드시 입력하셔야 합니다.");
				return;
			}
			if(pw == null || pw.length <1){
				alert("패스워드는  반드시 입력하셔야 합니다.");
				return;
			}
			if(pw_confirm == null || pw_confirm.length <1){
				alert("패스워드 확인은  반드시 입력하셔야 합니다.");
				return;
			}
			if(name == null || name.length <1){
				alert("이름은  반드시 입력하셔야 합니다.");
				return;
			}
			
			if( pw != pw_confirm ) {				
				alert("비밀번호 확인이 일치하지 않습니다.");
				//document.detailForm.password2.focus();
				$("input:text[name='password2']").focus();
				return;
			}
			
			var value = "";	
			if( $("input:text[name='phone2']").val() != ""  &&  $("input:text[name='phone3']").val() != "") {
				var value = $("option:selected").val() + "-" 
									+ $("input[name='phone2']").val() + "-" 
									+ $("input[name='phone3']").val();
			}
			//Debug..
			alert("phone : "+value)
			$("input:hidden[name='phone']").val( value );
			
			alert("??"+$('form').html());
			$("form[name=detailForm]").attr("method" , "POST").attr("action" , "/user/addUser").submit();
		}
		
		 $(function() {
			 
			 $('.btn-success').css('color', 'white');
			 $('.btn-danger').css('color', 'white');
			
			 //$( ".btn:contains('가입')" ).attr('href', '#');
			 $( ".btn:contains('가입')" ).on("click" , function() {
				//Debug..
				//alert(  $( "td.ct_btn01:contains('가입')" ).html() );
				
				if($('span.possible').html() != ''){
					alert('사용불가능한 아이디 입니다.');
					$('input[name="userId"]').val('');
					//$('input[name="userId"]').focus();
				}else {
					alert('addUser');
					fncAddUser();
				}
			});
		});	
		
		$(function() {
			 $( ".btn:contains('취소')" ).on("click" , function() {
					//Debug..
					//alert(  $( ".btn:contains('취소')" ).html() );
					$("form")[0].reset();
			});
		});	
		
		 $(function() {
			 
			 $("input[name='email']").on("change" , function() {
				
				 var email=$("input[name='email']").val();
			    
				 if(email != "" && (email.indexOf('@') < 1 || email.indexOf('.') == -1) ){
			    	alert("이메일 형식이 아닙니다.");
			     }
			});
			 
		});
		 
		 $(function() {
			 
			 $('input[name=ssn]').on('change', function() {
				 checkSsn();
			 });
			
			 $('input[name="userId"]').on('keyup', function() {
				 
				if($('input[name="userId"]').val() == ''){
					$('span.possible').html('');
				}
				
				var userId = $('input[name="userId"]').val();
				var url = "/app/user/checkDuplication/"+userId; 
				
				$.post(url, function(JSONData, status) {
					 
					 if(JSONData.result){
						 $('span.possible').html('');
					 }else{
						 $('span.possible').html('사용 불가능한 아이디입니다.');
					 }
					 
					 $('span.possible').css('color', 'red');
					 
				 }, "json");
				 
			 });
			 
		 });
		
		function checkSsn() {
			var ssn1, ssn2; 
			var nByear, nTyear; 
			var today; 
	
			ssn = $('input[name=ssn]').val(); 
			if(!PortalJuminCheck(ssn)) {
				alert("잘못된 주민번호입니다.");
				return false;
			}
		}
	
		function PortalJuminCheck(fieldValue){
		    var pattern = /^([0-9]{6})-?([0-9]{7})$/; 
			var num = fieldValue;
		    if (!pattern.test(num)) return false; 
		    num = RegExp.$1 + RegExp.$2;
	
			var sum = 0;
			var last = num.charCodeAt(12) - 0x30;
			var bases = "234567892345";
			for (var i=0; i<12; i++) {
				if (isNaN(num.substring(i,i+1))) return false;
				sum += (num.charCodeAt(i) - 0x30) * (bases.charCodeAt(i) - 0x30);
			}
			var mod = sum % 11;
			return ((11 - mod) % 10 == last) ? true : false;
		}

	</script>		
	
</head>

<body bgcolor="#ffffff" text="#000000">

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/navigationBar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->

<div class="container">
<!-- ////////////////// jQuery Event 처리로 변경됨 ///////////////////////// 
<form name="detailForm"  method="post" >
////////////////////////////////////////////////////////////////////////////////////////////////// -->
<form name="detailForm" method="post" action="/user/addUser">

<!-- <div class="row"> -->

	<div class="container">
		<h3 >회원가입</h3>
	</div>

	<div class="container">
		아이디 <span class="possible" ></span>
		<div class="input-group">
		  <span class="input-group-addon" id="basic-addon1">
		  	<span class="glyphicon glyphicon-user"></span>
		  </span>
		  <input type="text" class="form-control" placeholder="아이디" aria-describedby="basic-addon1" name="userId" >
		</div>
	</div>
	
	<div class="container">
		비밀번호
		<div class="input-group">
		  <span class="input-group-addon" id="basic-addon1">
		  	<span class="glyphicon glyphicon-remove"></span>
		  </span>
		  <input type="password" class="form-control" placeholder="비밀번호" aria-describedby="basic-addon1" name="password" >
		</div>
	</div>
	
	<div class="container">
		비밀번호 확인
		<div class="input-group">
		  <span class="input-group-addon" id="basic-addon1">
		  	<span class="glyphicon glyphicon-remove"></span>
		  </span>
		  <input type="password" class="form-control" placeholder="비밀번호 확인" aria-describedby="basic-addon1" name="password2" >
		</div>
	</div>
	
	<div class="container">
		이름
		<div class="input-group">
		  <span class="input-group-addon" id="basic-addon1">
		  	<span class="glyphicon glyphicon-user"></span>
		  </span>
		  <input type="text" class="form-control" placeholder="이름" aria-describedby="basic-addon1" name="userName" >
		</div>
	</div>
	
	<div class="container">
		주민번호
		<div class="input-group">
		  <span class="input-group-addon" id="basic-addon1">
		  	<span class="glyphicon glyphicon-user"></span>
		  </span>
		  <input type="text" class="form-control" placeholder="주민번호" aria-describedby="basic-addon1" name="ssn" maxLength="13" >
		</div>
	</div>
	
	<div class="container">
		주소
		<div class="input-group">
		 <span class="input-group-addon" id="basic-addon1">
		  	<span class="glyphicon glyphicon-home"></span>
		  </span>
		  <input type="text" class="form-control" placeholder="주소" aria-describedby="basic-addon1" name="addr" >
		</div>
	</div>
	
	<div class="container">
	<div class="row">
	
	<div class="col-xs-2">
		휴대폰 번호
		<div class="input-group">
		  <span class="input-group-addon" id="basic-addon1">
		  	<span class="glyphicon glyphicon-phone"></span>
		  </span>
		  <select class="form-control" aria-describedby="basic-addon1" name="phone1" >
		  	<option value="010" >010</option>
		  	<option value="011" >011</option>
			<option value="016" >016</option>
			<option value="018" >018</option>
			<option value="019" >019</option>
		  </select>
		</div>
	</div>
	<br/>
	
	<div class="col-xs-4">
		<input type="text" class="form-control" name="phone2" maxLength="4" >
	</div>
	<div class="col-xs-4">
		<input type="text" class="form-control" name="phone3" maxLength="4" >
	</div>
	
	</div>
	</div>
	
	<div class="container">
		이메일
		<div class="input-group">
		  <span class="input-group-addon" id="basic-addon1">
		  	@
		  </span>
		  <input type="text" class="form-control" placeholder="이메일" aria-describedby="basic-addon1" name="email" >
		</div>
	</div>

	<br/>
	<div class="container" style="text-align:center">
		<a href="#" class="btn btn-success">가입</a>
		<a href="#" class="btn btn-danger">취소</a>
	</div>

<!-- </div> -->
	
</form>

</div>

</body>

</html>