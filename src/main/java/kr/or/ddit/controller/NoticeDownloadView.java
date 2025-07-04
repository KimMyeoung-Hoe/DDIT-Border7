package kr.or.ddit.controller;

import java.io.File;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.web.servlet.view.AbstractView;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class NoticeDownloadView extends AbstractView {

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Map<String, Object> noticeFileMap =  (Map<String, Object>) model.get("noticeFileMap");
		
		//파일 경로를 가져옴
		File saveFile = new File(noticeFileMap.get("fileSavepath").toString());
		//파일명을 가져옴
		String fileName = noticeFileMap.get("fileName").toString();
		
		//Os,브라우저 버전을 가지고있는값임
		String agent = request.getHeader("User-Agent");
		
		if (StringUtils.containsIgnoreCase(agent,"msie")||
				StringUtils.containsIgnoreCase(agent, "trident")) {
			fileName = URLEncoder.encode(fileName,"UTF-8");
		}else {
			fileName = new String(fileName.getBytes(),"ISO-8859-1");
		}
		response.setHeader("Content-Disposition","attachment; filename=\""+fileName+"\"");
		response.setHeader("Content-Length",noticeFileMap.get("fileSize").toString());
		
		//try(){} : try with resource
		//() 안에 명시한 객체는 finally로 최종 열린 객체에 대한 close를 처리하지 않아도 자동 close 해줌
		try(
				OutputStream os = response.getOutputStream();
				) {
			FileUtils.copyFile(saveFile, os);
		}
		
	}

	

}
