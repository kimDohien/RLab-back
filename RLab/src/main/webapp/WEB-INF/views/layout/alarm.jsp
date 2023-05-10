<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- header -->
<!-- 모달 -->
<style>
	body {
    font-family: Arial, sans-serif;
	}

	.notification_modal {
	    position: fixed;
	    bottom: 20px;
	    right: 20px;
	    display: none;
	    width: 300px;
	    background-color: white;
	    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
	    border-radius: 8px;
	    padding: 20px;
	    z-index: 1000;
	}
	
	.notification_content {
	    display: flex;
	    flex-direction: column;
	}
	
	.notification_content h4 {
	    margin-bottom: 8px;
	}
	
	.notification_content p {
	    margin: 0;
	}
</style>
<header>
    <!-- 로그인 모달창 -->
	<div class="modal_container" id="loginModal">
        <div class="modal_area">
        	<a href="#" class="close_btn">x</a>
        	<div class="login_box">

            <h1>로그인</h1>
            
            <form action="<c:url value='/login'></c:url>" method="post">
              <div class="form_group">
                <!-- <label for="id"></label> -->
                <input type="text" class="form_control" id="id" name="me_id" placeholder="아이디">
              </div>
              <div class="form_group">
                <!-- <label for="pw">비번:</label> -->
                <input type="password" class="form_control" id="pw" name="me_pw" placeholder="비밀번호">
              </div>
              <button class="btn_outline_success col-12">로그인</button>
			  <input type="checkbox" name="autoLogin" value="true"> 자동로그인
              <hr>
              <p class="more_action">
                <a href="#" class="more_action_item 1">아이디 찾기</a> |
                <a href="#" class="more_action_item 2">비밀번호 찾기</a> |
                <a href="<c:url value="/singup"></c:url>" class="more_action_item 3">회원가입</a>
              </p>
            </form>

          </div>
        </div>
      </div>

		<div class="modal_container" id="findIDModal">
		  <div class="modal_area">
		    <a href="#" class="close_btn">x</a>
		    <div class="find_id_box">
		      <h1>아이디 찾기</h1>

		      <form action="<c:url value='/findID'></c:url>" method="post">
		        <div class="form_group">
		          <!-- <label for="email"></label> -->
		          <input type="email" class="form_control" id="email" name="email" placeholder="이메일">
		        </div>
		        <button class="btn_outline_success col-12" type="button" onclick="findID()">아이디 찾기</button>
		      </form>

		    </div>
		  </div>
		</div>

		<div class="modal_container" id="findPWModal">
		  <div class="modal_area">
		    <a href="#" class="close_btn">x</a>
		    <div class="find_pw_box">
		      <h1>비밀번호 찾기</h1>

		      <form action="<c:url value='/findPW'></c:url>" method="post">
		        <div class="form_group">
		          <input type="text" class="form_control" id="findPW_id" name="me_id" placeholder="아이디">
		        </div>
		        <div class="form_group">
		          <input type="email" class="form_control" id="findPW_email" name="email" placeholder="이메일">
		        </div>
		        <button class="btn_outline_success col-12" type="button" onclick="findPW()">전송</button>
		      </form>
		    </div>
		  </div>
		</div>


      <div id="header_container">
        <div class="header_left">
          <a href="<c:url value='/'></c:url>" class="btn_home"><i class="icon_home"></i>LAB</a>
          <nav class="top_menu_container">
         	  <a href="<c:url value='/reservation'></c:url>" class="list_item">예약하기</a>
            <a href="<c:url value='/study/${user.me_study}'></c:url>" class="list_item">스터디</a>
            <a href="<c:url value='/gather/list'></c:url>" class="list_item">모집 게시판</a>
          </nav>
        </div>
        <div class="header_right">
	    	<div class="mypage_container">
	    		<c:if test="${user == null}">
            		<div class="join_box">
            			<a href="#" class="login_modal">로그인</a>
           				<a href="<c:url value='/signup'></c:url>" class="signup_btn">회원가입</a>
           			</div>
        		</c:if> 
		        <c:if test="${user != null}">		  		       
     				<form action="<c:url value='/logout'></c:url>" method="post">     
		  				<div class="logout_box">
              				<a class="logout_btn">로그아웃</a>
              				<div class="alarm_bell_box">
              					<div class="new_dot bell_dot"></div>
		  		    			<img class="alram_img" src="<c:url value='/resources/img/alram.png'></c:url>" width="auto" height="20">
		  		    			<span class="blind">알림</span>
		  		    		</div>
		  		    		<a href="<c:url value='/mypage'></c:url>" class="icon_mypage">
		  		    			<c:if test="${user.me_profile == null}">
		  		    				<img class="mypage_img" src="<c:url value='/resources/img/user.png'></c:url>" width="auto" height="40">
		  		    				<span class="blind">마이페이지</span>
		  		    			</c:if>
		  		    			
		  		    			<c:if test="${user.me_profile != null}">
			  		    			<img class="mypage_img" src="<c:url value='/download${user.me_profile}'></c:url>" width="auto" height="40">
			  		    			<span class="blind">마이페이지</span>
		  		    			</c:if>
			  		    	</a>
            			</div>    
              		</form>
		        </c:if>
        	</div>
        </div>
    </div>	
	<div id="notificationModal" class="notification_modal">
        <div class="notification_box">
            <h4 class="notification_title">알림</h4>
            <span class="notification_content"></span>
        </div>
    </div>
	<div class="alarm_modal" id="alarmModal" style=" max-height: 200px; overflow-y: auto;">	
	    <c:forEach var="alarm" items="${alarm}">
	   	    <c:if test="${alarm.al_view == 0}">
				<a class="modal_content" href="#">		   
				    <img class="alarm_remove" data-num="${alarm.al_num}" src="<c:url value='/resources/img/delete.png'></c:url>" width="auto" height="20">
			    	<div class="alarm_content_box">
				    	<div class="new_dot"></div>
				        <p>${alarm.al_content}</p>
			    	</div>  
	   			</a>
	   		</c:if>
		    <c:if test="${alarm.al_view == 1}">
				<a class="modal_content read_content" href="#">		   
				    <img class="alarm_remove" data-num="${alarm.al_num}" src="<c:url value='/resources/img/delete.png'></c:url>" width="auto" height="20">
			        <p>${alarm.al_content}</p>
	   			</a>
	   		</c:if>
	    </c:forEach> 
	</div> 
