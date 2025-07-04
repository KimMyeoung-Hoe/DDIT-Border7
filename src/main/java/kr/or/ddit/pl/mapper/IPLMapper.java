package kr.or.ddit.pl.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.vo.PLVO;

@Mapper
public interface IPLMapper {

	public int insertPL(PLVO plVO);
	public PLVO selectPL(int plNo);
	public int updateContractPL(Map<String,Object> map);

}
