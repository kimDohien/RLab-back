<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="<c:url value='/resources/css/gather/list.css'></c:url>">
<link rel="stylesheet" href="<c:url value='/resources/css/common.css'></c:url>">
<script src="<c:url value='/resources/js/jquery.min.js'></c:url>"></script>

</script>
<!-- 검색창 -->
<!-- Main -->
<main>
	<!-- 검색창 -->
	<section>
		<div class="search_container">
			<div class="search_content">
				<input type="text" class="search_title" placeholder="제목으로 검색하기">
				<img class="icon_search" src="<c:url value='/resources/img/serch.png'></c:url>" alt="">
			</div>
				<div class="search_content">
				<input type="text" class="search_tag" placeholder="# 태그로 검색하기">
			</div>
			<div class="tag_box">
				<span class="tag_box_name">관련 태그 : </span> <a href="#"	class="hashTag">#자격증</a> 
				<a href="#" class="hashTag">#독서토론모임</a> 
				<a href="#" class="hashTag">#자격증</a> 
				<a href="#" class="hashTag">#자격증</a>
				<a href="#" class="hashTag">#자격증</a>
			</div>
		</div>
	</section>

	<!-- 모집 부분 -->
	<div class="result_container">
		<section>
			<div class="flex_box">
				<div class="menu_nav clearfix">
					<div class="recruit_state">
						<div class="recruit_state_title">모집중</div>
						<input type="checkbox" id="recruit_switch"> 
						<label for="switch" class="switch_label"> 
							<span class="switch_on">ON</span>
                                <span class="switch_btn"></span> 
							<li class="switch_check"><span class="btn_on">ON</span> <span
								class="" btn_off>OFF</span>
								<div class="switch_btn"></div></li>
						</label>
					</div>
					<div class="recruit_tag_box ">
						<span id="tag_title">#태그</span>
						<div class="selectd_tag clearfix">
							<a href="#" class="sel_hashTag">#자격증
								<button class="delete_tag">X</button>
							</a> <a href="#" class="sel_hashTag">#자격증
								<button class="delete_tag">X</button>
							</a> <a href="#" class="sel_hashTag">#자격증
								<button class="delete_tag">X</button>
							</a> <a href="#" class="sel_hashTag">#자격증
								<button class="delete_tag">X</button>
							</a> <a href="#" class="sel_hashTag">#자격증
								<button class="delete_tag">X</button>
							</a> <a href="#" class="sel_hashTag">#자격증
								<button class="delete_tag">X</button>
							</a> <a href="#" class="sel_hashTag">#자격증
								<button class="delete_tag">X</button>
							</a> <a href="#" class="sel_hashTag">#독서토론
								<button class="delete_tag">X</button>
							</a>
						</div>
					</div>
					<div class="line"></div>
					<div class="sel_region clearfix">
						<span class="region_title">지역</span> 
							<a href="#" class="selected">지역 미지정</a> 
							<a href="#">서울 특별시</a> 
							<a href="#">경기도</a> 
							<a href="#">부산 광역시</a> 
							<a href="#">인천 광역시</a> 
							<a href="#">대구 광역시</a> 
							<a href="#">경상북도</a>
							<a href="#">경상남도</a> 
							<a href="#">대전 광역시</a> 
							<a href="#">전라북도</a> 
							<a href="#">전라남도</a> 
							<a href="#">충청북도</a> 
							<a href="#">충청남도</a> 
							<a href="#">광주 광역시</a> 
							<a href="#">강원도</a> 
							<a href="#">울산 광역시</a> 
							<a href="#">제주 특별 자치도</a> 
							<a href="#">세종 특별 자치도</a>
					</div>
				</div>
				<div class="make_rc_box">
					<span>바로 지금,나만의 공부메이트</span>
					<button class="make_project">스터디 만들기</button>
				</div>
			</div>
		</section>
		<section>
			<div class="study_card_container">
				<ul>
					<div class="row_study_card clearfix">
						<c:forEach items="${studyList}" var="st" varStatus="vs">
							<li class="study_card_box add_shadow">
								<a href="<c:url value='/gather/detail'></c:url>">
									<div class="study_img_box">${st_image}</div>
									<div class="study_info">
										<div class="study_tag_info">
											<c:forEach items="${tagList}" var="ta" varStatus="vs">
												<span class="study_tag">#${ta.tr_name}</span> 
											</c:forEach>
										</div>
										<div class="study_recruit_content_box">
											<span class="study_recruit_content">
											 ${st.st_re_name} ${st.st_name}
											</span>
										</div>
										<div class="study_content">
											<div class="study_recruiting">
												<span>모집중</span> 
												<span>${st.st_now_people}</span> 
												<span>/</span> 
												<span>${st.st_total_people}</span>
											</div>
											<div class="like_img"></div>
										</div>
									</div>
								</a>
							</li>
						</c:forEach>
					</div>
				</ul>
				<button class="make_recruit"></button>>모집글 작성</button>
				<div class="page_box clearfix">
					<i class="btn_prev"></i> <span class="page_num selected">1</span> <span
						class="page_num">2</span> <span class="page_num">3</span> <span
						class="page_num">4</span> <span class="page_num">5</span> <i
						class="btn_next"></i>
				</div>
			</div>
		</section>
	</div>
	</section>
	</div>
</main>
<script>
$(document).ready(function() {
	  $('.switch_check').click(function() {
	    $('.switch_btn').toggleClass('switch_btn_on');
	  });
	});
</script>