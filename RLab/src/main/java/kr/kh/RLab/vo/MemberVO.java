package kr.kh.RLab.vo;

import lombok.Data;

@Data
public class MemberVO {
	String me_id;
	String me_name;
	String me_pw;
	String me_email;
	int me_authority;
	int me_point;
	int me_rest_time;
	int me_use_time;
	
	public MemberVO(String me_id, String me_name, String me_pw, String me_email) {
		this.me_id = me_id;
		this.me_name = me_name;
		this.me_pw = me_pw;
		this.me_email = me_email;
	}

}
