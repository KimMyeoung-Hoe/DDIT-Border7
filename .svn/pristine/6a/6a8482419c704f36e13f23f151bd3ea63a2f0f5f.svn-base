package kr.or.ddit.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.mapper.ICCAMapper;
import kr.or.ddit.servant.mapper.IServantMapper;
import kr.or.ddit.vo.BwVO;
import kr.or.ddit.vo.ContainerDetailVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.StowageVO;
import kr.or.ddit.vo.WhDetailVO;
import kr.or.ddit.vo.containerShipForm;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class StowageServiceImpl implements IStowageService{

	@Autowired
	private ICCAMapper mapper;
	
	
	@Autowired
	private IServantMapper servantMapper;
	
	@Transactional
	public void whStowage(StowageVO stowageVO) {

		String contractNo = stowageVO.getContractNo();
		List<WhDetailVO> whDetailVO = stowageVO.getWhDetailList();
		Map<String, Object> map = new HashMap<>(); 
		
		
		map.put("contractNo", contractNo);
		map.put("stowageType", "물류창고");
		
		log.info("map : {}",map);
		//적재신청 insert
		mapper.stowageInsert(map);
		
		map.put("whDetailStatusCode", "입고대기");
		
		PaginationInfoVO<Map<String, Object>> pagingVO = new PaginationInfoVO<>();
		
		pagingVO.setCurrentPage(1);
		
		int shipmentTotalRecode = servantMapper.shipmentTotalRecode(pagingVO);
		
		pagingVO.setTotalRecord(shipmentTotalRecode);
		
		// 보세창고 정보 가져오기
		List<BwVO> crtBw = servantMapper.bwAwaitshipment(pagingVO);
		
		BwVO updateBwVO = new BwVO();
		
		
		for(BwVO bwVO : crtBw) {
			if(bwVO.getContractVO().getContractNo().equals(contractNo)) {
				updateBwVO = bwVO; // 해당 관세대리업무의 bwVO 가져오기
			}
		}
		log.info("updateBwVO ", updateBwVO);
		
		 // updateBwVO가 null이 아닌 경우에만 업데이트 로직 실행
	    if (updateBwVO != null) {
	        // 보세창고 출고일시 update
	        servantMapper.BwDpDateUpdate(updateBwVO);

	        // 보세창고 섹션 사용여부 update
	        servantMapper.whSectionUpdate(updateBwVO);
	    } else {
	       log.info("보세창고 섹션, 출고일시 update 실패");
	       return ;
	    }
		
		
		// 물류창고 상세 insert
		for(int i =0; i<whDetailVO.size(); i++) {
			int whNo = whDetailVO.get(i).getWhNo();
			map.put("whNo", whDetailVO.get(i).getWhNo());
			map.put("whDetailStowageQty", whDetailVO.get(i).getWhDetailStowageQty());
			// 물류창고 상세 insert
			mapper.whDetailIst(map);
			
			// 물류창고 사용가능 여부 update
			double residualVolume = mapper.residualVolumeCheck(whNo);
			
			if(residualVolume <= 0) {
				mapper.whUseYnUpdate(whNo);
			}
		}
		
		// 마지막 진행 코드 가져오기
		int lastStatusCode = mapper.getLastStatusCode(contractNo); 
		lastStatusCode += 1;
		int contractStatusCode = lastStatusCode;
		map.put("lastStatusCode", lastStatusCode);
		map.put("contractStatusCode", contractStatusCode);
		
		
	
		// 진행이력 insert
		mapper.contractRecordInsert(map); //19->20 OR 38 ->39
		
		// 최종진행코드 update
		mapper.contractLastCodeUp(map);
		
		
		
	}

	@Override
	public void containerStowage(StowageVO stowageVO) {
		
		
		String contractNo = stowageVO.getContractNo();
		List<ContainerDetailVO> containerDetailVO = stowageVO.getContainerDetailList();
		Map<String, Object> map = new HashMap<>(); 
		
		
		map.put("contractNo", contractNo);
		map.put("stowageType", "컨테이너");
		
		log.info("map : {}",map);
		//적재신청 insert
		mapper.stowageInsert(map);
		
		map.put("containerDetailStatusCode", "입고대기");
		
		PaginationInfoVO<Map<String, Object>> pagingVO = new PaginationInfoVO<>();
		
		pagingVO.setCurrentPage(1);
		
		int shipmentTotalRecode = servantMapper.shipmentTotalRecode(pagingVO);
		
		pagingVO.setTotalRecord(shipmentTotalRecode);
		
		// 보세창고 정보 가져오기
		List<BwVO> crtBw = servantMapper.bwAwaitshipment(pagingVO);
		
		BwVO updateBwVO = new BwVO();
		
		
		for(BwVO bwVO : crtBw) {
			if(bwVO.getContractVO().getContractNo().equals(contractNo)) {
				updateBwVO = bwVO; // 해당 관세대리업무의 bwVO 가져오기
			}
		}
		
		 // updateBwVO가 null이 아닌 경우에만 업데이트 로직 실행
	    if (updateBwVO != null) {
	        // 보세창고 출고일시 update
	        servantMapper.BwDpDateUpdate(updateBwVO);

	        // 보세창고 섹션 사용여부 update
	        servantMapper.whSectionUpdate(updateBwVO);
	    } else {
	       log.info("보세창고 섹션, 출고일시 update 실패");
	       return ;
	    }
		
		
		
		// 물류창고 상세 insert
		for(int i =0; i<containerDetailVO.size(); i++) {
			int containerNo = containerDetailVO.get(i).getContainerNo();
			map.put("containerNo", containerNo);
			map.put("containerDetailStowageQty", containerDetailVO.get(i).getContainerDetailStowageQty());
			map.put("shipScheduleNo", containerDetailVO.get(i).getShipScheduleNo());
			//컨테이너 상세 insert
			mapper.containerDetailIst(map);
			
			/*
			 * // 물류창고 사용가능 여부 update double CresidualVolume =
			 * mapper.CresidualVolumeCheck(containerNo);
			 */
			
			// 컨테이너 적재시 무조건 사용 불가!
			mapper.containerUseYnUpdate(containerNo);
		}
		
		// 마지막 진행 코드 가져오기
		int lastStatusCode = mapper.getLastStatusCode(contractNo); 
		lastStatusCode += 1;
		int contractStatusCode = lastStatusCode;
		map.put("lastStatusCode", lastStatusCode);
		map.put("contractStatusCode", contractStatusCode);
		
	
		// 진행이력 insert
		mapper.contractRecordInsert(map); //19->20 OR 38 ->39
		
		// 최종진행코드 update
		mapper.contractLastCodeUp(map);
		
		
	}

}
