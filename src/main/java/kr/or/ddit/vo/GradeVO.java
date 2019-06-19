package kr.or.ddit.vo;

import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(of="gr_code")
@Data
public class GradeVO {
	private String gr_code;
	private String gr_name;
	
}
