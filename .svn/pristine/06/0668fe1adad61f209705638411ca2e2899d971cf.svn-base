package kr.or.ddit.user.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.vo.ContainerDetailVO;
import kr.or.ddit.vo.ContainerVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.ShipScheduleVO;
import kr.or.ddit.vo.ShipsVO;
import kr.or.ddit.vo.StowageVO;
import kr.or.ddit.vo.WarehouseVO;
import kr.or.ddit.vo.WhDetailVO;

@Mapper
public interface ILogisticsMapper {

	List<ContainerVO> containerListAll();

	List<ContainerVO> containerList(PaginationInfoVO<ContainerVO> pagingVO);
	
	List<ContainerDetailVO> containerDetail(PaginationInfoVO<ContainerDetailVO> pagingVO);

	List<WarehouseVO> warehouseListAll();

	List<WarehouseVO> warehouseList(PaginationInfoVO<WarehouseVO> pagingVO);

	List<WhDetailVO> warehouseDetail(PaginationInfoVO<WhDetailVO> pagingVO);

	int updateWh(WarehouseVO warehouseVO);

	int deleteWh(WarehouseVO warehouseVO);
	
	int getWhCount(PaginationInfoVO<WarehouseVO> pagingVO);

	int getWhDetailCount(PaginationInfoVO<WhDetailVO> pagingVO);

	int registWh(WarehouseVO warehouseVO);

	WarehouseVO warehouseBasicInfo(int whNo);

	int getContainerCount(PaginationInfoVO<ContainerVO> pagingVO);

	int updateBW(WhDetailVO whDetailVO);
	
	void updateWhDetailStatus(WhDetailVO whDetailVO);

	int updateWhDetail(WhDetailVO whDetailVO);

	int selectShipCount(PaginationInfoVO<ShipsVO> pagingVO);

	List<ShipsVO> selectShipList(PaginationInfoVO<ShipsVO> pagingVO);

	int registContainer(ContainerVO containerVO);

	int getContainerDetailCount(PaginationInfoVO<ContainerDetailVO> pagingVO);

	int getStowageCount(PaginationInfoVO<StowageVO> pagingVO);

	List<StowageVO> stowageList(PaginationInfoVO<StowageVO> pagingVO);

	ContainerVO containerBasicInfo(int containerNo);

	List<ShipScheduleVO> selectShipSheduleList(PaginationInfoVO<ShipsVO> pagingVO);

	void updateContainerDetailStatus(ContainerDetailVO containerDetailVO);

	int updateContainerDetail(ContainerDetailVO containerDetailVO);

	int updateContainer(ContainerVO conatainerVO);

	int getStowageWhCount(PaginationInfoVO<StowageVO> pagingVO);

	int getStowageContainerCount(PaginationInfoVO<StowageVO> pagingVO);

	List<StowageVO> stowageWhList(PaginationInfoVO<StowageVO> pagingVO);

	List<StowageVO> stowageContainerList(PaginationInfoVO<StowageVO> pagingVO);


}
