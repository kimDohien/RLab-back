package kr.kh.RLab.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import kr.kh.RLab.pagination.Criteria;
import kr.kh.RLab.pagination.GatherCriteria;
import kr.kh.RLab.pagination.PageMaker;
import kr.kh.RLab.service.MypageService;
import kr.kh.RLab.service.PetService;
import kr.kh.RLab.vo.BoardVO;
import kr.kh.RLab.vo.EvolutionVO;
import kr.kh.RLab.vo.GatherVO;
import kr.kh.RLab.vo.GrowthVO;
import kr.kh.RLab.vo.MemberVO;
import kr.kh.RLab.vo.PetVO;
import kr.kh.RLab.vo.StudyVO;
import kr.kh.RLab.vo.TagRegisterVO;
import lombok.RequiredArgsConstructor;


@RequiredArgsConstructor
@Controller
@RequestMapping("/mypage")
public class MypageController {
	private final MypageService mypageService;
	private final PetService petService;
	
	//[마이페이지 홈]
	@GetMapping("")
	public ModelAndView mypage(ModelAndView mv, MemberVO member, HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		String userId = user.getMe_id();
		// 이용시간 안내
		
		
		// 펫
		ArrayList<PetVO> petList = petService.selectPetList();
		ArrayList<EvolutionVO> petFile = petService.selectPetFile();
		
		//적립 포인트 데이터 가져오기
		int myPoint = mypageService.getMyPoint(userId);
		
		//나의 스터디 데이터 가져오기
		ArrayList<StudyVO> myStudyList = mypageService.getMainStudyList(userId);
		
		//나의 스크랩 데이터 가져오기
		ArrayList<BoardVO> myScrapList = mypageService.getMainScrapList(userId);
		
		//나의 펫 데려오기
		GrowthVO myPet = mypageService.selectMyPet(userId);
		
		//펫exp가져오기
		GrowthVO petExp = mypageService.selectPetExp(userId);		
		
		//System.out.println("mypoint" + myPoint);
		mv.setViewName("/mypage/mypage");
		mv.addObject("petExp",petExp);
		mv.addObject("myPet",myPet);
		mv.addObject("myPoint", myPoint);
		mv.addObject("myScrapList", myScrapList);
		mv.addObject("myStudyList", myStudyList);
		mv.addObject("petList",petList);
		mv.addObject("petFile",petFile);
		return mv;
	}
	
	
	//[개인정보 수정 > 비밀번호 체크]
	@GetMapping("/pwcheck")
	public ModelAndView pwCheck(ModelAndView mv) {
		mv.setViewName("/mypage/pwcheck");
		return mv;
	}
	
	@PostMapping("/pwcheck")
	public ModelAndView pwCheckPost(ModelAndView mv, MemberVO pw,
			HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		boolean res = mypageService.checkPw(pw, user);
		if(res) {
			mv.setViewName("redirect:/mypage/user");
		}
		else
			mv.setViewName("redirect:/mypage/pwcheck");
		return mv;
	}
	
	
	//[개인정보 수정 > 비밀번호 체크 > 개인정보 수정창]
	@GetMapping("/user")
	public ModelAndView editUser(ModelAndView mv) {
		mv.setViewName("/mypage/edit_user");
		return mv;
	}

	@PostMapping("/user")
	public ModelAndView editUser(ModelAndView mv, MemberVO member, HttpSession session, MultipartFile file) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		String userId = user.getMe_id();
		member.setMe_id(user.getMe_id());	
		
		// 프로필 이미지 변경
		String filePath = "D:/uploadFiles/profile/";
		String originName = file.getOriginalFilename();
		String fileName = userId + "_" + originName;
		File dest = new File(filePath + fileName);
		
