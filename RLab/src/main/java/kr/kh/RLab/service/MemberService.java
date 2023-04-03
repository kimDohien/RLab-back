package kr.kh.RLab.service;

import kr.kh.RLab.vo.MemberVO;

public interface MemberService {

	boolean signup(MemberVO member);

	boolean checkId(MemberVO user);

	boolean checkName(MemberVO user);

	MemberVO login(MemberVO member);

	boolean checkPw(MemberVO pw, MemberVO user);

	boolean editUser(MemberVO member, MemberVO user);

}
