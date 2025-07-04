package kr.or.ddit.config;

import jakarta.persistence.AttributeConverter;

public class BooleanToIntConverter implements AttributeConverter<Boolean, Integer>{
	
    @Override
    public Integer convertToDatabaseColumn(Boolean attribute) {
        if (attribute == null) {
            return 0; // boolean이 null일 경우 DB에 0으로 저장 (false 의미)
        }
        return attribute ? 1 : 0; // true면 1, false면 0으로 저장
    }

    @Override
    public Boolean convertToEntityAttribute(Integer dbData) {
        if (dbData == null) {
            return false; // DB 데이터가 null일 경우 자바에서 false로 처리
        }
        return dbData == 1; // 1이면 true, 아니면 false
    }

}
