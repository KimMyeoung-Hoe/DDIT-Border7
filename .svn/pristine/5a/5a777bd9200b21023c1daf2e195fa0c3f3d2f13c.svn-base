package kr.or.ddit.vo;

import java.sql.Date;

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
public class MyItemLocationVO {
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
	/** 물류창고 번호 */
	private int whNo;
	/** 물류관리자 번호*/
	private int logistMngNo;
	/** 물류창고 이름*/
    private String whName;
    /** 물류창고 우편번호*/
	private int whPost;
	/** 물류창고 기본주소*/
	private String whAddr;
	/** 물류창고 상세주소*/
	private String whDetailAddr;
	/** 물류창고 타입*/
	private String whType;
	/** 물류창고 부피*/
	private int whVolume;
	/** 물류창고 등록 일시*/
	private Date whRegDate;
	/** 물류창고 이용가격*/
	private int whPrice;
	/** 물류창고 잔여부피*/
	private int residualVolume;
	/** 물류창고 폐업여부*/
	@Convert(converter = BooleanToIntConverter.class)
	private boolean closureYn;
	/** 물류창고 사용가능 여부*/
	@Convert(converter = BooleanToIntConverter.class)
	private boolean whUseYn;
	/** 물류창고 상세일련번호 */
	private int whDetailNo;
	/** 물품 적재일시 */
	private Date whLoadingDate;
	/** 물품창고 진행코드 */
	private String whDetailStatusCode;
	/** 물품 출고일시 */
	private Date whReleaseDate;
	/** 적재신청 물품 개수 */
	private int whDetailStowageQty;
	private String logistMngName;
	private int logistMngPost;
	private String logistMngAddr;
	private String logistMngDetAddr;
	private String logistMngTel;
	/** 컨테이너 일련번호 */
	private int containerNo;
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
	
	/** 컨테이너 사용가능 여부 */
	@Convert(converter = BooleanToIntConverter.class)
	private boolean containerUseYn;
	
	/** 컨테이너 상세 일련번호 */
	private int containerDetailNo;
	/** 선박 일정 번호*/
	private int shipScheduleNo;
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
	/** 적재신청 물품 개수 */
	private int containerDetailStowageQty;
	/** 항구테이블에서 가져온 출발할 이름과 매칭될 부분*/
	private String portFromName;
	/** 항구테이블에서 가져온 도착항 이름과 매칭될 부분 */
	private String portToName;
	/** 물품 운송*/
	private String carrier;
	
	
}
