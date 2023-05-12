<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    

<link rel="stylesheet" href="<c:url value='/resources/css/study/certification_board.css'></c:url>">
<link rel="stylesheet" href="<c:url value='/resources/css/study/study.css'></c:url>">
<link rel="stylesheet" href="<c:url value='/resources/css/common.css'></c:url>">
 <main>
 <div class="main_container">
           <div class="left_side">
				<!-- 왼쪽 메뉴바 -->
				<div class="left_menu_container">
					<nav class="left_menu">
						<a href="<c:url value='/study/${st_num}'></c:url>" class="list_item">스터디홈</a>
						<a href="<c:url value='/study/todo/${st_num}'></c:url>" class="list_item">투두 리스트</a> 
						<a href="<c:url value='/study/daily/${st_num}'></c:url>" class="list_item">데일리 미션</a> 
						<a href="<c:url value='/study/photo/${st_num}'></c:url>" class="list_item">인증 게시판</a> 
						<a href="<c:url value='/board/list/${st_num}'></c:url>" class="list_item">자유 게시판</a> 
						<a href="<c:url value='/study/management'></c:url>" class="list_item">스터디 관리</a>
					</nav>
				</div>
				<a href="#" class="leave_btn">탈퇴하기</a>
			</div>

                <section>
                    <div class="home_container">
                        <div class="time_line_container_top">
                            <div class="time_line_title"> 인증 게시판</div>
                            	<div class="time_line_cover">
		                           <div class="time_line_container2">
		                           		<div id="modal" class="modal">
									        <div class="modal-content">
									            <span ><img class="close" src="<c:url value='/resources/img/delete.png'></c:url>"></span>
										         <div class="inner_container">
										            <h2>인증하기 양식</h2>
										            <form>
										            	<div class="inner_item">
											            	<label for="category">카테고리 선택</label>
											                <select id="ph_pt_num" name="ph_pt_num">
										                		<c:forEach var="pt" items="${ptList}">
											                    <option value="${pt.pt_num}">${pt.pt_name}</option>
										                		</c:forEach>
											                </select>
										                </div>
										                <div class="inner_item">
											                <label for="photo">사진</label>
											                <input type="file" id="photo" name="photo" accept="image/*">
										                </div>
										                <div class="inner_item">
											                <label for="content">내용입력</label>
											                <textarea id="content" name="content" rows="4" cols="50" maxlength="100" placeholder="내용은 100자 이내"></textarea>
										                </div>
										                
										                <button class="register_btn">등록하기</button>
										           </form>
										        </div>  
					                       </div>
				                    	</div>
								        <c:choose>
								            <c:when test="${empty photos}">
								                <div class="no_certification_message">
								                     오늘의 인증글이 없습니다. <br>
								                     가장 먼저 인증글을 올려보세요!
								                </div>
								            </c:when>
								            <c:otherwise>
								                <div class="today_feed_board">
								                    <c:forEach var="photo" items="${photos}">
								                        <div class="board">
								                            <div class="feed_img"></div>
								                            <div class="feed_name">${photo.me_name}</div>
								                            <div class="feed_date">${photo.ph_register_date_str}</div>
								                            <div class="feed_contents_img">
								                                <img width="350" height="300"		src="<c:url value='/download${photo.ph_img}'/>" alt="이미지">
								                            </div>
								                            <div class="middle_container2">
								                                <span class="feed_date_min"><fmt:formatDate value="${photo.ph_register_date}" pattern="MM/dd" /></span>
								                                <span class="feed_contents">${photo.ph_content}</span>
								                            </div>
								                            <div class="middle_container3">
								                                <input type="hidden" id="like_clicked_image_url" value="<c:url value='/resources/img/like_clicked.png'/>">
								                                <input type="hidden" id="like_off_image_url" value="<c:url value='/resources/img/like_off.png'/>">
								                                <c:choose>
								                                    <c:when test="${likeCounts[photo.ph_num] > 0 && userLikes[photo.ph_num]}">
								                                        <img class="feed_like_img" data-photo-id="${photo.ph_num}" src="<c:url value='/resources/img/like_clicked.png'/>" />
								                                    </c:when>
								                                    <c:otherwise>
								                                        <img class="feed_like_img" data-photo-id="${photo.ph_num}" src="<c:url value='/resources/img/like_off.png'/>" />
								                                    </c:otherwise>
								                                </c:choose>
								                                <div class="feed_like_count">${likeCounts[photo.ph_num]}</div>
								                            </div>
								                        </div>
								                        <hr>
								                    </c:forEach>
								                </div>
								            </c:otherwise>
								        </c:choose>
		    						</div>
		    						<div class="circle_btn">인증하기</div>
		    					</div>
							</div>
						<!--  	 <div id="modal" class="modal">
					        <div class="modal-content">
					            <span class="close">&times;</span>
					            <h2>인증하기 양식</h2>
					            <form>
					                <label for="photo">사진:</label>
					                <input type="file" id="photo" name="photo" accept="image/*">
					                <br>
					                <label for="content">내용입력:</label>
					                <textarea id="content" name="content" rows="4" cols="50" maxlength="500" placeholder="내용은 500자 이내"></textarea>
					                <br>
					                <label for="category">카테고리 선택:</label>
						                <select id="ph_pt_num" name="ph_pt_num">
					                <c:forEach var="pt" items="${ptList}">
						                    <option value="${pt.pt_num}">${pt.pt_name}</option>
					                </c:forEach>
						                </select>
					                <button>등록하기</button>
					           </form>
	                       </div>
                    	</div>-->
                        </div>
                        
                        
                        
                </section>
                <!-- 오른쪽 메뉴 -->
                    <div class="right-container">
                        <!-- 메뉴바 3개 -->
                        <div class="study_link_container">
                            <div class="circle_now cc">
                                <div class="now">NOW</div>
                            </div>
                            <div class="circle_star cc">
                                <img class="star" src="<c:url value='/resources/img/favorite_star_on.png'></c:url>">
                            </div>
                            <div class="my_study_container">
                                <div class="my_list_title">

                                    <div class="my">MY</div>

                                    <!-- <div class="my_study" >나의 스터디<button id="dropdown_btn">▼</button></div> -->
                                </div>
                                <div id="dropdown_list" style="display: none;">
                                    <ul class="dropdown_list_ul">
                                        <li class="dropdown_list_li">
                                            <div class="dropdown_list_contents">
                                                <p class="dropdown_list_contents_title">정보처리기사 스터디</p>
                                                <div class="dropdown_list_contents_on_img"></div>
                                                <div class="dropdown_hr"></div>
                                            </div>
                                        </li>
                                        <li class="dropdown_list_li">
                                            <div class="dropdown_list_contents">
                                                <p class="dropdown_list_contents_title">정보처리기사 스터디</p>
                                                <div class="dropdown_list_contents_off_img"></div>
                                                <div class="dropdown_hr"></div>
                                            </div>
                                        </li>
                                        <li class="dropdown_list_li">
                                            <div class="dropdown_list_contents">
                                                <p class="dropdown_list_contents_title">정보처리기사 스터디</p>
                                                <div class="dropdown_list_contents_off_img"></div>
                                                <div class="dropdown_hr"></div>
                                            </div>
                                        </li>
                                        <li class="dropdown_list_li">
                                            <div class="dropdown_list_contents">
                                                <p class="dropdown_list_contents_title">정보처리기사 스터디</p>
                                                <div class="dropdown_list_contents_off_img"></div>
                                                <div class="dropdown_hr"></div>
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    <!-- 접속상태 -->
                    <div class="accessor">
                        <div class="study_title">정보처리기사 스터디</div>
                        <div class="accessor_container">
                            <div class="circle_accessor">
                                <div class="accessor_on"></div>
                            </div>
                            <div class="study_name">김돌탕</div><span class="your">YOU</span>
                        </div>
                        <div class="accessor_container">
                            <div class="circle_accessor"></div>
                            <div class="study_name">김순연</div>
                        </div>
                        <div class="accessor_container">
                            <div class="circle_accessor"></div>
                            <div class="study_name">김세영</div>
                        </div>
                        <div class="accessor_container">
                            <div class="circle_accessor"></div>
                            <div class="study_name">김도현</div>
                        </div>
                        <div class="accessor_container">
                            <div class="circle_accessor"></div>
                            <div class="study_name">이정현</div>
                        </div>
                        <div class="accessor_container">
                            <div class="circle_accessor"></div>
                            <div class="study_name">가나다</div>
                        </div>
                        <div class="accessor_container">
                            <div class="circle_accessor"></div>
                            <div class="study_name">라마바</div>
                        </div>
                        <div class="accessor_container">
                            <div class="circle_accessor"></div>
                            <div class="study_name">사아나</div>
                        </div>
                        <div class="accessor_container">
                            <div class="circle_accessor"></div>
                            <div class="study_name">s아나</div>
                        </div>
                        <div class="accessor_container">
                            <div class="circle_accessor"></div>
                            <div class="study_name">s아나</div>
                        </div>
                        <div class="accessor_container">
                            <div class="circle_accessor"></div>
                            <div class="study_name">s아나</div>
                        </div>

                    </div>
            </div>
            </div>
