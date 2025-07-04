package kr.or.ddit.pdf.service;

import java.io.File;
import java.io.IOException;
import java.net.URI;
import java.net.URLEncoder;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import com.itextpdf.html2pdf.HtmlConverter;
import com.itextpdf.html2pdf.ConverterProperties;
import com.itextpdf.html2pdf.resolver.font.DefaultFontProvider;
import com.itextpdf.io.font.FontProgram;
import com.itextpdf.io.font.FontProgramFactory;
import com.itextpdf.kernel.pdf.PdfDocument; // PdfDocument 사용을 위해 추가
import com.itextpdf.kernel.pdf.PdfWriter;

import org.jsoup.Jsoup; // Jsoup import 추가
import org.jsoup.nodes.Document; // Jsoup Document import 추가
import org.jsoup.nodes.Element; // Jsoup Element import 추가


@Service
public class PdfServiceImpl implements PdfService {

    // PDF 출력 기본 경로를 상수로 정의
//    private static final String PDF_OUTPUT_DIR = "C:/upload/pdf_output/";
    @Value("${kr.or.ddit.upload.pdf.path}")
    private String pdfuploadPath;

    @Override
    public String createPdf(String docType, String docNo) {
    	
        String result = "";

        // PDF 출력 디렉토리 존재 여부 확인 및 생성
        File outputDirectory = new File(pdfuploadPath);
        if (!outputDirectory.exists()) {
            boolean created = outputDirectory.mkdirs();
            if (!created) {
                return "PDF 출력 디렉토리 생성 실패: " + pdfuploadPath;
            }
        }

        // PDF 파일 저장 경로 및 파일명 결정
        String pdfFileName = docType + "_" + docNo + ".pdf";
        String pdfFilePath = pdfuploadPath + pdfFileName;

        String baseUrl = ServletUriComponentsBuilder.fromCurrentContextPath().build().toUriString()+"/";
        
        // PDF로 변환할 HTML 콘텐츠를 가져올 내부 엔드포인트 URL
        // docType과 docNo를 URL 경로 및 쿼리 파라미터로 전달하여, 해당 데이터에 맞는 HTML을 받습니다.
        String jspHtmlUrl = baseUrl // 애플리케이션 포트에 맞게 수정
                            + URLEncoder.encode(docType, StandardCharsets.UTF_8) // 예: ci, pl (문서 타입)
                            + "/detail.do?"
                            + URLEncoder.encode(docType, StandardCharsets.UTF_8) + "No=" // 예: ciNo, plNo (문서 번호 파라미터 이름)
                            + URLEncoder.encode(docNo, StandardCharsets.UTF_8); // 예: 12345 (문서 번호 값)

        System.out.println("HTML 콘텐츠를 가져올 URL: " + jspHtmlUrl); // 디버깅용 로그

        try {
            // 1단계: 지정된 URL에서 HTML 콘텐츠 가져오기 (HTTP 클라이언트 사용)
            HttpClient client = HttpClient.newHttpClient();
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(jspHtmlUrl))
                    .build();

            HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
            String htmlContent = response.body(); // HTTP 응답 바디 (HTML 내용)

            if (htmlContent == null || htmlContent.trim().isEmpty()) {
                throw new RuntimeException("JSP URL [" + jspHtmlUrl + "]에서 HTML 콘텐츠를 가져오는 데 실패했습니다. 응답이 비어있거나 NULL입니다.");
            }

            
            // 가져온 HTML 콘텐츠의 일부를 로그로 출력 (디버깅용)
            System.out.println("가져온 HTML 콘텐츠 (앞 500자): " + htmlContent.substring(0, Math.min(htmlContent.length(), 500)) + "...");

            // Jsoup을 사용하여 HTML 파싱 및 특정 ID 요소 선택
            Document doc = Jsoup.parse(htmlContent);
            // PDF로 변환할 HTML 요소의 CSS 선택자 지정 (예: <div id="pdf-target">...</div>)
            String targetElementId = "pdfTarget"; // HTML에서 PDF로 변환하고자 하는 ID 값
            Element targetElement = doc.getElementById(targetElementId);

            if (targetElement == null) {
                throw new IllegalArgumentException("HTML에 ID '" + targetElementId + "'를 가진 요소를 찾을 수 없습니다. PDF 변환 대상을 확인하세요.");
            }
            
            // 선택된 요소의 HTML을 문자열로 가져오기
            String htmlToConvert = targetElement.outerHtml();
            System.out.println("PDF로 변환될 HTML (앞 200자): " + htmlToConvert.substring(0, Math.min(htmlToConvert.length(), 200)) + "...");

            // 2단계: iText Html2Pdf를 사용하여 HTML을 PDF로 변환
            PdfWriter writer = new PdfWriter(pdfFilePath);
            PdfDocument pdfDoc = new PdfDocument(writer);

            // 한글 글꼴 설정 및 폰트 프로바이더에 등록 (한글 깨짐 해결의 핵심!)
            // 'malgun.ttf' 폰트 파일이 실제로 존재하고 애플리케이션이 접근 가능한지 확인 필수!
            String fontPath = "c:/windows/fonts/malgun.ttf"; // 실제 폰트 파일 경로
            ConverterProperties converterProperties = new ConverterProperties();
            DefaultFontProvider fontProvider = new DefaultFontProvider(false, false, false);

            
            File fontFile = new File(fontPath);
            if (fontFile.exists() && fontFile.canRead()) {
                fontProvider.addFont(fontPath); // 'Malgun Gothic'과 같은 한글 폰트 추가
                System.out.println("폰트 '" + fontPath + "'가 성공적으로 로드되었습니다.");
            } else {
                System.err.println("경고: 폰트 파일이 없거나 읽을 수 없습니다. 경로를 확인하세요: " + fontPath);
                // 대안 폰트 또는 기본 폰트 사용 고려
            }
            
            converterProperties.setFontProvider(fontProvider); // 변환 속성에 폰트 프로바이더 설정

            // HtmlConverter.convertToPdf 호출 시 PdfDocument 객체, HTML 문자열, ConverterProperties를 전달
            HtmlConverter.convertToPdf(htmlToConvert, pdfDoc, converterProperties);

            // 중요: PdfDocument를 닫아서 리소스를 해제하고 파일 쓰기를 완료합니다.
            pdfDoc.close();

            result = "PDF 파일이 성공적으로 생성되었습니다: " + pdfFilePath;

        } catch (IOException e) {
            result = "PDF 파일 생성 실패 (입출력 오류): " + e.getMessage();
            e.printStackTrace();
        } catch (InterruptedException e) {
            result = "PDF 파일 생성 실패 (HTTP 요청 중단): " + e.getMessage();
            Thread.currentThread().interrupt(); // 인터럽트 상태 복원
            e.printStackTrace();
        } catch (IllegalArgumentException e) {
            result = "PDF 파일 생성 실패 (잘못된 인자): " + e.getMessage();
            e.printStackTrace();
        } catch (RuntimeException e) {
            result = "PDF 파일 생성 실패 (런타임 오류): " + e.getMessage();
            e.printStackTrace();
        } catch (Exception e) {
            result = "PDF 파일 생성 중 알 수 없는 오류 발생: " + e.getMessage();
            e.printStackTrace();
        }

