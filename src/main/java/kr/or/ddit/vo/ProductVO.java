package kr.or.ddit.vo;

import lombok.Data;

/**
 * 물품VO
 */
@Data
public class ProductVO {
	 private int productNo;
	 private int consignorNo;
	 private String hsCode;
	 private String productName;
	 private String productOrigin;
	 private String productQty;
	 private String productWeight;
	 private String productVolume;
	 private int productPrice;
}
