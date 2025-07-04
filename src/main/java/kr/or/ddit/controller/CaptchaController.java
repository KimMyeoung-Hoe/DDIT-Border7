package kr.or.ddit.controller;

import org.springframework.stereotype.Controller; // @RestController 대신 @Controller 사용
import org.springframework.ui.Model; // JSP에 데이터를 전달하기 위함
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping; // 캡차 검증은 POST 요청으로 받는 것이 일반적
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody; // JSON 응답이 필요할 때 사용

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import com.fasterxml.jackson.databind.ObjectMapper; // JSON 파싱을 위해 추가 (build.gradle/pom.xml에 의존성 추가 필요)

@Controller // JSP 뷰를 반환할 것이므로 @Controller를 사용합니다.
public class CaptchaController {

    // 애플리케이션 클라이언트 아이디/시크릿은 외부에 노출되지 않도록 서버에 보관합니다.
    private final String clientId = "JzmJgdN08qH4gSJXcJpU"; // 애플리케이션 클라이언트 아이디값
    private final String clientSecret = "rL1ZWhuAP3"; // 애플리케이션 클라이언트 시크릿값

    // JSON 파싱을 위한 ObjectMapper
    private final ObjectMapper objectMapper = new ObjectMapper();

    /**
     * 캡차 페이지 진입 및 캡차 키 발급 처리
     * 이 메서드는 JSP 페이지를 반환하며, 캡차 키와 이미지 URL을 모델에 담아 JSP로 전달합니다.
     */
    @GetMapping("/captcha/page.do")
    @ResponseBody
    public String showCaptchaPage(Model model) {
        String key = null;
        String captchaImageUrl = null;

        try {
            // 1. 네이버 캡차 키 발급 API 호출 (code=0)
            String apiURL = "https://openapi.naver.com/v1/captcha/nkey?code=0";
            Map<String, String> requestHeaders = new HashMap<>();
            requestHeaders.put("X-Naver-Client-Id", clientId);
            requestHeaders.put("X-Naver-Client-Secret", clientSecret);
            String responseBody = get(apiURL, requestHeaders);

            // 2. JSON 응답 파싱하여 'key' 값 추출
            // {"key":"발급된_키", "value":"캡차_이미지_값"}
            Map<String, String> responseMap = objectMapper.readValue(responseBody, Map.class);
            key = responseMap.get("key");

            // 3. 캡차 이미지를 가져올 URL 생성
            // Spring Boot에서 직접 캡차 이미지를 제공하는 엔드포인트를 만들 수도 있지만,
            // 여기서는 클라이언트(JSP)가 직접 네이버 API로 요청하도록 URL을 전달합니다.
            // 하지만 보안상 민감 정보(클라이언트 ID/시크릿) 노출 우려가 있으므로,
            // Spring Boot가 프록시 역할을 하여 이미지를 받아와서 서빙하는 것이 좋습니다.
            // 아래 예시에서는 간단히 네이버 API URL을 JSP로 전달합니다.
            // **하지만 실제 서비스에서는 아래 getCaptchaImage 메서드와 같이 Spring Boot가 프록시 역할을 하는 것이 좋습니다.**
            captchaImageUrl = "https://openapi.naver.com/v1/captcha/ncaptcha.bin?code=1&key=" + key;


            // 대안: 백엔드에서 캡차 이미지를 가져와서 JSP에 전달 (더 안전한 방법)
            //String localCaptchaImageUrl = "/captcha/image.do?key=" + key;
            //model.addAttribute("captchaImageUrl", localCaptchaImageUrl);
            // 이 경우, 아래 getCaptchaImageByProxy() 메서드가 필요합니다.

        } catch (Exception e) {
            System.err.println("Error generating captcha: " + e.getMessage());
            model.addAttribute("captchaError", "캡차 로딩 중 오류가 발생했습니다.");
            // 오류 발생 시에도 캡차 키는 null이므로 JSP에서 이를 처리할 수 있습니다.
        }

        model.addAttribute("captchaKey", key); // JSP에서 캡차 키를 hidden 필드 등으로 저장
        model.addAttribute("captchaImageUrl", captchaImageUrl); // JSP에서 <img> src로 사용

        return "register/captchaPage"; // src/main/webapp/WEB-INF/views/.jsp 를 찾게 됩니다.
    }

