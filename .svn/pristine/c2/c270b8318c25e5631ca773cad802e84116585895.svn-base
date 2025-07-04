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
public class StowageVO {
	/** 적재신청 일련번호*/
	private int stowageNo;
	/** 관세대리업무 계약 번호*/
	private String contractNo;
	/** 적재신청 타입 (컨테이너인지 물류창고인지)*/
	private String stowageType;
	/** 적재신청 일시 */
	private Date stowageDate;
	/** 수입필증여부 */ 
	@Convert(converter = BooleanToIntConverter.class)
	private boolean cdValidityYn;
	
	private ContainerVO containerVO;
	private List<ContainerDetailVO> containerDetailList;
	private List<WhDetailVO> whDetailList;
	private WarehouseVO warehouseVO;
	private ShipScheduleVO shipScheduleVO;
	private ShipsVO shipsVO;
	private ProductVO productVO;
}
