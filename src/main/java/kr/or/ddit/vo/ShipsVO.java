package kr.or.ddit.vo;

import java.util.List;

import jakarta.persistence.Convert;
import kr.or.ddit.config.BooleanToIntConverter;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ShipsVO {
	/** 선박 고유번호 */
	private int shipNo;
	/** 선박 이름 */
	private String shipName;
	/** 선박 종류 */
	private String shipType;
	/** 선박 크기*/
	private int shipGt;
	/** 선박 이미지 */
	private String shipImg;
	/** 선박 3d 이미지 */
	private String ship3dImg;
	/** 선박 사용 여부 */
	@Convert(converter = BooleanToIntConverter.class)
	private boolean shipYn;
	/** 선박 호출 부호 */
	private String shipCallname;
	
	/** 마린트레픽에서 요청할 아이디값*/
	private int shipId;
	/** 선박 기본 위경도*/
	private String shipLat;
	/** 선박 기본 위경도*/
	private String shipLon;
	
	private List<ShipScheduleVO> shipScheduleVO;
}	
