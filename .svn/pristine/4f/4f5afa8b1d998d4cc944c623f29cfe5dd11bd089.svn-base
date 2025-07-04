<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이미지 3D 모델 변환</title>
<style>
    body { font-family: Arial, sans-serif; margin: 20px; background-color: #f4f4f4; }
    .container {
        background-color: #fff;
        padding: 30px;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        max-width: 600px;
        margin: 50px auto;
        text-align: center;
    }
    h1 { color: #333; margin-bottom: 20px; }
    .form-group { margin-bottom: 20px; }
    input[type="file"] {
        border: 1px solid #ddd;
        padding: 10px;
        border-radius: 5px;
        width: calc(100% - 22px);
    }
    button {
        background-color: #007bff;
        color: white;
        padding: 12px 25px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-size: 16px;
        transition: background-color 0.3s ease;
    }
    button:hover { background-color: #0056b3; }
    .message {
        margin-top: 20px;
        padding: 10px;
        border-radius: 5px;
    }
    .message.error { background-color: #ffe0e0; color: #cc0000; border: 1px solid #cc0000; }
    .message.success { background-color: #e0ffe0; color: #008000; border: 1px solid #008000; }
</style>
</head>
<body>
    <div class="container">
        <h1>이미지를 3D 모델로 변환</h1>
        <p>변환할 이미지 파일을 선택하고 변환 버튼을 누르세요. (PNG 또는 JPG)</p>

        <%-- 파일 업로드 폼 --%>
        <form id="uploadForm" action="/convert-to-3d.do" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <input type="file" name="imageFile" id="imageFile" accept="image/png, image/jpeg" required>
            </div>
            <button type="submit" id="submitBtn">3D 모델 변환 시작</button>
        </form>

        <div id="message" class="message" style="display: none;"></div>

        <script>
            document.getElementById('uploadForm').addEventListener('submit', async function(event) {
                event.preventDefault(); // 기본 폼 제출 방지

                const form = event.target;
                const formData = new FormData(form);
                const messageDiv = document.getElementById('message');
                const submitBtn = document.getElementById('submitBtn');

                messageDiv.style.display = 'none';
                messageDiv.className = 'message';
                submitBtn.disabled = true; // 버튼 비활성화
                submitBtn.textContent = '변환 중...';

                try {
                    // Axios 대신 fetch API를 사용하여 파일 업로드 및 바이너리 응답 처리
                    const response = await fetch(form.action, {
                        method: 'POST',
                        body: formData, // FormData 객체를 직접 body에 할당
                        // fetch API는 Content-Type 헤더를 FormData를 사용할 때 자동으로 설정합니다.
                    });

                    if (response.ok) { // HTTP 상태 코드가 2xx (성공)인 경우
                        const blob = await response.blob(); // 응답을 Blob으로 받음
                        const fileName = response.headers.get('Content-Disposition')
                                        ? response.headers.get('Content-Disposition').split('filename=')[1].replace(/"/g, '')
                                        : 'converted_3d_model.glb'; // 파일명 추출

                        // 다운로드 링크 생성
                        const url = URL.createObjectURL(blob);
                        const a = document.createElement('a');
                        a.href = url;
                        a.download = fileName;
                        document.body.appendChild(a);
                        a.click();
                        document.body.removeChild(a);
                        URL.revokeObjectURL(url); // URL 해제

                        messageDiv.textContent = '3D 모델이 성공적으로 생성되었습니다. 다운로드를 확인하세요!';
                        messageDiv.classList.add('success');
                        messageDiv.style.display = 'block';

                    } else { // HTTP 상태 코드가 4xx 또는 5xx인 경우
                        const errorText = await response.text(); // 오류 메시지를 텍스트로 받음
                        throw new Error(`변환 실패 (${response.status}): ${errorText}`);
                    }
                } catch (error) {
                    messageDiv.textContent = error.message || '알 수 없는 오류가 발생했습니다.';
                    messageDiv.classList.add('error');
                    messageDiv.style.display = 'block';
                } finally {
                    submitBtn.disabled = false; // 버튼 활성화
                    submitBtn.textContent = '3D 모델 변환 시작';
                }
            });
        </script>
    </div>
</body>
</html>