package kr.or.ddit.vo;

import java.sql.Date;
import java.util.List;

import jakarta.persistence.Convert;
import kr.or.ddit.config.BooleanToIntConverter;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ContainerVO {
	/** 컨테이너 일련번호 */
	private int containerNo;
	/** 컨테이너 주인의 식별번호 */
	private int logistMngNo;
	/** 컨테이너 명칭 */
	private String containerName;
	/** 컨테이너 위치 */
	private String containerLocation;
	/** 컨테이너 사이즈와 타입코드 */
	private String sztpCode;
	/** 컨테이너 위험물정보 */
	private String hazardDamageInfo;
	/** 컨테이너 사이즈 */
	private int containerSize;
	/** 컨테이너 타입 */
	private String containerType;
	/** 컨테이너 이용비용 */
	private int containerPrice;
	
	private double residualVolume;
	
	/** 컨테이너 사용가능 여부 */
	@Convert(converter = BooleanToIntConverter.class)
	private boolean containerUseYn;
	

	
	 private ShipScheduleVO shipScheduleVO; 
	 private UserVO userVO;
	 private WarehouseVO warehouseVO;
	 
}
