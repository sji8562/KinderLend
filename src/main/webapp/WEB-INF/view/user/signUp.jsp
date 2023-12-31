<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
	<title>Contact Us</title>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="description" content="Colo Shop Template">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" type="text/css" href="/css/styles/bootstrap4/bootstrap.min.css">
	<link href="/plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
	<link rel="stylesheet" type="text/css" href="/plugins/OwlCarousel2-2.2.1/owl.carousel.css">
	<link rel="stylesheet" type="text/css" href="/plugins/OwlCarousel2-2.2.1/owl.theme.default.css">
	<link rel="stylesheet" type="text/css" href="/plugins/OwlCarousel2-2.2.1/animate.css">
	<link rel="stylesheet" href="/plugins/themify-icons/themify-icons.css">
	<link rel="stylesheet" type="text/css" href="/plugins/jquery-ui-1.12.1.custom/jquery-ui.css">
	<link rel="stylesheet" type="text/css" href="/css/styles/contact_styles.css">
	<link rel="stylesheet" type="text/css" href="/css/styles/main_styles.css">
	<link rel="stylesheet" type="text/css" href="/css/styles/responsive.css">
	<link rel="stylesheet" type="text/css" href="/css/styles/contact_responsive.css">


	<script src="/js/jquery-3.2.1.min.js"></script>
	<!-- CSS only -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

	<!-- JavaScript Bundle with Popper -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

	<!-- 주소 찾기 -->
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

	<script>

		function addressFind() {
			new daum.Postcode(
					{
						oncomplete: function(data) {
							// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

							// 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
							// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
							var roadAddr = data.roadAddress; // 도로명 주소 변수
							var extraRoadAddr = ''; // 참고 항목 변수

							// 법정동명이 있을 경우 추가한다. (법정리는 제외)
							// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
							if (data.bname !== ''
									&& /[동|로|가]$/g.test(data.bname)) {
								extraRoadAddr += data.bname;
							}
							// 건물명이 있고, 공동주택일 경우 추가한다.
							if (data.buildingName !== ''
									&& data.apartment === 'Y') {
								extraRoadAddr += (extraRoadAddr !== '' ? ', '
										+ data.buildingName : data.buildingName);
							}
							// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
							if (extraRoadAddr !== '') {
								extraRoadAddr = ' (' + extraRoadAddr + ')';
							}

							// 우편번호와 주소 정보를 해당 필드에 넣는다.
							document.getElementById('address').value = roadAddr;
							document.getElementById('postNumber').value = data.zonecode;

							var guideTextBox = document.getElementById("guide");
							// 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.

						}
					}).open();
		}
	</script>

	<script type="text/javascript">
		//인증하기 버튼을 눌렀을 때 동작
		$(document).on("click", "#emailAuth", function() {
			const email = $("#email").val(); //사용자가 입력한 이메일 값 얻어오기
			//Ajax로 전송
			$.ajax({
				url : '/user/EmailAuth',
				data : {
					email : email
				},
				type : 'POST',
				dataType : 'json',
				success : function(result) {
					$('#authCode').css('display', 'block');
					code = result;
					alert("인증 코드가 입력하신 이메일로 전송 되었습니다.");
				}
			});
		});
	</script>
	<script type="text/javascript">
		//인증 코드 비교
		$(document).on("focusout", "#authCode", function() {
			const inputCode = $("#authCode").val(); //인증번호 입력 칸에 작성한 내용 가져오기

			if(Number(inputCode) === code){
				$("#emailAuthWarn").html('인증번호가 일치합니다.');
				$("#emailAuthWarn").css('color', 'green');
				$('#emailAuth').attr('disabled', true);
				$('#email').attr('readonly', true);
				$("#signUpButton").attr("disabled", false);
			}else{
				$("#emailAuthWarn").html('인증번호가 불일치 합니다. 다시 확인해주세요!');
				$("#emailAuthWarn").css('color', 'red');
				$("#signUpButton").attr("disabled", true);
			}
		});
	</script>
	<script type="text/javascript">


		$(function() {
			// 이메일 규칙
			let emailReg = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
			$("#email").on("change", function() {
				if(!emailReg.exec($("#email").val())){
					$("#emailResult").html("이메일 형식을 확인해주세요!<br>ex) kenderrent@naver.com").css("color", "red");
				}else{
					$("#emailResult").html("사용 가능한 이메일 형식 입니다!").css("color", "blue");
				}
			})

			//비밀번호 규칙 (숫자, 영어 대소문자, 특수문자 (!, @, #, $, %) 4~16자리 사용 가능)
			// let passwdReg = /^[a-zA-Z0-9!@#$%]{8,16}$/
			// $("#password").on("change", function() {
			// 	if(!passwdReg.exec($("#password").val())){
			// 		$("#passwd1Result").html("비밀번호 형식을 확인해주세요.<br> 영어, 숫자, 특수문자 (!, @, #, $, %) 8~16자리를 입력 가능").css("color", "red");
			// 	}else{
			// 		$("#passwd1Result").html("사용 가능한 비밀번호 형식 입니다!").css("color", "blue");
			// 	}
			// })
			//
			// // 비밀번호가 일치하는 지 확인
			// $("#password2").on("change", function() {
			// 	if(!passwdReg.exec($("#password2").val())){
			// 		$("#passwd2Result").html("비밀번호 형식을 확인해주세요.<br> 영어, 숫자, 특수문자 (!, @, #, $, %) 8~16자리를 입력 가능").css("color", "red");
			// 	}else{
			// 		if($("#password").val() != $("#password2").val()){
			// 			$("#passwd2Result").html("비밀번호가 일치하지 않습니다!").css("color", "red");
			// 		}else{
			// 			$("#passwd2Result").html("비밀번호가 일치합니다!").css("color", "blue");
			// 		}
			// 	}
			// })

			//이름 규칙
			let nameReg = /^[가-힣]{2,5}$/;
			$("#userName").on("change", function() {
				if(!nameReg.exec($("#userName").val())){
					$("#nameResult").html("이름 형식을 확인해주세요! <br> 한글 2~5자 입력 가능!").css("color", "red");
				}else{
					$("#nameResult").html("사용 가능한 이름 형식 입니다!").css("color", "blue");
				}
			})

		});
		function checkForm() {
			let emailReg = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
			if(!emailReg.exec($("#email").val())){
				alert("이메일을 확인해주세요!");
				return false;
			}
			// let passwdReg = /^[a-zA-Z0-9!@#$%]{8,16}$/
			// if(!passwdReg.exec($("#password").val())){
			// 	alert("비밀번호 형식을 확인해주세요!");
			// 	return false;
			// }
			// if($("#password").val() != $("#password2").val()){
			// 	alert("비밀번호가 일치하는 지 확인해주세요!")
			// 	return false;
			// }
			let nameReg = /^[가-힣]{2,5}$/;
			if(!nameReg.exec($("#userName").val())){
				alert("이름을 확인해주세요!")
				return false;
			}
			if($("#address").val() == ""){
				alert("주소를 입력해주세요!")
				return false;
			}
			if($("#phoneNumber").val() == ""){
				alert("휴대폰번호를 입력해주세요!")
				return false;
			}
			if($("#addressDetail").val() == ""){
				alert("상세주소를 입력해주세요!")
				return false;
			}
		}
	</script>
	<style>
		.signup{
			display: flex;
			flex-wrap: wrap;
			margin-right: -15px;
			margin-left: -15px;
			--bs-gutter-x: 0;
			--bs-gutter-y: 0;
			margin-top: 0;
		}
	</style>
