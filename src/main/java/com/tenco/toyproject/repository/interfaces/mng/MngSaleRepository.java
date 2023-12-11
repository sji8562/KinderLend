package com.tenco.toyproject.repository.interfaces.mng;

import com.tenco.toyproject.dto.MngApplyDTO;
import com.tenco.toyproject.vo.PageVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface MngSaleRepository {

    public List<MngApplyDTO.SaleListDTO> findSaleWithUserAll(PageVO pageVO);

    public int findSaleAllCount();

    public int updateBySaleStatus (Integer id);

    public int deleteBySaleStatus(Integer id);
}