		if(originName != "") {
			member.setMe_profile("/" + fileName);
			try {
				file.transferTo(dest);
				boolean isImgEdited = mypageService.editImg(member, user); 
				if(isImgEdited) {
					user.setMe_profile(member.getMe_profile());
					mv.setViewName("redirect:/mypage/pwcheck");
				}else {
					mv.setViewName("redirect:/mypage/edit_user");
				}
			} catch (IllegalStateException e) {
				e.printStackTrace();
				mv.setViewName("redirect:/");
			} catch (IOException e) {
				e.printStackTrace();
				mv.setViewName("redirect:/");
			}	
		}else {
			member.setMe_profile(user.getMe_profile());
		}
		
			
		boolean isEdited = mypageService.editUser(member, user); 
		if(isEdited) {
			user.setMe_name(member.getMe_name());
			user.setMe_pw(member.getMe_pw());
			user.setMe_email(member.getMe_email());
			session.setAttribute("user", user);
			mv.setViewName("redirect:/");
		}else {
			mv.setViewName("redirect:/mypage/user");
			return mv;
		}
		return mv;
	}
	
	
	//[작성글 관리 > 나의 게시글]
	@GetMapping("/mypost_post")
	public ModelAndView mypost(
			ModelAndView mv, HttpSession session, MemberVO member, BoardVO board, Criteria cri){		
		// 세션 정보 가져오기
		MemberVO user = (MemberVO)session.getAttribute("user");
		String memberId = user.getMe_id();
		
		// 아이디로 작성 게시글 목록 가져오기
		ArrayList<BoardVO> myBoardList = mypageService.getBoardListById(memberId, cri);
		
		// 페이지 네이션
		// 로그인한 회원이 작성한 게시글 전체 수 가져오기
		int totalCount = mypageService.getPostBoardTotalCount(memberId);
		PageMaker pm = new PageMaker(totalCount, 2, cri);
		
		mv.addObject("myBoardList", myBoardList);
		mv.addObject("pm", pm);
		mv.setViewName("/mypage/mypost_post");
		return mv;
	}
	
	//[작성글 관리 > 나의 스크랩]
	@GetMapping("/mypost_scrap")
	public ModelAndView mypostScrap(ModelAndView mv, HttpSession session, BoardVO board, MemberVO member, Criteria cri) {
		// 세션 정보 가져오기
		MemberVO user = (MemberVO)session.getAttribute("user");
		String memberId = user.getMe_id();
		
		// 아이디로 스크랩한 게시글 목록 가져오기
		ArrayList<BoardVO> myScrapList = mypageService.getScrapListById(memberId, cri);
		
		// 페이지 네이션
		// 로그인한 회원이 스크랩한 게시글 전체 수 가져오기
		int totalCount = mypageService.getScrapBoardTotalCount(memberId);
		System.out.println(totalCount);
		PageMaker pm = new PageMaker(totalCount, 2, cri);
		
		mv.addObject("myScrapList", myScrapList);
		mv.addObject("pm", pm);
		mv.setViewName("/mypage/mypost_scrap");
		return mv;
	}
	
	//[작성글 관리 > 나의 모집글]
	@GetMapping("/mypost_recruit")
	public ModelAndView mypostRecruit(ModelAndView mv, HttpSession session, GatherVO gather, GatherCriteria cri) {
		// 세션 정보 가져오기
		MemberVO user = (MemberVO)session.getAttribute("user");
		String memberId = user.getMe_id();
		
		// 아이디로 내가 쓴 모집글 가져오기
		ArrayList<GatherVO> myGatherList = mypageService.getGatherListById(memberId, cri);
		
		// 내가 쓴 모집글 스터디의 태그들 가져오기
		ArrayList<TagRegisterVO> tagList = mypageService.selectTagListById(memberId);
		
		// 내가 쓴 모집글의 찜 여부 가져오기
		ArrayList<Integer> wantList = mypageService.selectWantListById(memberId);
		
		// 페이지 네이션		
		int totalCount = mypageService.getGatherTotalCount(memberId);
		System.out.println(totalCount);
		PageMaker pm = new PageMaker(totalCount, 1, cri);
		
		mv.addObject("myGatherList", myGatherList);
		mv.addObject("tagList", tagList);
		mv.addObject("wantList", wantList);
		mv.addObject("pm", pm);
		mv.setViewName("/mypage/mypost_recruit");
		return mv;
	}
	


}