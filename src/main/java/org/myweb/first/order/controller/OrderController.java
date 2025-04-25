package org.myweb.first.order.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/order")
public class OrderController {
	private static final Logger logger = LoggerFactory.getLogger(OrderController.class);
    
    // 주문 목록 페이지
    @GetMapping("/list.do")
    public String orderList(Model model) {
        // TODO: 주문 목록 조회 로직
        return "order/orders";
    }
    
    // 주문 등록 페이지
    @GetMapping("/register.do")
    public String orderRegisterForm(Model model) {
        // TODO: 주문 등록에 필요한 데이터 설정
        return "order/orderregister";
    }
    
	/*
	 * // 주문 등록 처리
	 * 
	 * @PostMapping("/orderregister.do") public String orderRegister(@ModelAttribute
	 * OrderDTO order) { // TODO: 주문 등록 처리 로직 return "redirect:/orderlist.do"; }
	 */
    
    // 주문 상태 변경
    @RequestMapping("update.do")
    public String orderUpdate(@RequestParam("orderNo") String orderNo, Model model) {
        // TODO: 주문 상태 변경 로직 구현
        return "order/orderupdate";
    }
} 