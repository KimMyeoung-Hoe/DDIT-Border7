package kr.or.ddit.service;

import java.util.List;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.vo.ContainerDetailVO;
import kr.or.ddit.vo.ContainerVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.ShipScheduleVO;
import kr.or.ddit.vo.ShipsVO;
import kr.or.ddit.vo.StowageVO;
import kr.or.ddit.vo.WarehouseVO;
import kr.or.ddit.vo.WhDetailVO;



public interface ILogisticsService {
	
	// 컨테이너 전체리스트 출력
	List<ContainerVO> containerListAll();
	// 컨테이너 리스트
	List<ContainerVO> containerList(PaginationInfoVO<ContainerVO> pagingVO);
	/** 컨테이너 상세*/
	List<ContainerDetailVO> containerDetail(PaginationInfoVO<ContainerDetailVO> pagingVO);
	// 물류창고 전체리스트 출력
	List<WarehouseVO> warehouseListAll();
	// 물류관리자의 물류창고 리스트
	List<WarehouseVO> warehouseList(PaginationInfoVO<WarehouseVO> pagingVO);
	// 물류관리자의 물류창고 상세
	List<WhDetailVO> warehouseDetail(PaginationInfoVO<WhDetailVO> pagingVO);
	/** 물류창고 기본정보 업데이트*/
	int updateWh(WarehouseVO warehouseVO);
	/** 물류창고 삭제(폐업 업데이트)*/
	int deleteWh(WarehouseVO warehouseVO);
	/** 물류창고 상세페이지네이션을 위한 행의갯수*/
	int getWhDetailCount(PaginationInfoVO<WhDetailVO> pagingVO);
	/** 물류창고 리스트페이지네이션을 위한 행의갯수*/
	int getWhCount(PaginationInfoVO<WarehouseVO> pagingVO);
	/** 물류창고 등록 */
	int registWh(WarehouseVO warehouseVO);
	/** 물류창고 기본 정보*/
	WarehouseVO warehouseBasicInfo(int whNo);

	
	/** 컨테이너 페이징,검색을 위한 행의갯수*/
	int getContainerCount(PaginationInfoVO<ContainerVO> pagingVO);
	/** 보세창고 업데이트 */
	int updateBW(WhDetailVO whDetailVO);
	
	/** 물류창고 상세 상태 업데이트 (입고완료일때) */
	int updateWhDetailStatus(WhDetailVO whDetailVO);
	/** 입고완료 아닐떄 실행*/ 
	int updateWhDetail(WhDetailVO whDetailVO);
	
	/** 페이지네이션 적용되는 선박목록 총컬럼갯수 */
	int selectShipCount(PaginationInfoVO<ShipsVO> pagingVO);
	/** 페이지네이션 적용되는 선박목록(REST형식) */
	List<ShipsVO> selectShipList(PaginationInfoVO<ShipsVO> pagingVO);
	/** 컨테이너 등록 메서드 */
	int registContainer(ContainerVO containerVO);
	/** 컨테이너 상세페이지 행의갯수 */
	int getContainerDetailCount(PaginationInfoVO<ContainerDetailVO> pagingVO);
	/** 적재신청 페이지네이션을 위한 행의갯수 */
	int getStowageCount(PaginationInfoVO<StowageVO> pagingVO);
	/** 적재신청 리스트 페이지 */
	List<StowageVO> stowageList(PaginationInfoVO<StowageVO> pagingVO);
	/** 컨테이너 기본정보 */
	ContainerVO containerBasicInfo(int containerNo);
	List<ShipScheduleVO> selectShipSheduleList(PaginationInfoVO<ShipsVO> pagingVO);
	/** 컨테이너 상태변경 메서드(입고완료) */
	int updateContainerDetailStatus(ContainerDetailVO containerDetailVO);
	/** 컨테이너 상태변경 메서드(입고완료아닐때)*/
	int updateContainerDetail(ContainerDetailVO containerDetailVO);
	/** 컨테이너 기본정보 업데이트 */
	int updateContainer(ContainerVO conatainerVO);
	
	
}
