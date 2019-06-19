package kr.or.ddit.vo;

import java.io.Serializable;
import java.util.List;

import lombok.Data;

/**
 * 한명의 회원과 한개의 상품에 대해 관계를 형성한 테이블
 *
 */
@Data
public class CartVO implements Serializable{
	private String cart_member;
	private String cart_no;
	private String cart_prod;
	private Integer cart_qty;
	
	private List<ProdVO> prodList;
}