</head>

<body>
<div class="super_container">

	<!-- Header -->

	<jsp:include page="../layout/header.jsp" />

	<div class="fs_menu_overlay"></div>



	<div class="container contact_container">
		<div class="row">
			<div class="col">

				<!-- Breadcrumbs -->

				<div class="breadcrumbs d-flex flex-row align-items-center">
					<ul>
						<li><a href="index.html">Home</a></li>
						<li class="active"><a href="#"><i class="fa fa-angle-right" aria-hidden="true"></i>sign up</a></li>
					</ul>
				</div>

			</div>
		</div>
		<!-- Contact Us -->
		<div class="row">
			<div class="col-lg-4"></div>
			<div class="col-lg-4 get_in_touch_col">
				<%--<div class="row">
                    <div class="logo_container">
                        <a href="/"><img src="/images/Logo2.png" style="max-width: 80%; height: auto;"></a>
                        <br><br><br><br>
                    </div>
                </div>--%>
				<div class="row" style="padding: 30px;">
					<div class="logo_container" style="text-align: center;">
						<a href="/"><img src="/images/Logo2.png" style="max-width: 80%; height: auto;"></a>
						<br><br><br><br>
					</div>
				</div>
				<div class="get_in_touch_contents">
					<form action="/user/signUp" method="post" onsubmit="return checkForm();">
						<div>
							<div class="row">
								<div class="col-lg-8">
									<input id="email" name="email" class="form_input input_email input_ph" type="email"  placeholder="Email" >
									<div id="emailResult"></div>
								</div>
								<div class="col-lg-4">

									<button type="button" id="emailAuth" name="emailAuth" class="btn btn-dark">이메일인증</button>

								</div>
							</div>
							<input id="authCode" name="authCode" style="display: none" class="form_input input_email input_ph" type="text"   placeholder="인증코드 6자리를 입력해주세요">
							<div  id="emailAuthWarn"></div>

							<input id="password" name="password" class="form_input input_website input_ph" type="password"  placeholder="비밀번호입력">
							<div id="passwd1Result"></div>
							<input id="password2" name="password2" class="form_input input_website input_ph" type="password"  placeholder="비밀번호확인">
							<div id="passwd2Result"></div>
							<input id="userName" name="userName" class="form_input input_website input_ph" type="text"  placeholder="이름을 입력해주세요">
							<div id="nameResult"></div>
							<input id="phoneNumber" name="phoneNumber" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" class="form_input input_website input_ph" type="text"  placeholder="핸드폰번호를 입력해주세요(숫자만 입력)">
							<div class="row">
								<div class="col-lg-8">
									<input id="postNumber" name="postNumber" class="form_input input_website input_ph" type="text"  placeholder="우편주소">
								</div>
								<div class="col-lg-4">
									<span id="guide" style="color: #999; display: none"></span>

									<button type="button" onclick="addressFind()" value="주소찾기" class="btn btn-dark">주소찾기</button>


								</div>
							</div>
							<input id="address" name="address" class="form_input input_website input_ph" type="text"  placeholder="주소를 입력해주세요">
							<input id="addressDtail" name="addressDetail" class="form_input input_website input_ph" type="text" placeholder="상세주소를 입력해주세요">
						</div>
						<div>
							<button  type="submit" class="message_submit_btn trans_300" value="Submit" id="signUpButton" disabled="disabled">회원가입</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<!-- Footer -->
	<jsp:include page="../layout/footer.jsp" />

</div>

<script src="/js/jquery-3.2.1.min.js"></script>
<script src="/css/styles/bootstrap4/popper.js"></script>
<script src="/css/styles/bootstrap4/bootstrap.min.js"></script>
<script src="/plugins/Isotope/isotope.pkgd.min.js"></script>
<script src="/plugins/OwlCarousel2-2.2.1/owl.carousel.js"></script>
<script src="/plugins/easing/easing.js"></script>
<script src="/plugins/jquery-ui-1.12.1.custom/jquery-ui.js"></script>
</body>

</html>