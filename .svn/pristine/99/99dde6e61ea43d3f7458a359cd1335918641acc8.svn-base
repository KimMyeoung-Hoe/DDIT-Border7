package kr.or.ddit.vo;

import java.math.BigDecimal;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PeriodStat {
	
	private int count; // 의뢰건수
	private BigDecimal amount; // 물품판매가격의 합
	
	public void add(HsStatResult result) {
		this.count += result.getCount();
		if (this.amount == null) this.amount = BigDecimal.ZERO;
        this.amount = this.amount.add(result.getAmount());

	}
}
