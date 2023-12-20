package com.tenco.toyproject.controller.mng;

import com.sun.tools.jconsole.JConsoleContext;
import com.tenco.toyproject._core.handler.exception.CustomRestfulException;
import com.tenco.toyproject.dto.MngIndexDTO;
import com.tenco.toyproject.dto.MngSignInFormDto;
import com.tenco.toyproject.dto.MngUserDTO;
import com.tenco.toyproject.repository.entity.User;
import com.tenco.toyproject.service.mng.MngIndexService;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/mng")
@Slf4j
public class MngIndexController {

    @Autowired
    private HttpSession session;

    @Autowired
    private MngIndexService mngIndexService;

    @GetMapping("/login")
    public String goLoginPage() {
        return "mng/login";
    }

    @PostMapping("/sign-in")
    public String signInProc(MngSignInFormDto dto) throws CustomRestfulException {

        // 1. 유효성 검사
        if(dto.getUsername() == null || dto.getUsername().isEmpty()) {
            throw new CustomRestfulException("username을 입력하세요", HttpStatus.BAD_REQUEST);
        }

        if(dto.getPassword() == null || dto.getPassword().isEmpty()) {
            throw new CustomRestfulException("password를 입력하세요", HttpStatus.BAD_REQUEST);
        }

        // 2. 서비스 호출
        User mngPrincipal = mngIndexService.signIn(dto);

        // 3. 세션 처리
        session.setAttribute("mngPrincipal", mngPrincipal);

        System.out.println("mngPrincipal" + mngPrincipal);

        return "redirect:/mng/index";
    }

    @GetMapping("/logout")
    public String logout() {
        session.invalidate();
        return "redirect:/mng/login";
    }

    @GetMapping({"/","/index"})
    public String manager(Model model) {

        System.out.println("매니저 페이지로 들어갑니다.");
        List<MngIndexDTO> dtos =mngIndexService.findByCreatedAt();
        System.out.println(dtos.toString());
        model.addAttribute("dtos",dtos);
        return "/mng/index";
    }
}

