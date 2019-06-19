package kr.or.ddit.vo;

import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(of = "lic_code")
@Data
public class LicenseVO {
	private String lic_code;
	private String lic_name;
}
