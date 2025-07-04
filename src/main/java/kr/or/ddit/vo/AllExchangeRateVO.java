package kr.or.ddit.vo;

import lombok.Data;

@Data
public class AllExchangeRateVO {
	private int result;
    private String cur_unit; // 통화 코드
    private String ttb; // 전신환(송금) 받으실 때
    private String tts; // 전신환(송금) 보내실 때
    private String deal_bas_r; // 매매 기준율
    private String bkpr; // 장부가격
    private String yy_efee_r; // 년 환가료율
    private String ten_dd_efee_r; // 10일 환가료율
    private String kftc_bkpr; // 서울외국환중개 장부가격
    private String kftc_deal_bas_r; // 서울외국환중개 매매기준율
    private String cur_nm; // 국가/통화명
}
