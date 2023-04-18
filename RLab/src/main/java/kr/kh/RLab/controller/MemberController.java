package kr.kh.RLab.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import kr.kh.RLab.service.BoardService;
import kr.kh.RLab.service.MemberService;
import kr.kh.RLab.vo.MemberVO;

@Controller
public class MemberController {
	
	@Autowired
	MemberService memberService;
	@Autowired
	BoardService boardService;
	
	//회원가입
	@RequestMapping(value="/signup", method=RequestMethod.GET)
	public ModelAndView signup(ModelAndView mv) {
		mv.setViewName("/member/signup");
		return mv;
	}
	
	@RequestMapping(value = "/signup",method =RequestMethod.POST )
	public ModelAndView signupPost(ModelAndView mv , MemberVO member) {
		boolean isSignup = memberService.signup(member); 
		if(isSignup) {
			mv.setViewName("redirect:/");
		}else {
			mv.setViewName("redirect:/signup");
			return mv;
		}
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value = "/check/id", method=RequestMethod.POST)
	public Map<String, Object> checkId(@RequestBody MemberVO user) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		boolean res = memberService.checkId(user);
		map.put("res", res);
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "/check/name", method=RequestMethod.POST)
	public Map<String, Object> nameCheck(@RequestBody MemberVO user) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		boolean res = memberService.checkName(user);
		map.put("res", res);
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "/check/email", method=RequestMethod.POST)
	public Map<String, Object> nameEmail(@RequestBody MemberVO user) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		boolean res = memberService.checkEmail(user);
		map.put("res", res);
		return map;
	}
	
	//마이페이지

	@RequestMapping(value="/mypage/mypage", method=RequestMethod.GET)
	public ModelAndView mypage(ModelAndView mv) {
		mv.setViewName("/mypage/mypage");
		return mv;
	}
	
	@RequestMapping(value="/mypage/pwcheck", method=RequestMethod.GET)
	public ModelAndView pwCheck(ModelAndView mv) {
		mv.setViewName("/mypage/pwcheck");
		return mv;
	}
	
	@RequestMapping(value="/mypage/pwcheck", method=RequestMethod.POST)
	public ModelAndView pwCheckPost(ModelAndView mv, MemberVO pw,
			HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		boolean res = memberService.checkPw(pw, user);
		System.out.println(res);
		if(res) {
			mv.setViewName("redirect:/mypage/user");
		}
		else
			mv.setViewName("redirect:/mypage/pwcheck");
		return mv;
	}
	
	@RequestMapping(value="/mypage/user", method=RequestMethod.GET)
	public ModelAndView editUser(ModelAndView mv) {
		mv.setViewName("/mypage/edit_user");
		return mv;
	}

	@RequestMapping(value="/mypage/user", method=RequestMethod.POST)
	public ModelAndView editUser(ModelAndView mv, MemberVO member, HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		member.setMe_id(user.getMe_id());
		System.out.println(member);
		boolean isEdited = memberService.editUser(member, user); 
		if(isEdited) {
			user.setMe_name(member.getMe_name());
			System.out.println(member.getMe_pw());
			user.setMe_pw(member.getMe_pw());
			user.setMe_email(member.getMe_email());
			session.setAttribute("user", user);
			System.out.println("수정된 세션" + user);
			System.out.println("수정성공");
			mv.setViewName("redirect:/");
		}else {
			System.out.println("수정실패");
			mv.setViewName("redirect:/mypage/user");
			return mv;
		}
		return mv;
	}
	
	@RequestMapping(value="/mypage/edit_img", method=RequestMethod.GET)
	public ModelAndView editImg(ModelAndView mv) {
		mv.setViewName("/mypage/edit_img");
		return mv;
	}
	
	@RequestMapping(value="/mypage/edit_img", method=RequestMethod.POST)
	public ModelAndView editImgPost(ModelAndView mv, MemberVO member, HttpSession session, MultipartFile file) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		member.setMe_id(user.getMe_id());
		String filePath = "D:/uploadFiles/";
		String fileName = file.getOriginalFilename();
		File dest = new File(filePath + fileName);
		member.setMe_profile("/"+fileName);
			try {
				file.transferTo(dest);
				boolean isEdited = memberService.editImg(member, user); 
				if(isEdited) {
					user.setMe_profile(member.getMe_profile());
					mv.setViewName("redirect:/mypage/edit_img");
				}else {
					mv.setViewName("redirect:/mypage/edit_img");
				}
			} catch (IllegalStateException e) {
				e.printStackTrace();
				mv.setViewName("redirect:/");
			} catch (IOException e) {
				e.printStackTrace();
				mv.setViewName("redirect:/");
			}				
		return mv;
	}
}