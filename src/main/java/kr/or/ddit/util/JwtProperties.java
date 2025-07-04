package kr.or.ddit.util;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import lombok.Data;

@Data
@Component
@ConfigurationProperties("kr.or.ddit.jwt")
public class JwtProperties {
	
		private String issuer;
		private String secretKey;
}