</header>
<script><!-- 알림 -->
$(document).ready(function() {
	// 알람 누르면 알람 모달 보이기
	$('.alram_img').click(
	function() {
		$('#alarmModal').show();
	})
});

// 모달 외 영역 눌리면 알림 모달 닫기
$(document).mouseup(function (e){
	if($("#alarmModal").has(e.target).length === 0){
		$("#alarmModal").hide();
	}
});
//알림 삭제 버튼
$('.alarm_remove').click(function(){
	let al_num = $(this).data('num');
	$.ajax({
        url: '<c:url value="/delete/alarm/'+al_num+'"></c:url>',
        type: 'POST',
        success: function() {
            location.reload();
        },
        error: function() {
            console.log("Delete Alarm request failed");
        }
    });
});

		
// 로그아웃 버튼 클릭 이벤트
$("#logout_btn").on("click", function() {
    $.ajax({
        url: '/logout',
        type: 'POST',
        success: function() {
            location.reload();
        },
        error: function() {
            console.log("Logout request failed");
        }
    });
});

$('.login_modal').click(function(e) {
  e.preventDefault();
  $('#loginModal').show();
});

$('.more_action_item.1').click(function(e) {
  e.preventDefault();
  $('#loginModal').hide();
  $('#findIDModal').show();
});

$('.more_action_item.2').click(function(e) {
  e.preventDefault();
  $('#loginModal').hide();
  $('#findPWModal').show();
});

$('.close_btn').click(function(e) {
  e.preventDefault();
  $('.modal_container').hide();
});

$('.logout_btn').click(function(e) {
	e.preventDefault();
	$(this).closest('form').submit();
});

function findPW() {
  let id = $("#findPW_id").val();
  let email = $("#findPW_email").val();
  $.ajax({
    type: "POST",
    url: "<c:url value='/findPW'/>",
    data: {
      id: id,
      email: email
    },
    success: function(response) {
      if (response === "found") {
        alert("이메일로 임시번호를 보냈습니다.");
      } else {
        alert("해당 아이디와 이메일로 등록된 정보가 없습니다.");
      }
    },
    error: function() {
      alert("이메일로 전송이 실패 했습니다.");
    }
  });
}

