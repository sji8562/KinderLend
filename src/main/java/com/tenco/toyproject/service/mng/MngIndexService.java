package com.tenco.toyproject.service.mng;

import com.tenco.toyproject._core.handler.exception.CustomRestfulException;
import com.tenco.toyproject._core.handler.exception.CustomRestfullException;
import com.tenco.toyproject.dto.MngIndexDTO;
import com.tenco.toyproject.dto.MngSignInFormDto;
import com.tenco.toyproject.repository.entity.Review;
import com.tenco.toyproject.repository.entity.User;
import com.tenco.toyproject.repository.interfaces.mng.MngIndexRepository;
import com.tenco.toyproject.vo.PageVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MngIndexService {


    @Autowired
    MngIndexRepository mngIndexRepository;
    @Autowired
    private PasswordEncoder passwordEncoder;


    public MngIndexDTO.MngTotalDTO findByCreatedAt(){
        List<MngIndexDTO.MngMonthDTO> monthDTOS = mngIndexRepository.findByCreatedAt();
        int payoff = monthDTOS.stream()
                .mapToInt(MngIndexDTO.MngMonthDTO::getPrice)
                .sum();
        System.out.println(payoff);
        MngIndexDTO.MngTotalDTO mngTotalDTO = new MngIndexDTO.MngTotalDTO();;
        mngTotalDTO.setMngMonthDTO(monthDTOS);
        mngTotalDTO.setPayOff(payoff);

        return mngTotalDTO;
    }

    public MngIndexDTO.MngCountDTO findByAllCount(){
        MngIndexDTO.MngCountDTO countDTO = mngIndexRepository.countByAll();
        return countDTO;
    }
    public List<MngIndexDTO.MngStatusDTO> findByStatus(PageVO pageVO){
        List<MngIndexDTO.MngStatusDTO> mngStatusDTOS = mngIndexRepository.findByStatus(pageVO);
        return mngStatusDTOS;
    }

    public User signIn(MngSignInFormDto dto) {
        // 1. username으로 admin id 존재 여부 확인
        User mngUserEntity = mngIndexRepository.findByUsernameAndLevel(dto.getUsername());
        if(mngUserEntity == null) {
            throw new CustomRestfullException("존재하지 않는 계정입니다", HttpStatus.BAD_REQUEST);
        }

        // 2. 객체 상태값의 비번과 암호화 된 비번 일치 여부 확인
        boolean isPwdMatched = passwordEncoder.matches(dto.getPassword(), mngUserEntity.getPassword());

        if(isPwdMatched == false) {
            throw new CustomRestfullException("비밀번호를 다시 확인해주세요", HttpStatus.BAD_REQUEST);
        }

//        if(dto.getPassword().equals(mngUserEntity.getPassword()) == false) {
//            throw new CustomRestfulException("비밀번호를 다시 확인해주세요", HttpStatus.BAD_REQUEST);
//        }

        return mngUserEntity;
    }
    public int findByStatusAllCount(){
        return mngIndexRepository.findByStatusAllCount();
    };
    public List<MngIndexDTO.MngReviewDTO> findByReview(){
        return mngIndexRepository.findByReview();
    }


}
