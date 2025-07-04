package kr.or.ddit.vo;

import java.sql.Date;

import jakarta.persistence.Convert;
import kr.or.ddit.config.BooleanToIntConverter;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ShipScheduleVO {
	/** 선박 일정 일련번호 */
	private String shipScheduleNo;
	/** 선박 번호 */
	private int shipNo;
	/** 선박 출발항 */
	private int portFrom;
	/** 선박 도착항 */
	private int portTo;
	/** 선박 출발일시 */
	private Date shipScheduleDeparture;
	/** 선박 도착일시 */
	private Date shipScheduleArrival;
	
	/** 선박 신청가능여부 */
	@Convert(converter = BooleanToIntConverter.class)
	private boolean shipAvailableYn; 
	
	private ShipsVO shipsVO;
	/** 항구테이블에서 가져온 출발할 이름과 매칭될 부분*/
	private String portFromName;
	/** 항구테이블에서 가져온 도착항 이름과 매칭될 부분 */
	private String portToName;
	/** 컨테이너 등록을 위한 부분*/
	private WarehouseVO warehouseVO;
}
