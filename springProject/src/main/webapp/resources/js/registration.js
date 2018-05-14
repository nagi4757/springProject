var reCheck = true;

$(document).ready(function(){
	
	$("#userName").blur(function(){
		var name = document.getElementById("userName").value;
		if(name == ""){
			document.getElementById("re-nameErr").innerHTML = "필요한 정보입니다.";
		}else{
			data = new FormData();
			data.append("name", name);
			$.ajax({
				type : "POST",
				url : "${path}/member/CheckName.do",
				data : data,
				contentType : "application/json;charset=UTF-8",
				async : true,
				success : function(data) {
					if(data == "success"){
						document.getElementById("re-nameErr").innerHTML = "";
						reCheck = true;
					}else if(data == "failure"){
						document.getElementById("re-nameErr").innerHTML = "이 닉네임은 사용중입니다.";
						reCheck = false;
					}
				}
			});
		}  
	});
	
	$("#userId").focus(function(){
		var name = document.getElementById("userName").value;
		if(name == ""){
			document.getElementById("re-nameErr").innerHTML = "필요한 정보입니다.";
		}
	});
	
	$("#userId").blur(function(){
		var id = document.getElementById("userId").value;
		var RegexId = /^[a-z][a-z0-9_-]{3,11}$/;  
		if(id == ""){
			document.getElementById("re-idErr").innerHTML = "필요한 정보입니다.";
		}else if(!RegexId.test($.trim($("#userId").val()))){
			document.getElementById("re-idErr").innerHTML = "4~12자의 영문(소문자)과 숫자만 사용할 수 있습니다.";
			reCheck = false;
		}else{
			data = new FormData();
			data.append("id", id);
			$.ajax({
				type : "POST",
				url : "${path}/member/CheckId.do",
				data : data,
				contentType : "application/json;charset=UTF-8",
				async : true,
				success : function(data) {
					if(data == "success"){
						document.getElementById("re-idErr").innerHTML = "";
						reCheck = true;
					}else if(data == "failure"){
						document.getElementById("re-idErr").innerHTML = "이 아이디는 사용중입니다.";
						reCheck = false;
					}
				}
			});
		}
	});

	$("#userPw").focus(function(){
		var name = document.getElementById("userName").value;
		var id = document.getElementById("userId").value;
		if(name == ""){
			document.getElementById("re-nameErr").innerHTML = "필요한 정보입니다.";
		}
		if(id == ""){
			document.getElementById("re-idErr").innerHTML = "필요한 정보입니다.";
		}
	});

	$("#userPw").blur(function(){
		var pw = document.getElementById("userPw").value;
		var RegexPw = /^[A-Za-z0-9_-]{6,18}$/;
		if(pw == ""){
			document.getElementById("re-pwErr").innerHTML = "필요한 정보입니다.";
		}else if(!RegexPw.test($.trim($("#userPw").val()))){
			document.getElementById("re-pwErr").innerHTML = "영숫자 6~18줄 이상 입력해주세요.";
			reCheck = false;
		}else{
			document.getElementById("re-pwErr").innerHTML = "";
			reCheck = true;
		}
	});

	$("#userPw2").focus(function(){
		var name = document.getElementById("userName").value;
		var id = document.getElementById("userId").value;
		var pw = document.getElementById("userPw").value;
		if(name == ""){
			document.getElementById("re-nameErr").innerHTML = "필요한 정보입니다.";
		}
		if(id == ""){
			document.getElementById("re-idErr").innerHTML = "필요한 정보입니다.";
		}
		if(pw == ""){
			document.getElementById("re-pwErr").innerHTML = "필요한 정보입니다.";
		}
	});

	$("#userPw2").blur(function(){
		var pw = document.getElementById("userPw").value;
		var pw2 = document.getElementById("userPw2").value;
		if(pw2 == ""){
			document.getElementById("re-pwErr-cof").innerHTML = "필요한 정보입니다.";
		}else if(pw2 != pw){
			document.getElementById("re-pwErr-cof").innerHTML = "비밀번호와 비밀번호 확인을 맞게 입력해주세요.";
			reCheck = false;
		}else {
			document.getElementById("re-pwErr-cof").innerHTML = "";
			reCheck = true;
		}
	});

	$("#userEmail").focus(function(){
		var name = document.getElementById("userName").value;
		var id = document.getElementById("userId").value;
		var pw = document.getElementById("userPw").value;
		var pw2 = document.getElementById("userPw2").value;
		if(name == ""){
			document.getElementById("re-nameErr").innerHTML = "필요한 정보입니다.";
		}
		if(id == ""){
			document.getElementById("re-idErr").innerHTML = "필요한 정보입니다.";
		}
		if(pw == ""){
			document.getElementById("re-pwErr").innerHTML = "필요한 정보입니다.";
		}
		if(pw2 == ""){
			document.getElementById("re-pwErr-cof").innerHTML = "필요한 정보입니다.";
		}
	});

	$("#userEmail").blur(function(){
		var mail = document.getElementById("userEmail").value;
		var RegexMail = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
		if(mail == ""){
			document.getElementById("re-mailErr").innerHTML = "필요한 정보입니다.";
		}else if(!RegexMail.test($.trim($("#userEmail").val()))){
			document.getElementById("re-mailErr").innerHTML = "메일을 제대로 입력해주세요.";
			reCheck = false;
		}else {
			document.getElementById("re-mailErr").innerHTML = "";
			reCheck = true;
		}  
	});
});


function regCheck(){
	var id = document.getElementById("userId").value;
	var pw = document.getElementById("userPw").value;
	var pw2 = document.getElementById("userPw2").value;
	var mail = document.getElementById("userEmail").value;
	var name = document.getElementById("userName").value;

	if(id == ""){
	  document.getElementById("re-idErr").innerHTML = "필요한 정보입니다.";
	  reCheck = false
	}
	if(pw == ""){
	  document.getElementById("re-pwErr").innerHTML = "필요한 정보입니다.";
	  reCheck = false
	}
	if(pw2 == ""){
	  document.getElementById("re-pwErr-cof").innerHTML = "필요한 정보입니다.";
	  reCheck = false
	}
	if(mail == ""){
	  document.getElementById("re-mailErr").innerHTML = "필요한 정보입니다.";
	  reCheck = false
	}
	if(name == ""){
	  document.getElementById("re-nameErr").innerHTML = "필요한 정보입니다.";
	  reCheck = false
	}
	
	return reCheck;
	
}
  




