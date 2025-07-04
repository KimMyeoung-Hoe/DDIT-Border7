package kr.or.ddit.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.user.mapper.ILogisticsMapper;
import kr.or.ddit.vo.ContainerDetailVO;
import kr.or.ddit.vo.ContainerVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.ShipScheduleVO;
import kr.or.ddit.vo.ShipsVO;
import kr.or.ddit.vo.StowageVO;
import kr.or.ddit.vo.WarehouseVO;
import kr.or.ddit.vo.WhDetailVO;

@Service
public class LogisticsServiceImpl implements ILogisticsService{
	
	@Autowired
	private ILogisticsMapper logisticsMapper;
	
	@Override
	public List<ContainerVO> containerListAll() {
		
		return logisticsMapper.containerListAll();
	}

	@Override
	public List<ContainerVO> containerList(PaginationInfoVO<ContainerVO> pagingVO) {
		
		return logisticsMapper.containerList(pagingVO);
	}

	@Override
	public List<WarehouseVO> warehouseListAll() {

		return logisticsMapper.warehouseListAll();
	}

	@Override
	public List<WarehouseVO> warehouseList(PaginationInfoVO<WarehouseVO> pagingVO) {
		
		return logisticsMapper.warehouseList(pagingVO);
	}

	@Override
	public List<WhDetailVO> warehouseDetail(PaginationInfoVO<WhDetailVO> pagingVO) {
		
		return logisticsMapper.warehouseDetail(pagingVO);
	}

	@Override
	public int updateWhDetailStatus(WhDetailVO whDetailVO) {
		
		logisticsMapper.updateWhDetailStatus(whDetailVO);
		
		return whDetailVO.getResult();
	}

	@Override
	public int updateWh(WarehouseVO warehouseVO) {
		
		return logisticsMapper.updateWh(warehouseVO);
	}

	@Override
	public int deleteWh(WarehouseVO warehouseVO) {
		
		return logisticsMapper.deleteWh(warehouseVO);
	}

	@Override
	public int getWhDetailCount(PaginationInfoVO<WhDetailVO> pagingVO) {
		
		return logisticsMapper.getWhDetailCount(pagingVO);
	}

	@Override
	public int getWhCount(PaginationInfoVO<WarehouseVO> pagingVO) {
		
		return logisticsMapper.getWhCount(pagingVO);
	}

	@Override
	public int registWh(WarehouseVO warehouseVO) {
		
		return logisticsMapper.registWh(warehouseVO);
	}

	@Override
	public WarehouseVO warehouseBasicInfo(int whNo) {
	
		return logisticsMapper.warehouseBasicInfo(whNo);
	}

	@Override
	public int getContainerCount(PaginationInfoVO<ContainerVO> pagingVO) {
		
		return logisticsMapper.getContainerCount(pagingVO);
	}

	@Override
	public int updateBW(WhDetailVO whDetailVO) {
		
		return logisticsMapper.updateBW(whDetailVO);
	}

	@Override
	public int updateWhDetail(WhDetailVO whDetailVO) {
		
		return logisticsMapper.updateWhDetail(whDetailVO);
	}

	@Override
	public int selectShipCount(PaginationInfoVO<ShipsVO> pagingVO) {
		
		return logisticsMapper.selectShipCount(pagingVO);
	}

	@Override
	public List<ShipsVO> selectShipList(PaginationInfoVO<ShipsVO> pagingVO) {
		
		return logisticsMapper.selectShipList(pagingVO);
	}

	@Override
	public int registContainer(ContainerVO containerVO) {
		
		return logisticsMapper.registContainer(containerVO);
	}

	@Override
	public List<ContainerDetailVO> containerDetail(PaginationInfoVO<ContainerDetailVO> pagingVO) {
		
		return logisticsMapper.containerDetail(pagingVO);
	}

	@Override
	public int getContainerDetailCount(PaginationInfoVO<ContainerDetailVO> pagingVO) {
		
		return logisticsMapper.getContainerDetailCount(pagingVO);
	}

	@Override
	public int getStowageCount(PaginationInfoVO<StowageVO> pagingVO) {
		
		if(pagingVO.getWaitting() != null) {
			if(pagingVO.getWaitting().equals("wh")) {
				return logisticsMapper.getStowageWhCount(pagingVO);
			}else if(pagingVO.getWaitting().equals("container")) {
				return logisticsMapper.getStowageContainerCount(pagingVO);
			}
		}
		return logisticsMapper.getStowageCount(pagingVO);
	}

	@Override
	public List<StowageVO> stowageList(PaginationInfoVO<StowageVO> pagingVO) {
		
		if(pagingVO.getWaitting() != null) {
			if(pagingVO.getWaitting().equals("wh")) {
				return logisticsMapper.stowageWhList(pagingVO);
			}else if(pagingVO.getWaitting().equals("container")) {
				return logisticsMapper.stowageContainerList(pagingVO);
			}
		}
		
		return logisticsMapper.stowageList(pagingVO);
		
	}

	@Override
	public ContainerVO containerBasicInfo(int containerNo) {
		
		return logisticsMapper.containerBasicInfo(containerNo);
	}

	@Override
	public List<ShipScheduleVO> selectShipSheduleList(PaginationInfoVO<ShipsVO> pagingVO) {
		return  logisticsMapper.selectShipSheduleList(pagingVO);
	}

	@Override
	public int updateContainerDetailStatus(ContainerDetailVO containerDetailVO) {
		
		logisticsMapper.updateContainerDetailStatus(containerDetailVO);
		
		return containerDetailVO.getResult();
	}

	@Override
	public int updateContainerDetail(ContainerDetailVO containerDetailVO) {

		return logisticsMapper.updateContainerDetail(containerDetailVO);
	}

	@Override
	public int updateContainer(ContainerVO conatainerVO) {
		// TODO Auto-generated method stub
		return logisticsMapper.updateContainer(conatainerVO);
	}
	
	
}
