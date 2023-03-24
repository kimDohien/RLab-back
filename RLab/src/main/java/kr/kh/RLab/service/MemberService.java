package kr.kh.RLab.service;

import kr.kh.RLab.vo.MemberVO;

public interface MemberService {

	boolean signup(MemberVO member);

	boolean checkId(MemberVO user);

	boolean checkName(MemberVO user);

	void sendEmail(String me_id);

	/*boolean sendCheckMail(String me_id,String me_email);*/


}
