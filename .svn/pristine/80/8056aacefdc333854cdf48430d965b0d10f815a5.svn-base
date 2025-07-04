package kr.or.ddit.etc;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.http.HttpEntity;
import org.springframework.core.io.ByteArrayResource; // 이 부분을 꼭 추가하세요!

import java.io.IOException;

@Controller
public class ThreeDController {

    private final String STABILITY_AI_API_URL = "https://api.stability.ai/v2beta/3d/stable-point-aware-3d";
    private final String STABILITY_API_KEY = "sk-lmm5cVXsAQcZRKfWfu3fv3MMbSWRAvNWGcumfwBbfDGpcjxp"; // 여기에 실제 API 키를 넣으세요!

    @GetMapping("/3d-converter")
    public String showConverterForm() {
        return "3d-converter";
    }

    /**
     * 이미지 파일을 받아 Stability AI API를 호출하고 GLB 파일을 반환합니다.
     */
    @PostMapping("/convert-to-3d.do")
    // 반환 타입을 ResponseEntity<byte[]>로 유지하고, 에러 메시지 바디를 byte[]로 변환하여 보냅니다.
    // 또는 ResponseEntity<String>으로 변경하고 에러 메시지를 String으로 직접 보내는 것도 가능합니다.
    public ResponseEntity<byte[]> convertImageTo3D(
    		@RequestParam("imageFile") MultipartFile imageFile,
//    		@RequestParam(value = "foregroundRatio", defaultValue = "0.6") float foregroundRatio, // 추가할 파라미터 1
            @RequestParam(value = "textureResolution", defaultValue = "2048") int textureResolution) { // 추가할 파라미터 2) {

    	if (imageFile.isEmpty()) {
            // 에러 메시지를 byte[]로 변환하여 보냅니다.
            return new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
        }

        RestTemplate restTemplate = new RestTemplate();

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.MULTIPART_FORM_DATA);
        headers.setBearerAuth(STABILITY_API_KEY);

        MultiValueMap<String, Object> body = new LinkedMultiValueMap<String, Object>();
        try {
            body.add("image", new ByteArrayResource(imageFile.getBytes()) {
                @Override
                public String getFilename() {
                    return imageFile.getOriginalFilename();
                }
            });
            // 여기에 추가 설정파라미터 
//          body.add("foreground_ratio", String.valueOf(foregroundRatio)); // float 값은 String으로 변환하여 추가
            body.add("texture_resolution", String.valueOf(textureResolution)); // int 값은 String으로 변환하여 추가
      
        } catch (IOException e) {
            return new ResponseEntity<byte[]>(HttpStatus.INTERNAL_SERVER_ERROR);
        }

        HttpEntity<MultiValueMap<String, Object>> requestEntity = new HttpEntity<>(body, headers);

        try {
            ResponseEntity<byte[]> response = restTemplate.postForEntity(STABILITY_AI_API_URL, requestEntity, byte[].class);

            if (response.getStatusCode() == HttpStatus.OK) {
                HttpHeaders responseHeaders = new HttpHeaders();
                responseHeaders.setContentType(MediaType.parseMediaType("model/gltf-binary"));
                responseHeaders.setContentDispositionFormData("attachment", "converted_3d_model.glb");
                return new ResponseEntity<>(response.getBody(), responseHeaders, HttpStatus.OK);
            } else {
                // 외부 API에서 받은 에러 바디를 그대로 byte[]로 전달
                return new ResponseEntity<>(response.getBody(), response.getStatusCode());
            }
        } catch (HttpClientErrorException e) {
            // HttpClientErrorException의 응답 바디는 이미 byte[]입니다.
            return new ResponseEntity<>(e.getResponseBodyAsByteArray(), e.getStatusCode());
        } catch (Exception e) {
            return new ResponseEntity<>(("Server error during 3D conversion: " + e.getMessage()).getBytes(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}