</main>
<script>
const likeclickedImageUrl = $("#like_clicked_image_url").val();
const likeOffImageUrl = $("#like_off_image_url").val();
$(document).ready(function() {
    var modal = $("#modal");

    var btn = $(".circle_btn");

    var span = $(".close");

    btn.click(function() {
        modal.show();
    });

    span.click(function() {
        modal.hide();
    });

    $(window).click(function(event) {
        if (event.target == modal[0]) {
            modal.hide();
        }
    });
});
//모달 외 영역 눌리면 인증 양식 모달 닫기
	$(document).mouseup(function (e){
		if($("#modal").has(e.target).length === 0){
			$("#modal").hide();
		}
	});
$("button").click(function(e){
	if(${mf == null}){
		 e.preventDefault();
		    let formData = new FormData();
		    formData.append('photo', $('#photo')[0].files[0]);
		    formData.append('content', $('#content').val());
		    formData.append('ph_pt_num', $('#ph_pt_num').val());
		    formData.append('ph_st_num', ${st_num});
		   // formData.append('mi_num',${mi_num});
		    console.log(formData);
		    $.ajax({
		        type: "POST",
		        url: "<c:url value='/study/photo/insert'/>",
		        data: formData,
		        processData: false,
		        contentType: false,
		        success: function(response){
		            if(response === "success"){
		                alert("인증이 등록되었습니다.");
		                location.reload();
		            }else{
		                alert("인증 등록에 실패했습니다.");
		            }
		        },
		        error: function(e){
		            console.log(e);
		        }
		    });
		   
		}else{
			alert("이미 오늘의 인증을 완료하였습니다.");
			modal.hide();
		}
});


$(".feed_like_img").on("click", function () {
    const li_ph_num = $(this).data("photo-id");
    const $likeCount = $(this).siblings(".feed_like_count");
    const $likeImg = $(this).children(".feed_like_img");

    $.ajax({
    	url: '<c:url value="/study/toggleLike" />',
        type: "POST",
        data: {
            li_ph_num: li_ph_num
        },
        success: function (response) {
            if (response === "inserted" || response === "updated") {
                $likeImg.attr("src", likeclickedImageUrl);
                $likeCount.text(parseInt($likeCount.text()) + 1);
                location.reload();
            } else if (response === "canceled") {
                $likeImg.attr("src", likeOffImageUrl);
                $likeCount.text(parseInt($likeCount.text()) - 1);
                location.reload();
            }
        },
    });
});
</script>
