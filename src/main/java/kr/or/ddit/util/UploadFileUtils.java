package kr.or.ddit.util;

import java.awt.image.BufferedImage;
import java.io.File;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.springframework.util.FileCopyUtils;

public class UploadFileUtils {
	/*
	 * 1. '/년/월/일' 폴더 경로를 만들고, 해당 경로를 리턴받는다
	 * 2. 서버 업로드 경로 + /년/월/일 + CRUD_원본파일명 형태로 파일 복사를 진행한다.
	 * 3. 업로드 한 파일이 이미지라면 's_'가 붙은 썸네일 이미지를 만든다.
	 */
	
	public static String uploadFile(String uploadPath, String originalName, byte[] fileData) throws Exception {
		UUID uuid = UUID.randomUUID(); // 중복되지 않는 uuid 생성
		String savedName = uuid.toString() + "_"+ originalName; // UUID_원본파일명
		
		// 2025/04/16 폴더 경로를 만들고, '/2025/04/16/'폴더 경로를 리턴한다.
		String savedPath = calcPath(uploadPath);
		
		// 배포된 서버 업로드 경로 + 2025/04/16 + UUID_원본파일명으로 File
		File target = new File(uploadPath + savedPath, savedName);
		FileCopyUtils.copy(fileData, target); // 해당 경로에 업로드 한 파일 복사
		
		// 확장자 추출
		String formatName = originalName.substring(originalName.lastIndexOf(".")+1);
		
		// 확장자가 이미지 파일이면 's_'가 붙은 파일의 썸네일 이미지 파일을 생성한다.
		if(MediaUtils.getMediaType(formatName) != null) { // 이미지 확장자라면 MediaType이 null이 아님
			makeThumnail(uploadPath, savedPath, savedName);
		}
		// \2025\03\07 경로를 '/' 경로로 변경 후 원본 파일명을 붙인다.
		// File.separatorChar는 시스템에 따라 달라지는 기본 이름 구분 기호입니다.
		// Unix 시스템에서는 이 필드의 값이 '/'이고 Microsoft Windows 시스템에서는 '\\'dlqslek.
		String uploadedFileName = savedPath.replace(File.separatorChar, '/') + "/" + savedName;
		
		return uploadedFileName;
	}
	private static void makeThumnail(String uploadPath, String savedPath, String savedName) throws Exception {
		BufferedImage sourceImg = ImageIO.read(new File(uploadPath+ savedPath, savedName));
		// 썸네일 이미지를 만들기 위한 설정을 진행
		// Method.AUTOMATIC : 최소시간내에 가장 잘 보이는 이미지를 얻기 위한 사용 방식
		// Mode.FIT_TO_HEIGHT : 이미지 방향과 상관없이 주어진 높이 내에서 가장 잘 맞는 이미지로 계산
		// targetSize :  값 100, 정사각형 사이즈로 100x100
		BufferedImage destImg =  Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC,Scalr.Mode.FIT_TO_HEIGHT,100);
		String thumbnailName = uploadPath + savedPath + File.separator + "s_" + savedName;
		
		File newFile = new File(thumbnailName); // 썸네일 이미지를 복사할 타겟 설정
		String formatName = savedName.substring(savedName.lastIndexOf(".")+1);
		
		// "s_" 가 붙은 썸네일 이미지를 만든다
		ImageIO.write(destImg, formatName.toUpperCase(), newFile);
		
	}
	// '2025/04/16' 과 같은 현재의 /년/월/일 폴더 경로를 만든다.
	private static String calcPath(String uploadPath) {
		Calendar cal = Calendar.getInstance();
		String yearPath = File.separator + cal.get(Calendar.YEAR); // 2025
		String monthPath = yearPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.MONTH)+1); // 2025/04
		String datePath = monthPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.DATE)+1); // 2025/04/16
		
		// 진짜로 폴더 경로에 맞춰 폴더 생성 
		makeDir(uploadPath,yearPath,monthPath,datePath);
		return datePath;
	}
	// 년월일 폴더 구조에 맞춰 폴더 생성
	private static void makeDir(String uploadPath, String...paths) {
		//만들려던 폴더 구조가 이미 만들어져있다면 return
		if(new File(paths[paths.length -1]).exists()) {
			return;
		}
		
		for(String path : paths) {
			File dirPath = new File(uploadPath + path);
			
			//
			if(!dirPath.exists()) {
				dirPath.mkdirs();
			}
		}
	}
}
