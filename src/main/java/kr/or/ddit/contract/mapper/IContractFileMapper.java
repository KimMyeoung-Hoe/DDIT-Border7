package kr.or.ddit.contract.mapper;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.ContractFileAttachVO;

@Mapper
public interface IContractFileMapper {

	public void insertFile(ContractFileAttachVO attachVO);

}
