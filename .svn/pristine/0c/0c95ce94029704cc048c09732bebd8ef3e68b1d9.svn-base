//package kr.or.ddit.util;
//
//import java.time.Duration;
//import java.util.Date;
//import java.util.stream.Collectors;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
//import org.springframework.security.core.Authentication;
//import org.springframework.security.core.authority.SimpleGrantedAuthority;
//import org.springframework.security.core.userdetails.UserDetails;
//import org.springframework.stereotype.Component;
//
//import io.jsonwebtoken.Claims;
//import io.jsonwebtoken.Header;
//import io.jsonwebtoken.Jws;
//import io.jsonwebtoken.Jwts;
//import io.jsonwebtoken.SignatureAlgorithm;
//import kr.or.ddit.security.CustomUserDetailsService;
//import kr.or.ddit.vo.CustomUser;
//import kr.or.ddit.vo.UserVO;
//import lombok.extern.slf4j.Slf4j;
//
//@Slf4j
//@Component
//public class TokenProvider {
//	
//	// 미리 설정해둔 키값(application.properties에 설정한 프로퍼티를 JwtProperties에서 끌어씀)
//	@Autowired
//	private JwtProperties jwtProperties;
//	
//	// 사용자 검증을 위한 서비스
//	@Autowired
//	private CustomUserDetailsService userDetailsService;
//	
//	/**
//	 * 
//	 * @param userVO
//	 * @param expiredAt 유효기간
//	 * @return
//	 */
//	public String generateToken(UserVO userVO, Duration expiredAt) {
//		Date now = new Date();
//		return makeToken(new Date(now.getTime() + expiredAt.toMillis()), userVO);
//	}
//	
//	/**
//	 * 실제로 토큰을 생성하는 메서드
//	 * @param expiry
//	 * @param memberVO
//	 * @return
//	 */
//	private String makeToken(Date expiry, UserVO userVO) {
//		Date now = new Date();
//		return Jwts.builder()
//				.setHeaderParam(Header.TYPE, Header.JWT_TYPE)	// 헤더 설정
//				// 공용 설정
//				.setIssuer(jwtProperties.getIssuer())	// 발급자 설정 -> 토큰발급처
//				.setIssuedAt(now)						// 내용 iat(현재 시간), 발급시간
//				.setExpiration(expiry)					// 내용 exp(expiry 멤버 변수값), 유효시간(만료일)
//				.setSubject(userVO.getUserId())		// 내용 sub(제목: 유저 사용자 아이디)
//				// 개인 설정
//				.claim("no", userVO.getUserNo())		// 클레임 no(유저 no)
//				.claim("id", userVO.getUserId())		// 클레임 id(유저 id)
//				.claim("auth", userVO.getAuthList())	// 클레임 auth(유저 권한)
//				// 서명 
//				.signWith(SignatureAlgorithm.HS256, jwtProperties.getSecretKey().getBytes()) // 무결성 검증을 위한 키값 해싱
//				.compact(); // JWT를 문자열 형태로 변환
//	}
//	
//	/**
//	 * 
//	 * @param token
//	 * @return
//	 */
//	public boolean validToken(String token) {
//		Jws<Claims> parseToken = null;
//		try {
//			parseToken = Jwts.parser() 										/* 토큰을 파싱하기 위한 객체 생성(해석, 자동 검증) */
//					.setSigningKey(jwtProperties.getSecretKey().getBytes()) /* 검증을 위한 키값 */
//					.parseClaimsJws(token); 								/* 대상 토큰을 파싱(해석, 자동 검증) */
//		}catch(Exception e) {
//			return false;  // 토큰에 이상 발생 false 리턴
//		}
//		
//		log.info("# TokenProvider.validToken->복호화된 토큰 : " + parseToken); 	// 토큰값 로깅
//		Date exp = parseToken.getBody().getExpiration(); 					// getBody로 페이로드 값, getExpiration로 만료시간 가져옴
//		
//		// new Date()로 Sysdate와 만료일 비교
//		return !exp.before(new Date()); 
//	}
//	
//	/**
//	 * 
//	 * @param token
//	 * @return
//	 */
//	public Authentication getAuthentication(String token) {
//		
//		String userId = getUserId(token);
//		UserDetails userDetails = userDetailsService.loadUserByUsername(userId); 
//		UserVO userVO = ((CustomUser)userDetails).getUser();	
//		
//		return new UsernamePasswordAuthenticationToken(userDetails, "",
//				userVO.getAuthList().stream().map(auth->new SimpleGrantedAuthority(
//						auth.getAuthCode())).collect(Collectors.toList()));
//	}
//	
//	// 요청 토큰에서 UserId값 추출
//	public String getUserId(String token) { 
//		Claims claims = getClaims(token);
//		return claims.get("id", String.class);
//	}
//
//	// 요청 토큰에서 Claim값 추출
//	private Claims getClaims(String token) {
//		return Jwts.parser()
//				.setSigningKey(jwtProperties.getSecretKey().getBytes())
//				.parseClaimsJws(token)
//				.getBody();
//	}
//}
// 