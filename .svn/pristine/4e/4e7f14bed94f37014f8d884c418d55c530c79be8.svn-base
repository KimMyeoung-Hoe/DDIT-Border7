package kr.or.ddit.user.mapper;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.ServiceResult;

import kr.or.ddit.vo.UserVO;

@Mapper
public interface IUserMapper {

	public UserVO login(UserVO userId);
	
	public UserVO readByUserInfo(String userId);
	
	public int registUser(UserVO userVO);

	public void registLogistics(UserVO userVO);

	public void registCCA(UserVO userVO);

	public void registConsignor(UserVO userVO);

	public int cntConsignor();

	public int checkId(String userId);

	public String findId(UserVO user);

	public String findpw(UserVO user);

	public int updatePw(UserVO user);

	public int selectUserNo(String userId);
	public String selectUserId(int userNo);
	public String selectUserMail(int ccaNo);
	public int selectUserMailYn(int ccaNo);

	public ServiceResult checkPw(UserVO userVO);


}
