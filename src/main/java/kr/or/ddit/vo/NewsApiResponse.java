package kr.or.ddit.vo;

import lombok.Data;
import kr.or.ddit.vo.NewsVO;

import java.util.List;

@Data
public class  NewsApiResponse{
    private Response response;

    @Data
    public static class Response {
        private Header header;
        private Body body;
    }

    @Data
    public static class Header {
        private String resultCode;
        private String resultMsg;
    }

    @Data
    public static class Body {
        private String totalCnt;
        private String pageNo;
        private ItemList itemList;
        private String numOfRows;
    }

    @Data
    public static class ItemList {
        private List<NewsVO> item;
    }
}