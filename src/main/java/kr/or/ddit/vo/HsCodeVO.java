package kr.or.ddit.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode(of = "hsCode") // hsCode를 map이나 set(컬렉션) 키값으로 넣을때 필요 
public class HsCodeVO {
	 private String hsCode;				// hs코드명
	 private Date hsRegDate;			// 등록 일
	 private Date hsEndDate;			// 코드 유효기간
	 private String hsKrName;			// 한글 물품명
	 private String hsEnName;			// 영어 물품명
	 private String hsQty;				// 
	 private String hsWeight;			// 단위
	 private String hsExportNatureCode; // 수출 코드
	 private String hsImportNatureCode; // 수입코드
	 private String hsNcc;				// ncc
	 private String hsNccName;			// ncc 이름
	 private String hsTariffRateType; 	// 관세율 종류?
	 private int hsTariffRate; 			// 관세율
}
