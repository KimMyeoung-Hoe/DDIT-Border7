package kr.or.ddit.user.service;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.vo.UserVO;

public interface IUserService {

	public UserVO userInfo(String userId);
	
	public UserVO signin(UserVO userVO);

	public ServiceResult registUser(UserVO userVO);

	public int checkId(String userId);

	public String findId(UserVO user);

	public String findpw(UserVO user);

	public int updatePw(UserVO user);
	
	/** userId를 통해 userNo를 추출
	 * @param userId
	 * @return (int)userNo
	 */
	public int selectUserNo(String userId);

	/** userId와 입력받은 userPw를 받아서 비밀번호 일치 확인
	 * @param userVO
	 * @return ServiceResult
	 */
	public int checkPw(UserVO userVO);

	/** userId와 userPw를 받아서 비밀번호 수정
	 * @param userVO
	 * @return ServiceResult
	 */
	public ServiceResult changePw(UserVO userVO); 
}
