package kr.or.ddit.contract.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.or.ddit.contract.service.IContractService;
import kr.or.ddit.vo.ContractVO;
import kr.or.ddit.vo.HsCodeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/contract/api")
public class ContractRestController {
	
	@Autowired
	public IContractService contractService;
	
	/**
	 * contractService.selectdeclDToContract 를 통해 가져오는데이터 시각화해서 보기위해
	 * @param contractNo
	 * @param model
	 * @return
	 */
	@ResponseBody
	@GetMapping("/selectdeclDToContract.do")
	public ResponseEntity<ContractVO> selectdeclDToContract(String contractNo, Model model) {
		ContractVO contractVO = contractService.selectdeclDToContract(contractNo);
		return new ResponseEntity<ContractVO>(contractVO,HttpStatus.OK);
	}
	
	@ResponseBody
	@GetMapping("/selectContract.do")
	public ResponseEntity<ContractVO> selectContract(String contractNo, Model model) {
		ContractVO contractVO = contractService.selectdeclDToContract(contractNo);
		return new ResponseEntity<ContractVO>(contractVO,HttpStatus.OK);
	}
}
