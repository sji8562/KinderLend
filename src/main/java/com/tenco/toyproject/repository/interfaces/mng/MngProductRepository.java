package com.tenco.toyproject.repository.interfaces.mng;

import com.tenco.toyproject.repository.entity.FirstCategory;
import com.tenco.toyproject.repository.entity.Product;
import com.tenco.toyproject.repository.entity.Review;
import com.tenco.toyproject.repository.entity.SecondCategory;
import com.tenco.toyproject.vo.PageVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface MngProductRepository {
    // KWON
    // 물품 전체 조회
    List<Product> findAllProductWithPagination(PageVO pageVO, Integer code);

    // 아이디로 물품 조회
    Product findProductById(Integer pId);

    // product 총 개수
    public int findProductCount(Integer code, String keyword);

    // 특정 물품 삭제
    public int deleteByProductId(Integer id);

    // 물품 등록
    public int createProduct(Product product);

    // 1차 카테고리 조회
    public List<FirstCategory> findFirstCategoryAll(Integer code);

    // 2차 카테고리 조회
    public List<SecondCategory> findSecondCategoryForRent();

    // 2차 카테고리 id로 1차 카테고리 조회
    public Integer findFirstCategoryByfId(Integer sId);

    // 물품 정보 수정
    public Integer updateProduct(Product dto);
    int findRentAllCount();


    List<SecondCategory> findSecondCategoryForFirstCategory(String fId);


    int findFirstCategoryByName(Integer code, String fCategoryName);

    void createFirstCategory(int code, String fCategoryName);

    int deleteFirstCategoryById(int fId);


    int findSecondCategoryByName(String fCategory, String sCategoryName);

    int addSecondCategory(String fCategory, String sCategoryName);

    SecondCategory findFirstCategoryIdBySecondCategoryId(int sId);

    int deleteSecondCategoryById(int sId);

    int findProductBySecondCategoryId(int sId);

    int findProductCountByFirstCategoryId(int fId);

    List<Product> findProductByKeyword(PageVO pageVO, String keyword, Integer code);

    List<Review> findAllReviewWithPaginationAndKeyword(PageVO pageVO, String keyword);

    List<Review> findAllReviewWithPagination(PageVO pageVO);

    int countReviewList(String keyword);

    Review findProductReviewById(Integer pId);

    int deleteProductReview(Integer id);

}
