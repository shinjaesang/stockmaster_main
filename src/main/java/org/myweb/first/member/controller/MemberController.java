package org.myweb.first.member.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.myweb.first.member.model.dto.Member;
import org.myweb.first.member.model.service.MemberService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping("/member")
public class MemberController {

    private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

    @Autowired
    private MemberService memberService;

    @Autowired
    private BCryptPasswordEncoder bcryptPasswordEncoder;

    // 로그인 페이지로 이동
    @RequestMapping(value = "/loginPage.do", method = RequestMethod.GET)
    public String moveLoginPage() {
        logger.info("moveLoginPage called");
        return "member/loginPage";
    }

    // 회원가입 페이지로 이동
    @RequestMapping(value = "/enrollPage.do", method = RequestMethod.GET)
    public String moveEnrollPage() {
        logger.info("moveEnrollPage called");
        return "member/enrollPage";
    }

    // 로그인 처리
    @RequestMapping(value = "/login.do", method = RequestMethod.POST)
    public String loginMethod(Member member, HttpSession session, SessionStatus status, Model model) {
        logger.info("login.do : userId={}", member.getUserId());
        Member loginUser = memberService.selectMember(member.getUserId());
        if (loginUser != null && bcryptPasswordEncoder.matches(member.getUserPwd(), loginUser.getUserPwd())) {
            session.setAttribute("loginUser", loginUser);
            status.setComplete();
            return "redirect:/";
        } else {
            model.addAttribute("message", "로그인 실패: 아이디 또는 비밀번호가 올바르지 않습니다.");
            return "common/error";
        }
    }

    // 로그아웃 처리
    @RequestMapping(value = "/logout.do", method = RequestMethod.GET)
    public String logoutMethod(HttpServletRequest request, Model model) {
        logger.info("logout.do called");
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("loginUser") != null) {
            session.invalidate();
            return "redirect:/";
        } else {
            model.addAttribute("message", "이미 로그아웃된 상태입니다.");
            return "common/error";
        }
    }

    // 아이디 중복 체크
    @RequestMapping(value = "/idchk.do", method = RequestMethod.POST)
    @ResponseBody
    public String dupCheckUserIdMethod(@RequestParam("userId") String userId) {
        logger.info("idchk.do : userId={}", userId);
        int result = memberService.selectCheckId(userId);
        return (result == 0) ? "ok" : "dup";
    }

    // 비밀번호 초기화 페이지로 이동
    @RequestMapping(value = "/pwdreset.do", method = RequestMethod.GET)
    public String movePasswordResetPage() {
        logger.info("pwdreset.do called");
        return "member/pwdResetPage";
    }

    // 회원 정보 수정 (infoPage.jsp)
    @RequestMapping(value = "/mupdate.do", method = RequestMethod.POST)
    public String updateMember(Member member, @RequestParam("photofile") MultipartFile photofile, Model model) {
        logger.info("mupdate.do : userId={}", member.getUserId());
        // 사진 파일 처리 및 회원 정보 업데이트 로직 (MemberService 호출)
        // 예: memberService.updateMember(member, photofile);
        model.addAttribute("message", "회원 정보가 성공적으로 수정되었습니다.");
        return "redirect:/";
    }

//    // 회원 탈퇴 (infoPage.jsp)
//    @RequestMapping(value = "/mdelete.do", method = RequestMethod.GET)
//    public String deleteMember(@RequestParam("userId") String userId, HttpSession session, Model model) {
//        logger.info("mdelete.do : userId={}", userId);
//        // 회원 탈퇴 로직 (MemberService 호출)
//        // 예: memberService.deleteMember(userId);
//        session.invalidate    invalidate();
//        model.addAttribute("message", "회원 탈퇴가 완료되었습니다.");
//        return "redirect:/";
//    }

    // 회원 가입 처리 (enrollPage.jsp)
    @RequestMapping(value = "/enroll.do", method = RequestMethod.POST)
    public String enrollMember(Member member, @RequestParam("photofile") MultipartFile photofile, Model model) {
        logger.info("enroll.do : userId={}", member.getUserId());
        // 비밀번호 암호화 및 회원 가입 로직 (MemberService 호출)
        member.setUserPwd(bcryptPasswordEncoder.encode(member.getUserPwd()));
        // 예: memberService.enrollMember(member, photofile);
        model.addAttribute("message", "회원 가입이 완료되었습니다.");
        return "redirect:/";
    }

    // 회원 목록 조회 (memberListView.jsp)
    @RequestMapping(value = "/mlist.do", method = RequestMethod.GET)
    public String listMembers(@RequestParam(value = "page", defaultValue = "1") int page, Model model) {
        logger.info("mlist.do : page={}", page);
        // 회원 목록 조회 및 페이징 처리 (MemberService 호출)
        // 예: Paging paging = memberService.getMemberList(page);
        // model.addAttribute("list", paging.getList());
        // model.addAttribute("paging", paging);
        return "memberListView";
    }

    // 회원 검색 (memberListView.jsp)
    @RequestMapping(value = "/msearch.do", method = RequestMethod.GET)
    public String searchMembers(@RequestParam("action") String action, @RequestParam(value = "keyword", required = false) String keyword,
                               @RequestParam(value = "begin", required = false) String begin, @RequestParam(value = "end", required = false) String end,
                               Model model) {
        logger.info("msearch.do : action={}, keyword={}", action, keyword);
        // 검색 로직 (MemberService 호출)
        // 예: List<Member> list = memberService.searchMembers(action, keyword, begin, end);
        // model.addAttribute("list", list);
        return "memberListView";
    }

    // 로그인 제한/허용 (memberListView.jsp)
    @RequestMapping(value = "/loginok.do", method = RequestMethod.GET)
    @ResponseBody
    public String updateLoginOk(@RequestParam("userId") String userId, @RequestParam("loginOk") String loginOk) {
        logger.info("loginok.do : userId={}, loginOk={}", userId, loginOk);
        // 로그인 상태 업데이트 로직 (MemberService 호출)
        // 예: memberService.updateLoginOk(userId, loginOk);
        return "success";
    }
}