package kr.or.ddit.servant.service;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import kr.or.ddit.contract.service.IContractService;
import kr.or.ddit.mapper.IMyMailMapper;
import kr.or.ddit.servant.mapper.IServantMapper;
import kr.or.ddit.service.IMyMailService;
import kr.or.ddit.user.mapper.IUserMapper;
import kr.or.ddit.util.QRCodeImage;
import kr.or.ddit.util.UploadFileUtils;
import kr.or.ddit.util.mapper.IUtilMapper;
import kr.or.ddit.vo.BwVO;
import kr.or.ddit.vo.BwhVO;
import kr.or.ddit.vo.CCAVO;
import kr.or.ddit.vo.CDVO;
import kr.or.ddit.vo.ConsignorVO;
import kr.or.ddit.vo.ContractVO;
import kr.or.ddit.vo.DeclVO;
import kr.or.ddit.vo.HCVO;
import kr.or.ddit.vo.LogistMngVO;
import kr.or.ddit.vo.MyMailVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.QrntVO;
import kr.or.ddit.vo.SanctionVO;
import kr.or.ddit.vo.TaxVO;
import kr.or.ddit.vo.UserVO;
import kr.or.ddit.vo.WhSetionVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ServantServiceImpl implements IServantService{

	@Autowired
	private IServantMapper servantMapper;
	
	@Autowired
	private IContractService contractMapper;
	
	@Autowired
	private IUtilMapper utilMapper;
	
	@Autowired
	private IMyMailMapper myMailMapper;
	
	@Autowired
	private IMyMailService myMailService;
	
	@Autowired
	private IUserMapper userMapper;
	
	@Autowired
	private PasswordEncoder pe;
	
	/**
	 * 배정된 통관 신고 업무 수 조회
	 */
	@Override
	public int selectCustomsCount(PaginationInfoVO<Map<String, Object>> pagingVO) {
		return servantMapper.selectCustomsCount(pagingVO);
	}
	/**
	 * 배정된 통관 신고 업무 리스트 조회
	 */
	@Override
	public List<Map<String, Object>> selectCustomsList(PaginationInfoVO<Map<String, Object>> pagingVO) {
		return servantMapper.selectCustomsList(pagingVO);
	}
	/**
	 * 전체 통관 신고 업무 수 조회
	 */
	@Override
	public int selectCustomsAllCount(PaginationInfoVO<Map<String, Object>> pagingVO) {
		return servantMapper.selectCustomsAllCount(pagingVO);
	}
	/**
	 * 전체 통관 신고 업무 리스트 조회
	 */
	@Override
	public List<Map<String, Object>> selectCustomsAllList(PaginationInfoVO<Map<String, Object>> pagingVO) {
		return servantMapper.selectCustomsAllList(pagingVO);
	}
	/**
	 * 종료된 통관 신고 업무 수 조회
	 */
	@Override
	public int selectCustomsHistoryCount(PaginationInfoVO<Map<String, Object>> pagingVO) {
		return servantMapper.selectCustomsHistoryCount(pagingVO);
	}
	/**
	 * 종료된 통관 신고 업무 리스트 조회
	 */
	@Override
	public List<Map<String, Object>> selectCustomsHistoryList(PaginationInfoVO<Map<String, Object>> pagingVO) {
		return servantMapper.selectCustomsHistoryList(pagingVO);
	}
	
	/**
	 *  상태 코드 값에 따른 상세 페이지 데이터 조회
	 */
	@Override
	public Map<String, Object> customsDetail(Map<String, Object> customsNo) {
		Map<String, Object> customsDetailVO = new HashMap<>();
		
		// 수출 or 수입
		String contractType = (String) customsNo.get("contractType");
		
		// 수입 = 1, 2, 3, 4, 5, 6, 7, 8, 9, 10,  11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21  
		// 수출 = 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41	
		
		String declDNo = (String) customsNo.get("declDNo");
		String declNo = servantMapper.getDeclDToDecl(declDNo);
		int status = servantMapper.customsStatusCode(declDNo);
		customsDetailVO.put("status", status);
		log.info("customsDetail(), declNo: {} ", declNo);
		log.info("customsDetail(), status: {} ", status);
		
		// 신고검토 단계 exam 조회-> 반려(8,29)or 완료(9,30)->대기(10,31)
		if ( ( 7 <= status && status < 21 ) || ( 28 <= status && status < 41 ) ) {
			Map<String, Object> exam = servantMapper.customsExa(declNo);
			customsDetailVO.putAll(exam);
		}
		
		// 고객검사 단계 inp 조회-> 반려(11,32)or 완료(12,33)
		if ( ( 10 <= status && status < 21 ) || ( 31 <= status && status < 41 ) ) {
			Map<String, Object> inp = servantMapper.customsInp(declNo);
			customsDetailVO.putAll(inp);
		}
		
		// 물품입고 단계 bwh 조회 -> 입고 일시값 select 레코드수 판정 >0  물품 검사 신청가능 -> 신청(14,35)
		if ( ( 13 <= status && status < 21 ) || ( 34 <= status && status < 41 ) ) {
			Map<String, Object> bwh = servantMapper.customsBwh(declNo);
			customsDetailVO.putAll(bwh);
			if(customsDetailVO.get("BWH_SERVANT_NO") != null) {				// 입고 완료시 검사정보, 창고정보 출력
				Map<String, Object> qrn = servantMapper.customsQrn(declNo);
				customsDetailVO.putAll(qrn);
			}
		}
		
		// 검사검역 단계 14~21,35~41 qrn 조회 -> 완료 일시값 select 레코드수 판정 >0  셀렉트문 실행 -> 반려(15,36)or 완료(16,37)->대기(17)
		if ( ( 14 <= status && status < 21 ) || ( 35 <= status && status < 41 ) ) {
			Map<String, Object> qrn = servantMapper.customsQrn(declNo);
			customsDetailVO.putAll(qrn);
		}
		
		// 고지서 작성시 17 납부 확인시 18
		// 세금고지 단계 17~21 tx -> 고지 일시값 select 레코드수 판정 <0 고지서 작성 가능  -> 고지 일시값 select 레코드수 판정 >0 -> 완료(18)
		if ( 17 <= status && status < 21 ) {
			Map<String, Object> tx = servantMapper.customsTax(declNo);
			customsDetailVO.putAll(tx);
		}
		// 검사완료된 것들 
		// 필증 발급 단계 -> 발급 클릭시 -> 직인사용 -> (19,38)
		if ( ( 18 <= status && status < 21 ) || ( 37 <= status && status < 41 ) ) {
			// 작업 완료 후 로직 -> ?
			CDVO cdVO = utilMapper.selectCD(declNo);
			customsDetailVO.put("cdVO", cdVO);
		}
		System.out.println("customsDetailVO 값: " + customsDetailVO);
 		log.info("customsDetail(), customsDetailVO: {} ", customsDetailVO);
		return customsDetailVO;
	}

	@Override
	public List<BwhVO> bwhList() {
				
		return servantMapper.bwhList();
	}

	@Override
	public List<BwVO> bwList(int bwhNo) {
		return servantMapper.bwList(bwhNo);
	}

	@Override
	public List<DeclVO> contractList() {
		return servantMapper.contractList();
	}


	/* 해당 보세창고의 섹션 리스트  */
	@Override
	public List<WhSetionVO> whSection(int bwhNo) {
		return servantMapper.whSection(bwhNo);
	}

	@Override
	public List<BwVO> whSectionHistory(int whSectionNo) {
		return  servantMapper.whSectionHistory(whSectionNo);
	}
	@Override
	public List<BwVO> bwAwaitshipment(PaginationInfoVO<Map<String, Object>> pagingVO) {
		return servantMapper.bwAwaitshipment(pagingVO);
	}

	@Override
	public List<WhSetionVO> AllwhSection() {
		
		return servantMapper.AllwhSection();
	}

	@Override
	public int InsertBw(BwVO bw) { 
		return servantMapper.InsertBw(bw);
	}

	@Override
	public int deleteBw(int bwNo) {
		return servantMapper.deleteBw(bwNo);
	}
	@Override
	public List<DeclVO> bwAwaitReceive(PaginationInfoVO<Map<String, Object>> pagingVO) {
		return servantMapper.bwAwaitReceive(pagingVO);
	}
	
	@Override
	public void conRecordIst(Map<String, Object> param) {
		servantMapper.conRecordIst(param);
		
	}
	@Override
	public void conLastStatCodeUpd(Map<String, Object> param) {
		servantMapper.conLastStatCodeUpd(param);
		
	}
	@Override
	public List<UserVO> userMngList() {
		return servantMapper.userMngList();
	}
	@Override
	public UserVO userMngDetail(int userNo) {
		return servantMapper.userMngDetail(userNo);
	}
	@Override
	public int selectInspectReviewCount(PaginationInfoVO<Map<String, Object>> pagingVO) {
		return servantMapper.selectInspectReviewCount(pagingVO);
	}
	@Override
	public int selectInspectReviewAllCount(PaginationInfoVO<Map<String, Object>> pagingVO) {
		return servantMapper.selectInspectReviewAllCount(pagingVO);
	}
	
	@Override
	public List<Map<String, Object>> selectInspectReviewList(PaginationInfoVO<Map<String, Object>> pagingVO) {
		return servantMapper.selectInspectReviewList(pagingVO);
	}
	
	@Override
	public List<Map<String, Object>> selectInspectReviewAllList(PaginationInfoVO<Map<String, Object>> pagingVO) {
		return servantMapper.selectInspectReviewAllList(pagingVO);
	}
	
	/* 통관 신고 업무 시작 */
	//완료(9,30)->대기(10,31)
	@Transactional
	@Override
	public int exaAppro(int status, String declDNo, String contractNo) {
		
		int result = 0;
		int resultIn1 = 0;
		int resultIn2 = 0;
		int resultUp = 0;
		int statusCode = status;
		
		Map<String, Object> exaDetailVO = new HashMap<>();
		exaDetailVO.put("contractNo", contractNo);
		exaDetailVO.put("statusCode", status);
		
		log.info("statusCode: {}",statusCode);
		
		if (statusCode == 7) {
			 statusCode = 9;
			 exaDetailVO.put("statusCode", statusCode);
		    resultIn1 = servantMapper.insertContractRecord(exaDetailVO);
		    log.info("statusCode: {}",statusCode);
		} else if(statusCode == 28) {
			statusCode = 30;
			exaDetailVO.put("statusCode", statusCode);
		    resultIn1 = servantMapper.insertContractRecord(exaDetailVO);
		    log.info("statusCode: {}",statusCode);
		}
		
		if (statusCode == 9) {
			 statusCode = 10;
			 exaDetailVO.put("statusCode", statusCode);
		    resultIn2 = servantMapper.insertContractRecord(exaDetailVO);
		    resultUp = servantMapper.updateContract(exaDetailVO);
	        log.info("exaAppro() -> statusCode 10 : {}", exaDetailVO);
		} else if(statusCode == 30) {
			statusCode = 31;
			exaDetailVO.put("statusCode", statusCode);
		    resultIn2 = servantMapper.insertContractRecord(exaDetailVO);
		    resultUp = servantMapper.updateContract(exaDetailVO);
	        log.info("exaAppro() -> statusCode 31 : {}", exaDetailVO);
		}
		
		log.info("resultIn1 : {}", resultIn1);
		log.info("resultIn2 : {}", resultIn2);
		log.info("resultUp : {}", resultUp);
		if(resultIn1 == 1 && resultIn2 == 1 && resultUp ==1) {
			result = 1;
		}
		return result;
	}
	@Transactional
	@Override
	public int exaReject(String declNo, int status, String contractNo, int servantNo) {
		int result = 0;
		int sanctResult = 0;
		int sanctCCAResult = 0;
		int resultIn1 = 0;
		int resultUp = 0;
		int statusCode = status;
		
		// CCA_SANCTION_COUNT, CCA_SANCTION_SCORE, CCA_DECL_COUNT update
		int ccaNo = servantMapper.selectContractToCCA(contractNo); 
		CCAVO ccavo = new CCAVO();
		ccavo.setUserNo(ccaNo);
		ccavo.setCcaSanctionScore(10);
		sanctCCAResult = servantMapper.imposeSanctCCA(ccavo);
		
		// SANCTION insert
		Date sysdate = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd");
        String santDate = formatter.format(sysdate);
        
		SanctionVO sanctionVO = new SanctionVO();
		sanctionVO.setDeclNo(declNo);
		sanctionVO.setSanctionCode(1);
		sanctionVO.setSanctionDate(santDate);
		sanctionVO.setServantNo(servantNo);
		
		sanctResult = servantMapper.exaSanct(sanctionVO);
		
		// LAST_STATUS_CODE update, CONTRACT_RECORD insert
		if(sanctResult > 0 && sanctCCAResult > 0) {
			Map<String, Object> exaDetailVO = new HashMap<>();
			exaDetailVO.put("contractNo", contractNo);
			exaDetailVO.put("statusCode", status);
			if (statusCode == 7) {
				 statusCode = 8;
				 exaDetailVO.put("statusCode", statusCode);
			    resultIn1 = servantMapper.insertContractRecord(exaDetailVO);
			    resultUp = servantMapper.updateContract(exaDetailVO);
			    log.info("statusCode: {}",statusCode);
			} else if(statusCode == 28) {
				statusCode = 29;
				exaDetailVO.put("statusCode", statusCode);
			    resultIn1 = servantMapper.insertContractRecord(exaDetailVO);
			    resultUp = servantMapper.updateContract(exaDetailVO);
			    log.info("statusCode: {}",statusCode);
			}
			
			sanctResult = servantMapper.updateRealDate(declNo);
			
			log.info("updateRealDate(declNo) -> sanctResult: {}",sanctResult);
		}
		
		if(resultIn1 == 1 && resultUp ==1) {
			result = 1;
		}
		return result;
	}
	@Transactional
	@Override
	public int inpAppl(int status, String consignorName, String declNo, String contractNo) {
		
		int result = 0;
		int resultInp = 0;
		int resultIn1 = 0;
		int resultUp = 0;
		int statusCode = status;
		int inpNo = servantMapper.selectOneInprName();
		log.info("statusCode: {}",statusCode);
		log.info("inpNo: {}",inpNo);
		
		Map<String, Object> inpDetailVO = new HashMap<>();
		inpDetailVO.put("consignorName", consignorName);
		inpDetailVO.put("contractNo", contractNo);
		inpDetailVO.put("declNo", declNo);
		inpDetailVO.put("inpNo", inpNo);
		inpDetailVO.put("inpClosure", 0);
		inpDetailVO.put("inpCrime", 0);
		inpDetailVO.put("inpDot", 0);
		inpDetailVO.put("inpYn", 1);
		log.info("inpAppl() -> inpDetailVO : {}", inpDetailVO);
		
		resultInp = servantMapper.insertInpn(inpDetailVO);
		
		if (statusCode == 10) {
			statusCode = 12;
			inpDetailVO.put("statusCode", statusCode);
		    resultIn1 = servantMapper.insertContractRecord(inpDetailVO);
		    resultUp = servantMapper.updateContract(inpDetailVO);
		    log.info("inpAppl() -> statusCode 12 : {}", inpDetailVO);
		} else if(statusCode == 31) {
			statusCode = 33;
			inpDetailVO.put("statusCode", statusCode);
		    resultIn1 = servantMapper.insertContractRecord(inpDetailVO);
		    resultUp = servantMapper.updateContract(inpDetailVO);
		    log.info("inpAppl() -> statusCode 33 : {}", inpDetailVO);
		} else {
			log.error("inpAppl() ->상태값 업데이트 실패");
		}
		
		log.info("resultIn1 : {}", resultIn1);
		log.info("resultUp : {}", resultUp);
		log.info("resultInp : {}", resultInp);
		
		if(resultIn1 == 1 && resultUp == 1 && resultInp == 1) {
			result = 1;
		}
		return result;
	}
	@Override
	public int bwhAppl(int status, String declNo, String contractNo) {
		// 해당 단계에서는 status작업을 실행하지 않음
		int result = 0;
		int resultBwh = servantMapper.selectBwhCount(declNo);
		result = resultBwh;
		
		return result;
	}
	@Transactional
	@Override
	public int qrnAppl(int status, String declNo, String contractNo, int servantNo) {
		int result = 0;
		int resultIn1 = 0;
		int resultUp = 0;
		int statusCode = status;
		
        Date sysdate = new Date();

        Calendar cal = Calendar.getInstance();
        cal.setTime(sysdate);
        cal.add(Calendar.DAY_OF_MONTH, 5);
        Date plus5Date = cal.getTime();
        String qrntType = servantMapper.selectQrntType(contractNo);
        
		QrntVO qrntVO = new QrntVO();
		qrntVO.setDeclNo(declNo);
		qrntVO.setServantNo(servantNo);
		qrntVO.setQrntReceptDate(sysdate);
		qrntVO.setQrntAntc(plus5Date);
		qrntVO.setQrntYn(false);
		qrntVO.setQrntStatusCode("검사 대기");
		qrntVO.setQrntType(qrntType);
		
		log.info("qrnAppl() -> qrntVO : {}", qrntVO);
		
		int resultQrn = servantMapper.insertQrnAppl(qrntVO);
		int resultHc = servantMapper.insertHcAppl(qrntVO);
		
		Map<String, Object> qrnDetailVO = new HashMap<>();
		qrnDetailVO.put("status", status);
		qrnDetailVO.put("contractNo", contractNo);
		
		log.info("qrnAppl() -> qrnDetailVO : {}", qrnDetailVO);

		if(resultQrn >= 1 && resultHc >= 1) {
			if (statusCode == 13) {
				statusCode = 14;
				qrnDetailVO.put("statusCode", statusCode);
			    resultIn1 = servantMapper.insertContractRecord(qrnDetailVO);
			    resultUp = servantMapper.updateContract(qrnDetailVO);
			    log.info("qrnAppl() -> statusCode 14 : {}", qrnDetailVO);
			} else if(statusCode == 34) {
				statusCode = 35;
				qrnDetailVO.put("statusCode", statusCode);
			    resultIn1 = servantMapper.insertContractRecord(qrnDetailVO);
			    resultUp = servantMapper.updateContract(qrnDetailVO);
			    log.info("qrnAppl() -> statusCode 35 : {}", qrnDetailVO);
			}
		} else {
			log.error("qrnAppl() ->상태값 업데이트 실패");
		}
		
		if(resultIn1 == 1 && resultUp == 1) {
			result = 1;
		}
		return result;
	}
	@Override
	public int txWriteCheck(String declNo) {
		return servantMapper.txWriteCheck(declNo);
	}
	@Transactional
	@Override
	public int txWrite(String contractNo, String declNo, int prodNo, int totalCost, int status) {
		int result = 0;
		int resultIn1 = 0;
		int resultUp = 0;
		int statusCode = status;
		int resultTx = 1;
		
		int tariff = servantMapper.getTarif(prodNo);
		int taxAmount = totalCost / tariff;
		
		Date sysdate = new Date();
        Calendar cal = Calendar.getInstance();
        cal.setTime(sysdate);
        cal.add(Calendar.DAY_OF_MONTH, 15);
        Date deadLineDate = cal.getTime();
        
		TaxVO taxVO = new TaxVO();
		taxVO.setDeclNo(declNo);
		taxVO.setTaxAmount(taxAmount);
		taxVO.setTaxDestDate(sysdate);
		taxVO.setTaxDeadlineDate(deadLineDate);
		log.info("txWrite -> taxVO : {}", taxVO);
		
		resultTx = servantMapper.insertTax(taxVO);
		
		Map<String, Object> txDetailVO = new HashMap<>();
		txDetailVO.put("status", status);
		txDetailVO.put("contractNo", contractNo);
		
		if (resultTx >= 1 && statusCode == 16) {
			statusCode = 17;
			txDetailVO.put("statusCode", statusCode);
		    resultIn1 = servantMapper.insertContractRecord(txDetailVO);
		    resultUp = servantMapper.updateContract(txDetailVO);
		    log.info("txWrite() -> statusCode 17 : {}", txDetailVO);
		} else {
			log.error("txWrite() ->상태값 업데이트 실패");
		}
		
		if(resultIn1 == 1 && resultUp == 1) {
			result = 1;
		}
		
		return result;
	}
	@Transactional
	@Override
	public int cdAppl(int status, String contractNo) {
		int result = 0;
		int resultIn1 = 0;
		int resultUp = 0;
		int statusCode = status;
		int resultCd = 1; 		// 필증발급의 insert 성공 시 1or0
		
		Map<String, Object> cdDetailVO = new HashMap<>();
		cdDetailVO.put("status", status);
		cdDetailVO.put("contractNo", contractNo);
		
		if(resultCd >= 1) {
			if (statusCode == 18) {
				statusCode = 19;
				cdDetailVO.put("statusCode", statusCode);
			    resultIn1 = servantMapper.insertContractRecord(cdDetailVO);
			    resultUp = servantMapper.updateContract(cdDetailVO);
			    log.info("cdAppl() -> statusCode 19 : {}", cdDetailVO);
			} else if(statusCode == 37) {
				statusCode = 38;
				cdDetailVO.put("statusCode", statusCode);
			    resultIn1 = servantMapper.insertContractRecord(cdDetailVO);
			    resultUp = servantMapper.updateContract(cdDetailVO);
			    log.info("cdAppl() -> statusCode 38 : {}", cdDetailVO);
			}
		}else {
			log.error("cdAppl() ->상태값 업데이트 실패");
		}
		
		if(resultIn1 == 1 && resultUp == 1) {
			result = 1;
		}
		return result;
	}
	/* 통관 신고 업무 끝 */
	
	@Override
	public Map<String, Object> selectInspectReviewDetail(String declNo) {
		// 1. declNo로 기본 상세 정보 조회
		Map<String, Object> inspectDetail = servantMapper.selectInspectReviewDetail(declNo);

		// 2. 상세 정보가 존재하고 비어있지 않은 경우에만 질병 목록 조회 로직 실행
		if (inspectDetail != null && !inspectDetail.isEmpty()) {
			// 3. 조회된 상세 정보에서 'HS_CODE' 값을 추출
			String hsCode = (String) inspectDetail.get("HS_CODE");
			log.info("추출된 HS_CODE: {}", hsCode);

			// 4. hsCode가 유효한 경우, 해당 코드로 질병 목록을 조회
			if (hsCode != null && !hsCode.isEmpty()) {
				List<Map<String, Object>> diseaseList = servantMapper.selectDiseaseListByHsCode(hsCode);

				// 5. 조회된 질병 목록을 원래의 상세 정보 맵에 'diseaseList'라는 키로 추가
				inspectDetail.put("diseaseList", diseaseList);
				log.info("HS_CODE '{}'에 해당하는 질병 목록 {}건 조회 완료", hsCode, diseaseList.size());
			}
		}

		// 6. 질병 목록이 포함된 최종 상세 정보 맵을 반환
		return inspectDetail;
	}
	
	@Transactional
	@Override
	public int updateInspectResult(HCVO hcVO, List<String> targetDiseases) {
		int status = 0;
		
		// 1. HC 테이블 업데이트 (검사관 입력 소견 등)
		status += servantMapper.updateHcResult(hcVO);
		
		// 2. QRNT 테이블 업데이트 (검사 완료 상태로 변경)
		status += servantMapper.updateQrntResult(hcVO);
		
		
		// 3. 체크된 질병이 있는 경우 HC_DIS 테이블에 INSERT
		if (targetDiseases != null && !targetDiseases.isEmpty()) {
			servantMapper.deleteHcDis(hcVO.getHcNo());
			Map<String, Object> params = new HashMap<>();
			params.put("hcNo", hcVO.getHcNo());
			params.put("diseaseCodes", targetDiseases);
			status += servantMapper.insertHcDis(params);
		}
		
		// 4. 계약(Contract) 상태 업데이트 및 이력 기록 로직 추가
		// 4-1. declNo -> contractNo 조회
		String contractNo = servantMapper.selectContractNoByDeclNo(hcVO.getDeclNo());
		if(contractNo == null) {
			log.error("declNo {}에 해당하는 계약 정보를 찾을 수 없습니다.", hcVO.getDeclNo());
			throw new RuntimeException("계약 정보 조회 실패"); // 트랜잭션 롤백
		}
		
		// 4-2. contractNo로 현재 LAST_STATUS_CODE 조회
		int currentStatusCode = servantMapper.selectLastStatusCode(contractNo);
		
		// 4-3. 상태 코드 결정
		int newStatusCode = -1;
		if (currentStatusCode == 14) { // 수입 검사 대기
			newStatusCode = hcVO.isHcYn() ? 16 : 15; // 합격(true) 시 16, 불합격(false) 시 15
		} else if (currentStatusCode == 35) { // 수출 검사 대기
			newStatusCode = hcVO.isHcYn() ? 37 : 36; // 합격(true) 시 37, 불합격(false) 시 36
		}
		
		// 4-4. DB에 상태코드 변경 작업 수행
		if (newStatusCode != -1) {
			Map<String, Object> contractParams = new HashMap<>();
			contractParams.put("contractNo", contractNo);
			contractParams.put("newStatusCode", newStatusCode);
			
			// CONTRACT 테이블의 LAST_STATUS_CODE 업데이트
			servantMapper.updateContractStatus(contractParams);
			
			// CONTRACT_RECORD 테이블에 이력 INSERT
			servantMapper.insertContractStatusRecord(contractParams);
			
			log.info("ContractNo인 {}의 상태가 {}에서 {}로 변경 및 이력 기록 완료.", contractNo, currentStatusCode, newStatusCode);
		}
		
		// 5. 불합격시 관세사 제재 부과
		if(!hcVO.isHcYn()) {
			log.info("검역 불합격으로 제재 절차를 시작합니다. DeclNo: {}", hcVO.getDeclNo());

			servantMapper.updateRealDate(hcVO.getDeclNo());
			log.info("DECL 테이블의 완료일시가 업데이트되었습니다.");
			
			SanctionVO sanctionVO = new SanctionVO();
			sanctionVO.setDeclNo(hcVO.getDeclNo());
			sanctionVO.setSanctionCode(2);
			
			// 담당자 조회
			int servantNo = servantMapper.qrntServantNo(hcVO.getDeclNo());
			sanctionVO.setServantNo(servantNo);
			
			int sanctionResult = servantMapper.exaSanct2(sanctionVO); 
			log.info("SANCTION 테이블에 제재 내역이 등록되었습니다. 결과: {}", sanctionResult);

			//관세사 제재 추가
			int ccaNo = servantMapper.selectContractToCCA(contractNo);
			CCAVO ccaVO = new CCAVO();
			ccaVO.setUserNo(ccaNo);
			ccaVO.setCcaSanctionScore(15);
			
			int ccaUpdateResult = servantMapper.imposeSanctCCA(ccaVO);
			log.info("CCA#{}의 제재 정보가 업데이트되었습니다. 결과: {}", ccaNo, ccaUpdateResult);
			
			status += (sanctionResult + ccaUpdateResult);
		}
		return status;
	}
		
	@Override
	public List<Map<String, Object>> getDiseaseNamesByCodes(List<String> targetDiseases) {
		return servantMapper.selectDiseaseNamesByCodes(targetDiseases);
		
	}
	@Override
	public Map<String, Object> getInspectResult(String hcNo) {
		// 1. 기본 상세 정보 및 검사 결과 조회
		Map<String, Object> resultData = servantMapper.selectInspectResult(hcNo);
		
		if (resultData != null) {
			// 2. 해당 hcNo에 연결된 질병 이름 목록 조회
			List<Map<String, Object>> diseaseNames = servantMapper.selectDiseaseNamesByHcNo(hcNo);
			resultData.put("diseaseNames", diseaseNames);
			log.info("hcNo '{}'에 연결된 질병 목록 {}건 조회", hcNo, diseaseNames.size());
		}
		
		return resultData;
	}
	
	@Override
	public int selectInspectHistoryCount(PaginationInfoVO<Map<String, Object>> pagingVO) {
		return servantMapper.selectInspectHistoryCount(pagingVO); 
	}
	@Override
	public List<Map<String, Object>> selectInspectHistoryList(PaginationInfoVO<Map<String, Object>> pagingVO) {
		return servantMapper.selectInspectHistoryList(pagingVO);
	}
	@Override
	public Map<String, Object> getTaxBill(String declNo) {
		Map<String, Object> taxMap = servantMapper.customsTax(declNo);
		return taxMap;
	}
	
	@Override
	public int insertCD(CDVO cdVO) {
		log.info("서비스에 map : {} "+cdVO.toString());
		
		int status = servantMapper.insertCD(cdVO);
		
		// 메일 발송 처리
		if(status>0) {
			SimpleDateFormat format = new SimpleDateFormat("yyyy년 MM월 dd일 hh시 mm분");
			int declNo = servantMapper.selectDeclNo(cdVO.getDeclDNo());
			Date receptDate = servantMapper.selectCDDate(declNo);
	        String receptDateStr = format.format(receptDate);
			
	        String contractNo = cdVO.getContractNo();
	        String ie = contractNo.substring(0, 2).equals("IP") ? "수입" : "수출";
			MyMailVO myMailVO = new MyMailVO();
			myMailVO.setEmailTitle("[BORDER7]필증 발급이 완료되었습니다.");
			myMailVO.setEmailContent(
					"<html><body><h3>안녕하세요. BORDER7입니다.</h3>필증 발급이 완료되어 안내 메일 드립니다."
					+ "<table style=\"width:600px; border-collapse: collapse; margin-top: 20px;\">"
					+ "<tr><th style=\"width:300px; border: 1px solid #dddddd; text-align: center; padding: 8px; background-color: #f2f2f2;\">관세대리업무계약번호</th>"
					+ "<td style=\"border: 1px solid #dddddd; text-align: left; padding: 8px;\">"
					+ contractNo
					+ "</td></tr><tr><th style=\"border: 1px solid #dddddd; text-align: center; padding: 8px; background-color: #f2f2f2;\">필증 구분</th>"
					+ "<td style=\"border: 1px solid #dddddd; text-align: left; padding: 8px;\">"
					+ ie
					+ "신고필증</td></tr><tr><th style=\"border: 1px solid #dddddd; text-align: center; padding: 8px; background-color: #f2f2f2;\">필증발급일시</th>"
					+ "<td style=\"border: 1px solid #dddddd; text-align: left; padding: 8px;\">"
					+ receptDateStr
					+ "</td></tr></table><br></body></html>");
			
			int userNo = 1004;
			myMailVO.setUserNo(userNo); //공무원번호 하드코딩
			String userId = userMapper.selectUserId(userNo); //공무원아이디
			
			myMailVO.setEmailSender(userId + "@border7.kr"); //공무원번호 하드코딩
			
			myMailVO.setComFileNo(0);
			myMailMapper.mailSendInsert(myMailVO);
			
			ContractVO contractVO = contractMapper.selectContract(contractNo);
			int ccaNo = contractVO.getCcaNo();
			int consignorNo = contractVO.getConsignorNo();
			
			// 외부메일 처리
			String ccaGmail = userMapper.selectUserMail(ccaNo);
			String consignorGmail = userMapper.selectUserMail(consignorNo);
			
			if(userMapper.selectUserMailYn(ccaNo) == 1) {
				myMailVO.setRecipEmail(ccaGmail);
				myMailService.mailGmailSend(myMailVO);
			}
			if(userMapper.selectUserMailYn(consignorNo) == 1) {
				myMailVO.setRecipEmail(consignorGmail);
				myMailService.mailGmailSend(myMailVO);
			}
			
			// 메일 수신자 처리
			myMailVO.setRecipType("recip");
			String ccaEmail = userMapper.selectUserId(ccaNo) + "@border7.kr";
			String consignorEmail = userMapper.selectUserId(consignorNo) + "@border7.kr";
			
			myMailVO.setRecipEmail(ccaEmail);
			myMailVO.setRecipUserNo(ccaNo);
			myMailMapper.mailRecipListInsert(myMailVO);
			
			myMailVO.setRecipEmail(consignorEmail);
			myMailVO.setRecipUserNo(consignorNo);
			myMailMapper.mailRecipListInsert(myMailVO);
		}
		
		
		return status;
	}
	@Override
	public int updateEndDecl(String contractNo) {
		log.info("updateEndDecl() 실행 ");
		return servantMapper.updateEndDecl(contractNo);
	}
	/*
	@Override
	public String generateSaveQRCodeInspection(Map<String, Object> qrDataMap) {
		
		
		// 1. QR 코드에 담을 데이터만 선별하여 새로운 Map 생성
        Map<String, Object> dataForQr = new HashMap<>();
        dataForQr.put("hcConsignorName", qrDataMap.get("CONSIGNOR_NAME"));
        dataForQr.put("hcName", qrDataMap.get("CONSIGNOR_USER_NAME"));
        dataForQr.put("hcAddr", qrDataMap.get("CONSIGNOR_ADDR") + " " + qrDataMap.get("CONSIGNOR_DET_ADDR"));
        dataForQr.put("hcTel", qrDataMap.get("CONSIGNOR_TEL"));
        dataForQr.put("hcProductName", qrDataMap.get("PRODUCT_NAME"));
        dataForQr.put("hcCommonName", qrDataMap.get("HS_NCC_NAME") + " (" + qrDataMap.get("HS_KR_NAME") + ")");
        dataForQr.put("hcWeight", qrDataMap.get("HC_WEIGHT"));
        dataForQr.put("hcQty", qrDataMap.get("PRODUCT_QTY"));
        dataForQr.put("hcSn", qrDataMap.get("HS_EN_NAME"));
        dataForQr.put("hcOrigin", qrDataMap.get("PRODUCT_ORIGIN"));
        
        
        // 질병 목록 랜덤으로 선택
        List<Map<String, Object>> diseaseList = (List<Map<String, Object>>) qrDataMap.get("diseaseList");
        List<String> selectedDiseaseCodes = new ArrayList<>();
        
        if (diseaseList != null && !diseaseList.isEmpty()) {
        	
            // 1-2. 전체 질병 관리 목록을 섞어요~ 
        	Collections.shuffle(diseaseList, new Random());
            
            // 1-3. 랜덤으로 개수 선택해요~
        	int minCount = 2;	// 최소 개수
        	int maxCount = Math.min(10, diseaseList.size()); // 사이즈
        	
        	if (minCount > maxCount) {	// 최소 <= 사이즈
            	minCount = maxCount;
            }
        	
        	int finalCount = new Random().nextInt(maxCount - minCount + 1) + minCount;
            
            // 1-4. 선택된 목록을 가져와요~
            for (int i = 0; i < finalCount; i++) {
                selectedDiseaseCodes.add(diseaseList.get(i).get("DISEASE_CODE").toString());
            }
        }
        
        dataForQr.put("targetDiseases", selectedDiseaseCodes);

        // 2. Map을 JSON 문자열로 변환
        Gson gson = new GsonBuilder().create();
        String qrCodeJsonData = gson.toJson(dataForQr);

        // 3. QR 코드 이미지 생성 및 파일 저장 (ex. HC-2025-00001.png )
        String fileName = qrDataMap.get("HC_NO").toString() + ".png";
        QRCodeImage.generateQRImage(qrCodeJsonData, fileName);
        
        log.info("QR 코드 생성 완료. 파일명: {}, 데이터: {}", fileName, qrCodeJsonData);

        return qrCodeJsonData;
    }
	*/
	
	@Override
	public Map<String, String> generateSaveQRCodeInspection(Map<String, Object> qrDataMap) {
		// 1. QR 코드에 담을 데이터만 선별하여 새로운 Map 생성
        Map<String, Object> dataForQr = new HashMap<>();
        dataForQr.put("hcConsignorName", qrDataMap.get("CONSIGNOR_NAME"));
        dataForQr.put("hcName", qrDataMap.get("CONSIGNOR_USER_NAME"));
        dataForQr.put("hcAddr", qrDataMap.get("CONSIGNOR_ADDR") + " " + qrDataMap.get("CONSIGNOR_DET_ADDR"));
        dataForQr.put("hcTel", qrDataMap.get("CONSIGNOR_TEL"));
        dataForQr.put("hcProductName", qrDataMap.get("PRODUCT_NAME"));
        dataForQr.put("hcCommonName", qrDataMap.get("HS_NCC_NAME") + " (" + qrDataMap.get("HS_KR_NAME") + ")");
        dataForQr.put("hcWeight", qrDataMap.get("HC_WEIGHT"));
        dataForQr.put("hcQty", qrDataMap.get("PRODUCT_QTY"));
        dataForQr.put("hcSn", qrDataMap.get("HS_EN_NAME"));
        dataForQr.put("hcOrigin", qrDataMap.get("PRODUCT_ORIGIN"));
        
        // 질병 목록 랜덤으로 선택
        List<Map<String, Object>> diseaseList = (List<Map<String, Object>>) qrDataMap.get("diseaseList");
        List<String> selectedDiseaseCodes = new ArrayList<>();
        
        if (diseaseList != null && !diseaseList.isEmpty()) {
        	Collections.shuffle(diseaseList, new Random());
        	int minCount = 2;
        	int maxCount = Math.min(10, diseaseList.size()); 
        	if (minCount > maxCount) {
            	minCount = maxCount;
            }
        	int finalCount = new Random().nextInt(maxCount - minCount + 1) + minCount;
            for (int i = 0; i < finalCount; i++) {
                selectedDiseaseCodes.add(diseaseList.get(i).get("DISEASE_CODE").toString());
            }
        }
        
        dataForQr.put("targetDiseases", selectedDiseaseCodes);

        // 2. Map을 JSON 문자열로 변환
        Gson gson = new GsonBuilder().create();
        String qrCodeJsonData = gson.toJson(dataForQr);

        // 3. QR 코드 이미지 생성 및 파일 저장 (ex. HC-2025-00001.png )
        String fileName = qrDataMap.get("HC_NO").toString() + ".png";
        QRCodeImage.generateQRImage(qrCodeJsonData, fileName);
        
        log.info("QR 코드 생성 완료. 파일명: {}, 데이터: {}", fileName, qrCodeJsonData);

        // 4. 결과를 Map에 담아 반환
	    Map<String, String> result = new HashMap<>();
	    result.put("qrData", qrCodeJsonData);
	    result.put("fileName", fileName);

	    return result;
	}
	
	@Override
	public int selectSanctionSAllCount(PaginationInfoVO<Map<String, Object>> pagingVO) {
		return servantMapper.selectSanctionSAllCount(pagingVO);
	}
	@Override
	public List<Map<String, Object>> selectSanctionSList(PaginationInfoVO<Map<String, Object>> pagingVO) {
		return servantMapper.selectSanctionSList(pagingVO);
	}
	@Override
	public int selectSanctionCAllCount(PaginationInfoVO<Map<String, Object>> pagingVO) {
		return servantMapper.selectSanctionCAllCount(pagingVO);
	}
	@Override
	public List<Map<String, Object>> selectSanctionCList(PaginationInfoVO<Map<String, Object>> pagingVO) {
		return servantMapper.selectSanctionCList(pagingVO);
	}
	@Override
	public List<Map<String, Object>> selectSanctionDetail(PaginationInfoVO<Map<String, Object>> pagingVO) {
		return servantMapper.selectSanctionDetail(pagingVO);
	}
	@Override
	public int selectSanctionDetailCount(PaginationInfoVO<Map<String, Object>> pagingVO) {
		return servantMapper.selectSanctionDetailCount(pagingVO);
	}
	@Override
	public int selectUserMngCount(PaginationInfoVO<UserVO> pagingVO) {
		return servantMapper.selectUserMngCount(pagingVO);
	}
	@Override
	public List<UserVO> selectUserMngList(PaginationInfoVO<UserVO> pagingVO) {
		return servantMapper.selectUserMngList(pagingVO);
	}
	@Override
	public int shipmentTotalRecode(PaginationInfoVO<Map<String, Object>> pagingVO) {
		
		return servantMapper.shipmentTotalRecode(pagingVO);
	}
	@Override
	public int ReceiveTotalRecode(PaginationInfoVO<Map<String, Object>> pagingVO) {
		
		return servantMapper.ReceiveTotalRecode(pagingVO);
	}
	@Override
	public List<BwVO> bwAwaiteAll(PaginationInfoVO<Map<String, Object>> pagingVO) {
		// TODO Auto-generated method stub
		return servantMapper.bwAwaiteAll(pagingVO);
	}
	@Override
	public int AllTotalRecode(PaginationInfoVO<Map<String, Object>> pagingVO) {
		// TODO Auto-generated method stub
		return servantMapper.AllTotalRecode(pagingVO);
	}
	
	// 이용자 계정 수정
	@Override
	public int userMngUpdate(
			UserVO userVO
			, MultipartFile profileImageFile
			, String uploadPath) throws Exception {
		
	    int result = 0;
	    
	    if (profileImageFile != null && !profileImageFile.isEmpty()) {
	        String savedPath = UploadFileUtils.uploadFile(
	                uploadPath + "/profile", 
	                profileImageFile.getOriginalFilename(),
	                profileImageFile.getBytes()
	            );
	    	
	        String dbPath = uploadPath + File.separator + "profile" + savedPath;
	    	
	        String authCode = userVO.getAuthCode();
	        if ("ROLE_CCA".equals(authCode)) {
	            if (userVO.getCcaVO() == null) userVO.setCcaVO(new CCAVO());
	            userVO.getCcaVO().setCcaProfileImg(dbPath);
	            
	        } else if ("ROLE_CONSIGNOR".equals(authCode)) {
	            if (userVO.getConsignorVO() == null) userVO.setConsignorVO(new ConsignorVO());
	            userVO.getConsignorVO().setConsignorProfileImg(dbPath);
	            
	        } else if ("ROLE_LOGISTICS".equals(authCode)) {
	            if (userVO.getLogistMngVO() == null) userVO.setLogistMngVO(new LogistMngVO());
	            userVO.getLogistMngVO().setLogistMngProfileImg(dbPath);
	        }
	    }


	    // 공통 정보 업데이트
	    result += servantMapper.updateUserMng(userVO);

	    // 이용자 별 상세 정보 업데이트
	    String authCode = userVO.getAuthCode();
	    if ("ROLE_CCA".equals(authCode)) {
            userVO.getCcaVO().setUserNo(userVO.getUserNo());
            result += servantMapper.updateCcaDetail(userVO.getCcaVO());
            
            // 관세사 주력분야 삭제
            servantMapper.deleteCcaSpecialty(userVO.getUserNo());
            
            //  체크된 주력분야 추가
            if (userVO.getCcaVO().getCcaSpecialtyCodeList() != null && !userVO.getCcaVO().getCcaSpecialtyCodeList().isEmpty()) {
                Map<String, Object> specialtyMap = new HashMap<>();
                specialtyMap.put("userNo", userVO.getUserNo());
                
                for (String specialtyCode : userVO.getCcaVO().getCcaSpecialtyCodeList()) {
                    specialtyMap.put("specialtyCode", specialtyCode);
                    servantMapper.insertCcaSpecialty(specialtyMap);
                }
            }
	        
	    } else if ("ROLE_CONSIGNOR".equals(authCode)) {

	    	if (userVO.getConsignorVO() == null) {
	            userVO.setConsignorVO(new ConsignorVO());
	        }
	        userVO.getConsignorVO().setUserNo(userVO.getUserNo());
	        result += servantMapper.updateConsignorDetail(userVO.getConsignorVO());
	        
	    } else if ("ROLE_LOGISTICS".equals(authCode)) {

	    	if (userVO.getLogistMngVO() == null) {
	            userVO.setLogistMngVO(new LogistMngVO());
	        }
	        userVO.getLogistMngVO().setLogistMngNo(userVO.getUserNo());
	        result += servantMapper.updateLogistMngDetail(userVO.getLogistMngVO());
	    }
	    return result;
    }
	@Override
	public int selectServantMngCount(PaginationInfoVO<UserVO> pagingVO) {
		return servantMapper.selectServantMngCount(pagingVO);
	}
	@Override
	public List<UserVO> selectServantMngList(PaginationInfoVO<UserVO> pagingVO) {
		return servantMapper.selectServantMngList(pagingVO);
	}
	@Override
	public UserVO selectServantMngDetail(int userNo) {
		return servantMapper.selectServantMngDetail(userNo);
	}
	@Override
	public int updateServantMng(UserVO userVO) {
		return servantMapper.updateServantMng(userVO);
	}
	@Override
	public String getdeclNo(String declNo) {
		return servantMapper.getdeclNo(declNo);
	}


}