function findID() {
  let email = $("#email").val();
  $.ajax({
    type: "POST",
    url: "<c:url value='/findID'/>",
    data: {
      email: email
    },
    success: function(response) {
      if (response === "found") {
        alert("이메일로 아이디를 보냈습니다.");
      } else {
        alert("해당 이메일로 등록된 아이디가 없습니다.");
      }
    },
    error: function() {
      alert("이메일로 전송이 실패 했습니다.");
    }
  });
}

function connect() {

    const userId = "${user.me_id}"; 
    console.log(userId);
    const connectUrl = "<c:url value='/connect' />" + "?id=" + userId;
    const source = new EventSource(connectUrl);
    
    source.onopen = function() {
        console.log("SSE connection opened");
    };
    
    source.addEventListener("connect", function(event) {
        console.log("Received connect event:", event.data);
    });
    
    source.onerror = function(event) {
        console.log("SSE error:", event);
    };
    source.addEventListener("newComment", function (event) {
    	//이벤트가 일어날 일을 여기밑에다가 쓰기
	   const data = JSON.parse(event.data);
	    	console.log(event);
		const title = "새로운 댓글";
		const message = '게시글에 댓글이 달렸습니다.';
		showModal(title, message);
		reloadAlarmModal();
		setTimeout(function() {
		    hideModal();
		}, 5000); 
	 	//console.log("Received newComment event:", data);
	 	//showNotification(message);
	 });
    
    source.addEventListener("newLike", function (event) {
        // 이벤트가 발생할 때 여기에 코드 작성
        const data = JSON.parse(event.data);
        const title = "좋아요 알림";
        const message = '게시글에 좋아요가 추가되었습니다.';
        showModal(title, message);

        setTimeout(function() {
            hideModal();
        }, 5000);
        //console.log("Received newLike event:", data);
        //showNotification(data.message);
    });
    
    source.addEventListener("joinStudy", function (event) {
        // 이벤트가 발생할 때 여기에 코드 작성
        //const data = JSON.parse(event.data);
        const title = "스터디 가입 알림";
        const message = '스터디에 새로운 회원이 가입했습니다. 스터디관리로 이동하여 확인해주세요. .';
        showModal(title, message);

        setTimeout(function() {
            hideModal();
        }, 5000);
        //console.log("Received joinStudy event:", data);
        //showNotification(data.message);
    });
    
    source.addEventListener("leaveStudy", function (event) {
        // 이벤트가 발생할 때 여기에 코드 작성
        //const data = JSON.parse(event.data);
        const title = "스터디 탈퇴 알림";
        const message = '스터디원이 스터디를 탈퇴하였습니다. 스터디관리로 이동하여 확인해주세요.';
        showModal(title, message);

        setTimeout(function() {
            hideModal();
        }, 5000);
        //console.log("Received leaveStudy event:", data);
        //showNotification(data.message);
    });
    
    source.addEventListener("authorizeStudy", function (event) {
        // 이벤트가 발생할 때 여기에 코드 작성
        //const data = JSON.parse(event.data);
        const title = "스터디장 임명";
        const message = '새로운 스터디장으로 임명되었습니다. 스터디관리로 이동하여 확인해주세요.';
        showModal(title, message);

        setTimeout(function() {
            hideModal();
        }, 5000);
        //console.log("Received authorizeStudy event:", data);
        //showNotification(data.message);
    });
}

connect();
	
function reloadAlarmModal(){
	$("#alarmModal").load(location.href);
}
 
function showModal(title, message) {
    $(".notification_title").text(title);
    $(".notification_content").text(message);
    $("#notificationModal").fadeIn(300);
}

function hideModal() {
    $("#notificationModal").fadeOut(300);
}

/*
$(document).ready(function () {
    if ('${board.bo_num}' == '')
      return;
    const source = new EventSource(`/sse/new/comment/${bo_num}`);

    source.onopen = function () {
      console.log("SSE connection opened");
    };

    source.addEventListener("newComment", function (event) {
      const data = JSON.parse(event.data);
      console.log("Received newComment event:", data);
      showNotification(data.message);
    });

    source.onerror = function (event) {
      console.log("SSE error:", event);
    };
    
    const sourceNewLike = new EventSource(`/sse/new/photo/${ph_num}`);

    sourceNewLike.onopen = function () {
        console.log("SSE connection for newLike opened");
    };

    sourceNewLike.addEventListener("newLike", function (event) {
        const data = JSON.parse(event.data);
        console.log("Received newLike event:", data);
        showNotification(data.message);
    });

    sourceNewLike.onerror = function (event) {
        console.log("SSE error for newLike:", event);
    };
 });
 */
</script>