    /**
     * 클라이언트(JSP)가 입력한 캡차 값을 검증하는 엔드포인트
     */
    @PostMapping("/captcha/verify.do")
    public String verifyCaptcha(@RequestParam("captchaKey") String captchaKey,
                                @RequestParam("captchaInput") String captchaInput,
                                Model model) {
        boolean isCaptchaCorrect = false;
        try {
            // 4. 네이버 캡차 검증 API 호출 (code=1)
            String apiURL = "https://openapi.naver.com/v1/captcha/nkeys?code=1&key=" + captchaKey + "&value=" + captchaInput;
            Map<String, String> requestHeaders = new HashMap<>();
            requestHeaders.put("X-Naver-Client-Id", clientId);
            requestHeaders.put("X-Naver-Client-Secret", clientSecret);
            String responseBody = get(apiURL, requestHeaders);

            // 5. JSON 응답 파싱하여 'result' 값 추출
            // {"result":true/false, "responseTime":123}
            Map<String, Object> responseMap = objectMapper.readValue(responseBody, Map.class);
            isCaptchaCorrect = (Boolean) responseMap.get("result");

        } catch (Exception e) {
            System.err.println("Error verifying captcha: " + e.getMessage());
            model.addAttribute("captchaError", "캡차 검증 중 오류가 발생했습니다.");
        }

        if (isCaptchaCorrect) {
            model.addAttribute("verificationResult", "success");
            model.addAttribute("message", "캡차가 성공적으로 확인되었습니다!");
            // 캡차 성공 시 다음 페이지로 리다이렉트하거나 다른 로직 수행
            return "redirect:/successPage.do"; // 예시: 성공 페이지로 리다이렉트
        } else {
            model.addAttribute("verificationResult", "fail");
            model.addAttribute("message", "캡차가 일치하지 않습니다. 다시 시도해 주세요.");
            // 실패 시 현재 캡차 페이지로 돌아가며 새로운 캡차를 로드하도록 처리
            return "forward:/captcha/page.do"; // 현재 메서드를 다시 호출하여 새로운 캡차를 보여줌
        }
    }

    // --- 유틸리티 메서드 (캡슐화를 위해 private으로 유지) ---

    // HTTP GET 요청을 보내고 응답 본문을 문자열로 반환
    private String get(String apiUrl, Map<String, String> requestHeaders) {
        HttpURLConnection con = connect(apiUrl);
        try {
            con.setRequestMethod("GET");
            for(Map.Entry<String, String> header :requestHeaders.entrySet()) {
                con.setRequestProperty(header.getKey(), header.getValue());
            }

            int responseCode = con.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) { // 정상 호출
                return readBody(con.getInputStream());
            } else { // 에러 발생
                String errorBody = readBody(con.getErrorStream());
                System.err.println("API Error: " + errorBody);
                throw new IOException("API call failed with response code " + responseCode + ": " + errorBody);
            }
        } catch (IOException e) {
            throw new RuntimeException("API 요청과 응답 실패", e);
        } finally {
            if (con != null) {
                con.disconnect();
            }
        }
    }

    // HTTP 연결 설정
    private HttpURLConnection connect(String apiUrl) {
        try {
            URL url = new URL(apiUrl);
            return (HttpURLConnection)url.openConnection();
        } catch (MalformedURLException e) {
            throw new RuntimeException("API URL이 잘못되었습니다. : " + apiUrl, e);
        } catch (IOException e) {
            throw new RuntimeException("연결이 실패했습니다. : " + apiUrl, e);
        }
    }

    // HTTP 응답 본문 읽기
    private String readBody(InputStream body) {
        InputStreamReader streamReader = new InputStreamReader(body);
        try (BufferedReader lineReader = new BufferedReader(streamReader)) {
            StringBuilder responseBody = new StringBuilder();
            String line;
            while ((line = lineReader.readLine()) != null) {
                responseBody.append(line);
            }
            return responseBody.toString();
        } catch (IOException e) {
            throw new RuntimeException("API 응답을 읽는데 실패했습니다.", e);
        }
    }

    /**
     * (선택 사항) 서버가 캡차 이미지를 직접 프록시하여 제공하는 엔드포인트
     * 이 방법을 사용하면 클라이언트에서 네이버 API 키가 노출되지 않아 더 안전합니다.
     * JSP의 <img> 태그 src에 이 URL을 사용하세요.
     */
    @GetMapping("/captcha/image.do")
    @ResponseBody // 이미지 바이너리 데이터를 직접 응답 본문에 담아 보냅니다.
    public byte[] getCaptchaImageByProxy(@RequestParam("key") String key) {
        String code = "1"; // 캡차 이미지 발급 시 1
        String apiURL = "https://openapi.naver.com/v1/captcha/ncaptcha.bin?code=" + code + "&key=" + key;

        Map<String, String> requestHeaders = new HashMap<>();
        requestHeaders.put("X-Naver-Client-Id", clientId);
        requestHeaders.put("X-Naver-Client-Secret", clientSecret);

        HttpURLConnection con = null;
        try {
            con = connect(apiURL);
            con.setRequestMethod("GET");
            for(Map.Entry<String, String> header : requestHeaders.entrySet()) {
                con.setRequestProperty(header.getKey(), header.getValue());
            }

            int responseCode = con.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) {
                // 이미지 데이터를 바이트 배열로 읽어와 반환
                return con.getInputStream().readAllBytes();
            } else {
                String errorBody = readBody(con.getErrorStream());
                System.err.println("Captcha Image Proxy Error: " + errorBody);
                throw new RuntimeException("Failed to proxy captcha image: " + errorBody);
            }
        } catch (IOException e) {
            throw new RuntimeException("API 요청과 응답 실패", e);
        } finally {
            if (con != null) {
                con.disconnect();
            }
        }
    }
}