        return result;
    }

	@Override
	public String createPdf2(String url) {
		String result = "";

        // PDF 출력 디렉토리 존재 여부 확인 및 생성
        File outputDirectory = new File(pdfuploadPath);
        if (!outputDirectory.exists()) {
            boolean created = outputDirectory.mkdirs();
            if (!created) {
                return "PDF 출력 디렉토리 생성 실패: " + pdfuploadPath;
            }
        }

        // PDF 파일 저장 경로 및 파일명 결정
        String pdfFileName = url.substring(url.lastIndexOf("=")+1) + ".pdf";
        String pdfFilePath = pdfuploadPath + pdfFileName;

        String baseUrl = ServletUriComponentsBuilder.fromCurrentContextPath().build().toUriString()+"/";
        
        // PDF로 변환할 HTML 콘텐츠를 가져올 내부 엔드포인트 URL
        // docType과 docNo를 URL 경로 및 쿼리 파라미터로 전달하여, 해당 데이터에 맞는 HTML을 받습니다.
        String jspHtmlUrl = baseUrl // 애플리케이션 포트에 맞게 수정
                            + url;

        System.out.println("HTML 콘텐츠를 가져올 URL: " + jspHtmlUrl); // 디버깅용 로그

        try {
            // 1단계: 지정된 URL에서 HTML 콘텐츠 가져오기 (HTTP 클라이언트 사용)
            HttpClient client = HttpClient.newHttpClient();
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(jspHtmlUrl))
                    .build();

            HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
            String htmlContent = response.body(); // HTTP 응답 바디 (HTML 내용)

            if (htmlContent == null || htmlContent.trim().isEmpty()) {
                throw new RuntimeException("JSP URL [" + jspHtmlUrl + "]에서 HTML 콘텐츠를 가져오는 데 실패했습니다. 응답이 비어있거나 NULL입니다.");
            }

            
            // 가져온 HTML 콘텐츠의 일부를 로그로 출력 (디버깅용)
            System.out.println("가져온 HTML 콘텐츠 (앞 500자): " + htmlContent.substring(0, Math.min(htmlContent.length(), 500)) + "...");

            // Jsoup을 사용하여 HTML 파싱 및 특정 ID 요소 선택
            Document doc = Jsoup.parse(htmlContent);
            // PDF로 변환할 HTML 요소의 CSS 선택자 지정 (예: <div id="pdf-target">...</div>)
            String targetElementId = "pdfTarget"; // HTML에서 PDF로 변환하고자 하는 ID 값
            Element targetElement = doc.getElementById(targetElementId);

            if (targetElement == null) {
                throw new IllegalArgumentException("HTML에 ID '" + targetElementId + "'를 가진 요소를 찾을 수 없습니다. PDF 변환 대상을 확인하세요.");
            }
            
            // 선택된 요소의 HTML을 문자열로 가져오기
            String htmlToConvert = targetElement.outerHtml();
            System.out.println("PDF로 변환될 HTML (앞 200자): " + htmlToConvert.substring(0, Math.min(htmlToConvert.length(), 200)) + "...");

            // 2단계: iText Html2Pdf를 사용하여 HTML을 PDF로 변환
            PdfWriter writer = new PdfWriter(pdfFilePath);
            PdfDocument pdfDoc = new PdfDocument(writer);

            // 한글 글꼴 설정 및 폰트 프로바이더에 등록 (한글 깨짐 해결의 핵심!)
            // 'malgun.ttf' 폰트 파일이 실제로 존재하고 애플리케이션이 접근 가능한지 확인 필수!
            String fontPath = "c:/windows/fonts/malgun.ttf"; // 실제 폰트 파일 경로
            ConverterProperties converterProperties = new ConverterProperties();
            DefaultFontProvider fontProvider = new DefaultFontProvider(false, false, false);

            
            File fontFile = new File(fontPath);
            if (fontFile.exists() && fontFile.canRead()) {
                fontProvider.addFont(fontPath); // 'Malgun Gothic'과 같은 한글 폰트 추가
                System.out.println("폰트 '" + fontPath + "'가 성공적으로 로드되었습니다.");
            } else {
                System.err.println("경고: 폰트 파일이 없거나 읽을 수 없습니다. 경로를 확인하세요: " + fontPath);
                // 대안 폰트 또는 기본 폰트 사용 고려
            }
            
            converterProperties.setFontProvider(fontProvider); // 변환 속성에 폰트 프로바이더 설정

            // HtmlConverter.convertToPdf 호출 시 PdfDocument 객체, HTML 문자열, ConverterProperties를 전달
            HtmlConverter.convertToPdf(htmlToConvert, pdfDoc, converterProperties);

            // 중요: PdfDocument를 닫아서 리소스를 해제하고 파일 쓰기를 완료합니다.
            pdfDoc.close();

            result = pdfFilePath;

        } catch (IOException e) {
            result = "PDF 파일 생성 실패 (입출력 오류): " + e.getMessage();
            e.printStackTrace();
        } catch (InterruptedException e) {
            result = "PDF 파일 생성 실패 (HTTP 요청 중단): " + e.getMessage();
            Thread.currentThread().interrupt(); // 인터럽트 상태 복원
            e.printStackTrace();
        } catch (IllegalArgumentException e) {
            result = "PDF 파일 생성 실패 (잘못된 인자): " + e.getMessage();
            e.printStackTrace();
        } catch (RuntimeException e) {
            result = "PDF 파일 생성 실패 (런타임 오류): " + e.getMessage();
            e.printStackTrace();
        } catch (Exception e) {
            result = "PDF 파일 생성 중 알 수 없는 오류 발생: " + e.getMessage();
            e.printStackTrace();
        }

        return result;
	}
	
	
}