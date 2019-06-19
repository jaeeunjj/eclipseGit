package kr.or.ddit.vo;

import java.io.Serializable;
import java.util.List;

import org.hibernate.validator.constraints.NotBlank;

import kr.or.ddit.common.UpdateHint;
import lombok.Data;

@Data
public class BuyerVO implements Serializable{
	private Long rnum;
	@NotBlank(groups=UpdateHint.class)
	private String buyer_id;
	@NotBlank
	private String buyer_name;
	@NotBlank
	private String buyer_lgu;
	private String buyer_bank;
	private String buyer_bankno;
	private String buyer_bankname;
	private String buyer_zip;
	private String buyer_add1;
	private String buyer_add2;
	@NotBlank
	private String buyer_comtel;
	@NotBlank
	private String buyer_fax;
	@NotBlank
	private String buyer_mail;
	private String buyer_charger;
	private String buyer_telext;
	private String lprod_nm;
	
	private List<ProdVO> prodList;
	
}
