package kr.or.ddit.vo;

import org.springframework.web.multipart.MultipartFile;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CCAVO {
	// 관세사VO
	private int userNo;
	private String ccaRegistrationNumber;
	private String ccaName;
	private int ccaPost;
	private String ccaAddr;
	private String ccaDetAddr;
	private String ccaTel;
	private String ccaProfileImg;
	private MultipartFile ccapfImg;
	
	private String userTel;
	private String userFax;
	private String userEmail;
	
	private int ccaSanctionScore;						// 누적오류점수
	private int ccaSanctionCount;						// 오류발생건수
	private int ccaDeclCount;							// 전체업무건수
	private List<String> ccaSpecialtyCodeList;			// 주력분야코드 리스트
	private List<String> ccaSpecialtyNameList;			// 주력분야이름 리스트
	
	private int infallible; //무오류 처리율
	
	private List<SanctionVO> sanctionScoreList;			// 제재점수 리스트

	private String searchWord; 							// 검색키워드
	
	private List<SpecialtyVO> specialty;				// 관세사A의 분류 코드
	private List<SpecialtyCodeVO> specialtyNameList;
}
