<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="<c:url value='/resources/js/jquery.min.js'></c:url>"></script>
<script src="<c:url value='/resources/js/jquery.validate.min.js'></c:url>"></script>
<script src="<c:url value='/resources/js/additional-methods.min.js'></c:url>"></script>
<link rel="stylesheet" href="<c:url value ='/resources/css/mypage/mypage.css?after'></c:url>">
<link rel="stylesheet" href="<c:url value ='/resources/css/mypage/mypage_common.css?after'></c:url>">
<title>마이 페이지</title>
</head>
<body>
    <!-- pet_store_popup -->
    <div class="pet_store_popup_container display_none">
      <div class="pet_store_popup_box">
        <i class="btn_remove"></i>
        <div class="pet_store_content">
          <div class="popup_title">
            <i class="icon_store"></i> 펫 스토어
          </div>
          <div class="pets_container">
          	<c:forEach	items="${petList}" var="pl">
	            <div class="pet_box">
	            <c:if test="${files.size() != 0}">
		            <c:forEach items="${petFile}" var="pf">
		            	  <c:if test="${pf.ev_level == pl.pe_final_level}">
		            	 	<img src="<c:url value='/download${pf.ev_img}'></c:url>" class="pet_img">
		            	  </c:if>
		            </c:forEach>
		       
	            </c:if>
	              <div class="pet_title">
	                <div class="pet_name"><h2>${pl.pe_name}</h2></div>
	                <div class="pet_level">Lv.${pl.pe_final_level}</div>
	              </div>
	              <div class="pet_reward"><p>보상: </p><p>${pl.pe_prize}</p><i class="icon_reward"></i></div>
	              <button class="btn_bring" id="pet_1">데려오기</button>
	            </div>
            </c:forEach>
          </div>
        </div>
      </div>
      
    </div>
    <!-- background -->
    <div class="background_bbls">
      <div class="big_bbls">
        <div class="bubble"></div>
        <div class="bubble"></div>
        <div class="bubble"></div>
        <div class="bubble"></div>
      </div>
      <div class="small_bbls">
        <div class="bubble"></div>
        <div class="bubble"></div>
      </div>
    </div>
    <div id="total_container">
     
      <!-- main -->
      <main>
        <div id="main_container">
          <!-- aside(left_menu) -->
          <aside class="left_menu_container">
            <nav class="left_menu">
              <a href="<c:url value='/mypage'></c:url>" class="list_item">마이페이지 홈</a>
              <a href="<c:url value='/mypage/pwcheck'></c:url>" class="list_item">개인정보 수정</a>
              <a href="./book_info_ticket.html" class="list_item">예약 관리</a>
              <a href="./mystudy_favorite.html" class="list_item">스터디 관리</a>
              <a href="<c:url value='/mypage/mypost_post'></c:url>" class="list_item">작성글 관리</a>
            </nav>
          </aside>

          <div class="articles">
            <!-- article_top(이용시간, 펫 창) -->
            <article class="article_top">
              <!-- used_hours_container -->
              <div class="article_box" id="used_hours_container">
                
                
                <div class="user_info">
                  <span><strong>"${user.me_name}"</strong> 님 안녕하세요</span>
                </div>
                
				<c:if test="${res}">
	             	<div id="used_hours">
	                  <div class="title">
	                    <h2 class="property_title">이용시간</h2>
	                    <p class="info time_info">
	                      <strong>좌석예약 정보가 없습니다.</strong>
	                      <a class="res_btn" href="<c:url value='/reservation'></c:url>">이용권 예약</a>
	                    </p>
	                  </div>
	                  <div class="gauge gauge_used_hours" style= "background-color:#c1c1c1">
	                  </div>
	                </div>
	              </c:if>  
	                
	               <div id="used_hours">
	                  <div class="title">
	                    <h2 class="property_title">이용시간</h2>
	                    <p class="info time_info">
	                      <strong>~ ${res.re_valid_time_str}</strong>
	                    </p>
	                  </div>
	                  <div class="gauge gauge_used_hours">
	                    <div class="gauge_colored"></div>
	                  </div>
	                </div>


                <div id="pet_exp">
                  <div class="title">
                    <h2 class="property_title">펫 경험치</h2>
                    <p class="info exp_info"><strong>15exp</strong> / 40exp</p>
                  </div>
                  <div class="gauge gauge_pet_exp">
                    <div class="gauge_colored"></div>
                  </div>
                </div>


                <div id="point_container">
                  <div class="my_point">
                    <h2 class="title_point">적립 포인트 : </h2>                  
                    <div class="point_texts">
                      <!-- <p class="title_point">Point</p> -->
                      <div class="num_point">
                        <span class="p_num">${user.me_point}</span>
                        <span class="p_point">P</span>
                      </div>
                    </div>
                    <!-- <i class="icon_info"></i>  -->
                  	<!-- <i class="icon_point"></i> -->
                  </div>
                </div>  

              </div>
              <!-- pet_container -->
              <div class="article_box pet_container">
                <div class="pet_window">
                  <img src="" alt="" class="pet_talk" />
                  <img src="" alt="펫" class="pet" />
                </div>
                <div class="pet_description">
                  <div class="pet_info_container">
                    <div class="this_pet">
                      <h2 class="pet_name">꼬마돌</h2>
                      <div class="pet_reward">
                        ㄴ보상 : 적립금 두 배 <i class="icon_reward"></i>
                      </div>
                    </div>
                    <div class="pet_level">Lv. 20</div>
                  </div>
                    <div id="pet_store_container">
                      <i class="icon_store"></i> 펫 스토어
                    </div>
                </div>
              </div>
              <!-- book_container(나의 예약) -->
              <div class="article_box book_container">
                <div class="title_container">
                  <h3>나의 예약</h3>
                  <div class="book_window">
                    <h4>강남역점</h4>
                    <i class="icon_circle"></i>
                    <div class="book_info">
                      <div class="book_title">좌석</div>
                      <h4>47번</h4>
                    </div>
                    <i class="icon_circle"></i>
                    <div class="book_info">
                      <div class="book_title">사물함</div>
                      <h4>45번</h4>
                    </div>
                    <i class="icon_circle"></i>
                    <div class="book_info">
                      <div class="book_title">미팅룸</div>
                      <h4>47번</h4>
                    </div>
                  </div>
                </div>
              </div>
            </article>

            <!-- article_second(d-day) -->
            <!-- <h2 class="dday_title">D-DAY</h2> -->
            <article class="article_second">
              <div class="dday_container">
                <ul class="list_dday">
                  <li class="item_dday">
                    정보처리기사 필기
                    <p class="dday">D-10</p>
                  </li>
                  <li class="item_dday">
                    정보처리기사 실기
                    <p class="dday">D-40</p>
                  </li>
                  <li class="item_dday">
                    네트워크 관리사 2급 실기
                    <p class="dday">D-40</p>
                  </li>
                </ul>
              </div>
              <p class="plus_dday">+ D-day 추가하기</p>
            </article>

            <!-- article_third(나의 스터디, 나의 스크랩) -->
            <article class="article_third">
              <!-- my_study_container -->
              <div class="article_box my_study_container">
                <div class="title_background"></div>
                <div class="title_container">
                  <h2 class="property_title">나의 스터디</h2>
                  <a href="mystudy_progress.html">
                    <p class="show_plus">더보기+</p>
                  </a>
                </div>
                <ul class="list_container">
	                <c:if test="${myStudyList == null || myStudyList.size() == 0}">
	                  <div class="noPostMsg">
	                  	<p>참여중인 스터디가 없습니다.</p>
	                  </div>
	                </c:if>
	                 <c:forEach items="${myStudyList}" var="mst" varStatus="vs">
	                      	<c:if test="${mst.st_image == null}">
		                 		<a class="link_study" onclick="location.href='<c:url value='/study/${mst.st_num}'/>';">
	                   				<li class="list_item">
			                      		<i class="icon_study"><img src="<c:url value='/resources/img/recruit_thumb.png'></c:url>" width="auto" height="51"></i>
			                      		${mst.st_name}
			                    	</li>
					            </a>
		  		    		</c:if>
		  		    		<c:if test="${mst.st_image != null}">
			  		    		<a class="link_study" onclick="location.href='<c:url value='/study/${mst.st_num}'/>';">
			  		    			<li class="list_item">
			                      		<i class="icon_study"><img src="<c:url value='/download/study/${mst.st_image}'></c:url>" width="auto" height="51"></i>
					                     ${mst.st_name} 		
				  		    		</li>
			  		    		</a>
		  		    		</c:if>
                  </c:forEach>
                </ul>
              </div>
              <!-- my_scrab_container -->
              <div class="article_box my_scrab_container">
                <div class="title_background"></div>
                <div class="title_container">
                  <h2 class="property_title">나의 스크랩</h2>
                  <a href="mypost_scrap.html">
                    <p class="show_plus">더보기+</p>
                  </a>
                </div>
                
                <ul class="list_container">
                  <!-- 스크랩한 게시글 상세로 이동 -->
                  <c:if test="${myScrapList == null || myScrapList.size() == 0}">
	                  <div class="noPostMsg">
	                  	<p>스크랩한 게시물이 없습니다.</p>
	                  </div>
                  </c:if>
                  <c:forEach items="${myScrapList}" var="ms" varStatus="vs">
	                  <a onclick="location.href='<c:url value='/board/detail/${ms.bo_st_num}/${ms.bo_num}'/>';">
	                    <li class="list_item">
	                      <i class="icon_scrab"></i>
	                      <div class="title_scrab">[${ms.st_name}]</div>
	                      <p class="content_scrab">${ms.bo_title}</p>
	                    </li>
	                  </a>
                  </c:forEach>
                  
                </ul>
              </div>
            </article>
          </div>
        </div>
      </main>

    </div>
    <script>
	 // pet_store 모달 열기
	    $(document).on('click', '#pet_store_container', function(e){
	    	console.log('click');
	    	$('.pet_store_popup_container').css('display','flex');
	    })
	
	    // pet_store 모달 닫기
	    $(document).on('click', '.btn_remove', function(e){
	    	console.log('click');
	    	$('.pet_store_popup_container').css('display','none');
	    })
    </script>
</body>
</html>