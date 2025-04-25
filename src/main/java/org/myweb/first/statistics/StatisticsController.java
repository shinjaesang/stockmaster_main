package org.myweb.first.statistics;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 통계분석 컨트롤러
 */
@Controller
@RequestMapping("/statistics")
public class StatisticsController {
    
    /**
     * 판매베스트 페이지
     * @return 판매베스트 뷰
     */
    @GetMapping("/top-sales.do")
    public String topSales() {
        // TODO: 판매베스트 데이터 조회 로직
        return "report/top-sales";
    }
    
    /**
     * 상품매출통계 페이지
     * @return 상품매출통계 뷰
     */
    @GetMapping("/product-sales.do")
    public String productSales() {
        // TODO: 상품 매출 통계 데이터 조회 로직
        return "report/product-sales";
    }
    
    // TODO: 일별매출차트, 입출고 통계 관련 메서드 추가
} 