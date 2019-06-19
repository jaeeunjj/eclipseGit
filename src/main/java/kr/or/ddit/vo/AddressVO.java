package kr.or.ddit.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode(of="addId")
public class AddressVO {
	private String addId;
	private String name;
	private String hp;
	private String mail;
	
}
