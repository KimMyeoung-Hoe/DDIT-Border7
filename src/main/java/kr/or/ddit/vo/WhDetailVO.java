package kr.or.ddit.vo;

import java.sql.Date;
import java.util.List;

import jakarta.persistence.Convert;
import kr.or.ddit.config.BooleanToIntConverter;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class WhDetailVO {
	/** 물류창고 상세일련번호 */
	private int whDetailNo;
	/** 적재신청 일련번호 */
	private int stowageNo;
	/** 물류창고 일련번호 */
	private int whNo;
	/** 물품 적재일시 */
	private Date whLoadingDate;
	/** 물품창고 진행코드 */
	private String whDetailStatusCode;
	/** 수출입 신고필증 일련번호*/
	private String cdNo;
	/** 수출입 신고필증 발급 일시*/
	private Date cdDate;
	/** 입고차 운전자*/
	private String carrier;
	/** 물품 출고일시 */
	private Date whReleaseDate;
	/** 수출입 신고필증 유효여부*/
	@Convert(converter = BooleanToIntConverter.class)
	private boolean cdValidityYn;
	/** 적재신청 물품 갯수 */
	private int whDetailStowageQty;
	
	private WarehouseVO warehouseVO;
	private StowageVO stowageVO;
	private ProductVO productVO;
	private ContainerVO containerVO;
	private CDVO cdVO;
	/** 확장성을 위해 추가한 첨부파일 리스트*/
	private List<ComFileDetailVO> comFileDetailList;
	
	
	/** 프로시저의 결과를 받기위한 변수 */
	private int result;
}
