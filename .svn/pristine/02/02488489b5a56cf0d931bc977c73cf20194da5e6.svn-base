// kr.or.ddit.util.QRCodeImage.java (신규 생성)
package kr.or.ddit.util;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.nio.file.Paths;
import java.util.Hashtable;
import javax.imageio.ImageIO;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.WriterException;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;
import lombok.extern.slf4j.Slf4j;

/**
 * 
 */
@Slf4j
public class QRCodeImage {

    private static final int QR_CODE_WIDTH = 300;
    private static final int QR_CODE_HEIGHT = 300;
    private static final String QR_CODE_IMAGE_FORMAT = "png";
    // QR코드를 저장할 서버 경로
    private static final String UPLOAD_PATH = "C:/upload/qrcode"; 

    /**
     * QR 코드 이미지 생성 및 파일 저장을 위한 클래스
     * @param dataToEncode QR 코드로 만들 데이터 (JSON )
     * @param fileName 이미지 파일 이름 (ex : HC-2025-00001.png)
     * @return 저장 성공 여부
     */
    public static boolean generateQRImage(String dataToEncode, String fileName) {
        // C:/upload/qrcode 폴더가 없으면 생성
        File uploadDir = new File(UPLOAD_PATH);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        // 최종 저장될 파일 경로 객체 생성
        File outputFile = Paths.get(UPLOAD_PATH, fileName).toFile();

        try {
            // QR 코드 생성 옵션 설정
            Hashtable<EncodeHintType, Object> hintMap = new Hashtable<>();
            // 오류 복원 수준
            hintMap.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.L); 
            hintMap.put(EncodeHintType.CHARACTER_SET, "UTF-8"); 
            hintMap.put(EncodeHintType.MARGIN, 1); // 여백

            QRCodeWriter qrCodeWriter = new QRCodeWriter();
            // 데이터로 QR 코드 비트 매트릭스 생성
            BitMatrix bitMatrix = qrCodeWriter.encode(dataToEncode, BarcodeFormat.QR_CODE, QR_CODE_WIDTH, QR_CODE_HEIGHT, hintMap);

            // 비트 매트릭스를 이미지로 변환
            BufferedImage qrImage = new BufferedImage(QR_CODE_WIDTH, QR_CODE_HEIGHT, BufferedImage.TYPE_INT_RGB);
            Graphics2D graphics = (Graphics2D) qrImage.getGraphics();
            graphics.setColor(Color.WHITE);
            graphics.fillRect(0, 0, QR_CODE_WIDTH, QR_CODE_HEIGHT);
            graphics.setColor(Color.BLACK);

            for (int i = 0; i < QR_CODE_WIDTH; i++) {
                for (int j = 0; j < QR_CODE_HEIGHT; j++) {
                    if (bitMatrix.get(i, j)) {
                        graphics.fillRect(i, j, 1, 1);
                    }
                }
            }
            // 최종 이미지를 파일로 저장
            return ImageIO.write(qrImage, QR_CODE_IMAGE_FORMAT, outputFile);

        } catch (Exception e) {
            log.error("QR 코드 이미지 생성 및 저장 중 오류 발생", e);
            return false;
        }
    }
}