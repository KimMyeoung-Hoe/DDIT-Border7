package kr.or.ddit.util;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.MediaType;

public class MediaUtils {
	
	private static Map<String, MediaType> mediaMap;
	
	static {
		mediaMap = new HashMap<>();
		mediaMap.put("JPG", MediaType.IMAGE_JPEG);
		mediaMap.put("PNG", MediaType.IMAGE_PNG);
		mediaMap.put("GIF", MediaType.IMAGE_GIF);
	}
	
	// 클라이언트로부터 전송받은 파일 uploadFile() 메소드로 전송해 파일 업로드를 진행한다.
	// 이때 , 파일 업로드 후 업로드 된 파일을 활용해 만든 파일 경로를 받아온다(폴더경로 + 파일명)
	public static MediaType getMediaType(String type) {
		return mediaMap.get(type.toUpperCase());
	}
}
