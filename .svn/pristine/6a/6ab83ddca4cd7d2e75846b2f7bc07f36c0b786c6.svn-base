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
public class ContainerDetailVO {

	/** 컨테이너 상세 일련번호 */
	private int containerDetailNo;
	/** 선박 일정 번호*/
	private int shipScheduleNo;
	/** 적재신청 일련번호 */
	private int stowageNo;
	/** 컨테이너 일련번호 */
	private int containerNo;
	/** 물품 적재일시 */
	private Date containerLoadingDate;
	/** 컨테이너상세 진행코드 */
	private String containerDetailStatusCode;
	/** 물품 출고일시 */
	private Date containerReleaseDate;
	/** 물품 출고인 */
	private String exportCarrier;
	/** 컨테이너 적재 물품 부피 */
	private double containerDetailStowageVolume;
	/** 수출입신고필증 유효여부 */
	@Convert(converter = BooleanToIntConverter.class)
	private boolean cdValidityYn;
	/** 적재신청 물품 갯수 */
	private int containerDetailStowageQty;
	/** 항구테이블에서 가져온 출발할 이름과 매칭될 부분*/
	private String portFromName;
	/** 항구테이블에서 가져온 도착항 이름과 매칭될 부분 */
	private String portToName;
	/** 물품 운송*/
	private String carrier;
	
	private int result;
	
	private ProductVO productVO;
	private StowageVO stowageVO;
	private List<ComFileDetailVO> comFileDetailList;
	private ShipsVO shipsVO;
	private ShipScheduleVO shipScheduleVO;
	
}
