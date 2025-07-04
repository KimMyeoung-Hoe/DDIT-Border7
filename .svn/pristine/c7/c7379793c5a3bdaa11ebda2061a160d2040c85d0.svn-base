package kr.or.ddit.ci.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.vo.CIVO;

@Mapper
public interface ICIMapper {
	public int insertCI(CIVO civo);
	public CIVO selectCI(int ciNo);
	public int updateCI(CIVO ciVO);
	public int updateContractCI(Map<String,Object> map);

}
