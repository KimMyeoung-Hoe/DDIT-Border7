package kr.or.ddit.vo;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import jakarta.persistence.Convert;
import kr.or.ddit.config.BooleanToIntConverter;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class UserVO {
	// 공통유저VO
	private int userNo;
	private String authCode;
	private String userId;
	private String userPw;
	private String userName;
	private String userTel;	
	private String userFax;
	private String userEmail;
	private Date regDate;
	private Date withdrawDate;
	private String userEnable;
	
	//다진 추가
	private String deptTel;
	private String deptName;
	private String jobGradeName;
	
	@Convert(converter = BooleanToIntConverter.class)
	private boolean userStatus;
	@Convert(converter = BooleanToIntConverter.class)
	private boolean smsYn;
	@Convert(converter = BooleanToIntConverter.class)
	private boolean emailYn;
	
	private int sms;
	
	private List<String> authList;
	
	private String profileImg;
	private int unreadMailCount;
	
	// 주체별 VO
	private CCAVO ccaVO;
	private ConsignorVO consignorVO;
	private LogistMngVO logistMngVO;
	private ServantVO servantVO;
	
	// 운전자 리스트
	
	private List<Map<String, String>> carrier = List.of(
		    Map.of("affiliation", "대한통운", "name", "김민수" ,"phone" ,"010-4447-1288"),
		    Map.of("affiliation", "대한통운", "name", "이준호" ,"phone" ,"010-9382-6415"),
		    Map.of("affiliation", "대한통운", "name", "박재현" ,"phone" ,"010-7159-0384"),
		    Map.of("affiliation", "대한통운", "name", "최도윤" ,"phone" ,"010-6274-1852"),
		    Map.of("affiliation", "대한통운", "name", "정우석" ,"phone" ,"010-3842-0961"),
		    Map.of("affiliation", "대한통운", "name", "조현우" ,"phone" ,"010-8207-3549"),
		    Map.of("affiliation", "대한통운", "name", "송지훈" ,"phone" ,"010-1476-9208"),
		    Map.of("affiliation", "대한통운", "name", "한태경" ,"phone" ,"010-5764-3019"),
		    Map.of("affiliation", "한진택배", "name", "한지수" ,"phone" ,"010-2901-8376"),
		    Map.of("affiliation", "한진택배", "name", "박지유" ,"phone" ,"010-6937-4502"),
		    Map.of("affiliation", "한진택배", "name", "이석훈" ,"phone" ,"010-8031-6794"),
		    Map.of("affiliation", "한진택배", "name", "김한수" ,"phone" ,"010-1289-4670")
		);
}
