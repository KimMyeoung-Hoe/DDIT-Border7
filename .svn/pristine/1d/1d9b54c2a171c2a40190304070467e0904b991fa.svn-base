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
public class WarehouseVO {
	// 물류창고 VO
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
	
	
	private ContainerVO containerVO;
	private WhDetailVO whDetailVO;
	private LogistMngVO logistMngVO;
	
}
