package kr.or.ddit.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.mapper.IMyMailMapper;
import kr.or.ddit.vo.ComFileDetailVO;
import kr.or.ddit.vo.MyMailVO;
import kr.or.ddit.vo.PaginationInfoVO;
import org.springframework.transaction.annotation.Transactional;

import jakarta.mail.internet.MimeMessage;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MyMailService implements IMyMailService {
	
	@Autowired
	private IMyMailMapper myMailMapper;
	
	@Autowired
	private JavaMailSender javaMailSender;

	public MyMailService(IMyMailMapper myMailMapper, @Autowired(required = false) JavaMailSender javaMailSender) {
        this.myMailMapper = myMailMapper;
        this.javaMailSender = javaMailSender;
    }
	
	// 템플릿 관련 기능 ---------------------------------------------------------
	@Override
	public ServiceResult mailTDelete(int emailTempNo) {
		ServiceResult result = null;
		
		int status = myMailMapper.mailTDelete(emailTempNo);
		
		if(status > 0) { // 작업 성공
			result = ServiceResult.OK;
		}else { // 작업 실패
			result = ServiceResult.FAILED;
		}
		
		return result;
	}
	
	@Override
	public ServiceResult mailTInsert(MyMailVO myMailVO) {
		ServiceResult result = null;
		
		int status = myMailMapper.mailTInsert(myMailVO);
		
		if(status > 0) { // 작업 성공
			result = ServiceResult.OK;
		}else { // 작업 실패
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	// 메일 목록 조회 기능 ---------------------------------------------------------
	@Override
	public MyMailVO selectMailAllCount(int userNo) {
		return myMailMapper.selectMailAllCount(userNo);
	}

	@Override
	public List<Map<String, Object>> selectMailList(PaginationInfoVO<Map<String, Object>> pagingVO) {
		return myMailMapper.selectMailList(pagingVO);
	}
	
	@Override
	public List<Map<String, Object>> selectTempMailList(PaginationInfoVO<Map<String, Object>> pagingVO) {
		return myMailMapper.selectTempMailList(pagingVO);
	}

	@Override
	public List<Map<String, Object>> selectTrashMailList(PaginationInfoVO<Map<String, Object>> pagingVO) {
		return  myMailMapper.selectTrashMailList(pagingVO);
	}
	
	// 메일 상세 조회 기능 ---------------------------------------------------------
	@Override
	public MyMailVO mailDetail(int emailNo) {
		return myMailMapper.mailDetail(emailNo);
	}
	
	// 메일 작성 기능 ---------------------------------------------------------
	/** 메일 임시보관함 저장 및 덮어쓰기저장 */
	@Override
	@Transactional
	public ServiceResult mailTempSave(MyMailVO myMailVO) {
		ServiceResult result = null;
		int status;
		
		// 임시저장된 파일이 있으면 delete부터
		if(myMailVO.getComFileNo() != 0) {
			myMailMapper.mailComFileDetailDelete(myMailVO.getComFileNo());
			myMailMapper.mailComFileDelete(myMailVO);
		}
		// 파일 insert
		List<ComFileDetailVO> emailFileList = myMailVO.getEmailFileList();
		if (emailFileList != null && emailFileList.size() > 0) {
			try {
				// 파일이 존재하면 일단 COMFILE 테이블에 먼저 추가
				myMailMapper.mailComFileInsert(myMailVO);
				int comFileNo = myMailVO.getComFileNo();
				myMailVO.setComFileNo(comFileNo);
				for (ComFileDetailVO comFileDetailVO : emailFileList) {
					comFileDetailVO.setComFileNo(comFileNo);
					myMailMapper.mailComFileDetailInsert(comFileDetailVO);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		// 해당 메일을 처음 임시저장하면 insert
		if(myMailVO.getEmailNo() == 0) {
			status = myMailMapper.mailTempInsert(myMailVO);
		}else { // 아니면 update
			status = myMailMapper.mailTempUpdate(myMailVO);
		}
				
		if(status > 0) { // 작업 성공
			// 수신자 리스트가 비어있지 않으면 delete 후 insert
			if(!myMailVO.getRecipEmails().isEmpty()) {
				myMailMapper.mailRecipListDelete(myMailVO.getEmailNo());
			}
			List<String> recipientList = (List<String>)myMailVO.getRecipList();
			for(String recip : recipientList) {
				myMailVO.setRecipEmail(recip);
				myMailMapper.mailRecipListInsert(myMailVO);
			}
			
			result = ServiceResult.OK;
		}else { // 작업 실패
			result = ServiceResult.FAILED;
		}
		
		return result;
	}
	
	/** 외부메일 발송 */
	@Override
	@Transactional
	public ServiceResult mailGmailSend(MyMailVO myMailVO) {
		ServiceResult result = null;
		
		List<ComFileDetailVO> emailFileList = myMailVO.getEmailFileList();
		String userGmail = myMailVO.getRecipEmail();

        // 외부 메일 발송 로직
        if (javaMailSender == null) {
            log.error("JavaMailSender가 설정되지 않아 외부 메일을 발송할 수 없습니다.");
            return ServiceResult.FAILED;
        }
        try {
            MimeMessage message = javaMailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

            helper.setFrom(myMailVO.getUserId() + "@border7.kr");
            helper.setTo(userGmail);
            helper.setSubject(myMailVO.getEmailTitle());
            helper.setText(myMailVO.getEmailContent(), true);

            // 첨부파일 추가
            if (emailFileList != null && !emailFileList.isEmpty()) {
                for (ComFileDetailVO file : emailFileList) {
                    File attachment = new File(file.getComFileDetailSavePath());
                    if (attachment.exists() && attachment.isFile()) {
                        helper.addAttachment(file.getComFileDetailSaveName(), attachment);
                    } else {
                        log.warn("첨부파일을 찾을 수 없습니다: " + file.getComFileDetailSavePath());
                    }
                }
            }

            javaMailSender.send(message);
            log.info("외부 메일 발송 성공 (수신자: {}): {}", userGmail, myMailVO.getEmailTitle());

            return ServiceResult.OK;

        } catch (Exception e) {
            log.error("외부 메일 발송 실패 (수신자: {}): {}", userGmail, e.getMessage(), e);
            // 외부 메일 발송 실패 시 RuntimeException을 발생시켜 트랜잭션 롤백
            throw new RuntimeException("외부 메일 발송 실패", e);
        }
    }

	
	/** 메일 보낸메일함 저장 및 임시보관함 수정 */
	@Override
	@Transactional
	public ServiceResult mailSend(MyMailVO myMailVO) {
		ServiceResult result = null;
		int status;
		
		// 임시저장된 파일이 있으면 delete부터
		if(myMailVO.getComFileNo() != 0) {
			myMailMapper.mailComFileDetailDelete(myMailVO.getComFileNo());
			myMailMapper.mailComFileDelete(myMailVO);
		}
		// 파일 insert
		List<ComFileDetailVO> emailFileList = myMailVO.getEmailFileList();
		if (emailFileList != null && emailFileList.size() > 0) {
			try {
				// 파일이 존재하면 일단 COMFILE 테이블에 먼저 추가
				myMailMapper.mailComFileInsert(myMailVO);
				int comFileNo = myMailVO.getComFileNo();
				myMailVO.setComFileNo(comFileNo);
				for (ComFileDetailVO comFileDetailVO : emailFileList) {
					comFileDetailVO.setComFileNo(comFileNo);
					myMailMapper.mailComFileDetailInsert(comFileDetailVO);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		// 해당 메일이 신규 작성 발송이면
		if(myMailVO.getEmailNo() == 0) {
			status = myMailMapper.mailSendInsert(myMailVO);
		}else { // 아니면(임시메일 작업 발송이면) update
			status = myMailMapper.mailSendUpdate(myMailVO);
		}
		
		if(status > 0) { // 작업 성공
			// 수신자 리스트가 비어있지 않으면 delete부터
			if(!myMailVO.getRecipEmails().isEmpty()) {
				myMailMapper.mailRecipListDelete(myMailVO.getEmailNo());
			}
			// 수신자 리스트 insert
			myMailVO.setRecipType("recip");
			List<String> recipientList = (List<String>)myMailVO.getRecipList();
			List<Integer> recipUserNoList = (List<Integer>)myMailVO.getRecipUserNoList();
			for(int i=0; i<recipientList.size(); i++) {
				String recipEmail = recipientList.get(i);
				int recipNo = recipUserNoList.get(i);
				myMailVO.setRecipEmail(recipEmail);
				myMailVO.setRecipUserNo(recipNo);
				myMailMapper.mailRecipListInsert(myMailVO);
			}

			result = ServiceResult.OK;
		}else { // 작업 실패
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	@Override
	public ServiceResult mailRead(List<Map<String, Object>> selectMailList) {
		ServiceResult result = null;
		
		// 받은메일만 읽음 작업
		try {
			for(Map mail : selectMailList) {
				Object recipNoObj = mail.get("recipNo");
				
				if(recipNoObj != null && !recipNoObj.equals("")) {
					int recipNo = 0;
					if (recipNoObj instanceof Integer) {
                        recipNo = (Integer) recipNoObj;
                    } else if (recipNoObj instanceof Long) {
                        recipNo = ((Long) recipNoObj).intValue();
                    }
					myMailMapper.mailRead(recipNo);
				}
			}
			result = ServiceResult.OK;
		} catch (Exception e) {
			result = ServiceResult.FAILED;
		}

		return result;
	}

	@Override
	public ServiceResult mailTrash(List<Map<String, Object>> selectMailList) {
		ServiceResult result = null;
		// 받은메일일 때와 아닐 때를 구분하여 처리
		try {
			for(Map mail : selectMailList) {
				Object recipNoObj = mail.get("recipNo");
				Object emailNoObj = mail.get("emailNo");
				if(recipNoObj != null && !recipNoObj.equals("")) { // 받은 메일일 때
					int recipNo = 0;
					if (recipNoObj instanceof Integer) {
                        recipNo = (Integer) recipNoObj;
                    } else if (recipNoObj instanceof Long) {
                        recipNo = ((Long) recipNoObj).intValue();
                    }
					myMailMapper.mailTrashRecip(recipNo);
				}else { // 받은 메일이 아닐 때
					myMailMapper.mailTrashSend(emailNoObj);
				}
			}
			result = ServiceResult.OK;
		} catch (Exception e) {
			result = ServiceResult.FAILED;
		}

		return result;
	}

	@Override
	public ServiceResult mailDelete(List<Map<String, Object>> selectMailList) {
		ServiceResult result = null;
		// 받은메일일 때와 아닐 때를 구분하여 처리
		try {
			for(Map mail : selectMailList) {
				Object recipNoObj = mail.get("recipNo");
				Object emailNoObj = mail.get("emailNo");
				if(recipNoObj != null && !recipNoObj.equals("")) { // 받은 메일일 때
					int recipNo = 0;
					if (recipNoObj instanceof Integer) {
                        recipNo = (Integer) recipNoObj;
                    } else if (recipNoObj instanceof Long) {
                        recipNo = ((Long) recipNoObj).intValue();
                    }
					myMailMapper.mailDeleteRecip(recipNo);
				}else { // 받은 메일이 아닐 때
					int emailNo = 0;
					if (emailNoObj instanceof Integer) {
						emailNo = (Integer) emailNoObj;
                    } else if (emailNoObj instanceof Long) {
                    	emailNo = ((Long) emailNoObj).intValue();
                    } else if (emailNoObj instanceof String) {
                    	String strEmailNo = (String) emailNoObj;
                    	emailNo = Integer.parseInt(strEmailNo);
                    }
					myMailMapper.mailDeleteSend(emailNo);
				}
			}
			result = ServiceResult.OK;
		} catch (Exception e) {
			result = ServiceResult.FAILED;
		}

		return result;
	}

	@Override
	public ServiceResult updateStar(MyMailVO myMailVO) {
		ServiceResult result = null;
		try {
			myMailMapper.updateStar(myMailVO);
			result = ServiceResult.OK;
		} catch (Exception e) {
			result = ServiceResult.FAILED;
		}

		return result;
	}

	@Override
	public List<ComFileDetailVO> mailDetailFiles(int comFileNo) {
		return myMailMapper.mailDetailFiles(comFileNo);
	}

	@Override
	public ComFileDetailVO mailDetailFileOne(int comFileDetailNo) {
		return myMailMapper.mailDetailFileOne(comFileDetailNo);
	}


}
