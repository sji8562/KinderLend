package com.tenco.toyproject.repository.interfaces;


import java.util.List;
import java.util.Map;

import com.tenco.toyproject.repository.entity.*;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface ProductRepository {
	public Product findById(Integer id); 
	public List<Product> showCartById(Integer userId);
	public void addToCartById(@Param("userId") int userId, @Param("productId") int productId);
	public int countProductCustomer(int productId);
	public int deleteCartItem(@Param("userId") int userId, @Param("productId") int productId);
	public int isItemInCart(@Param("userId") int userId, @Param("productId") int productId);
	public int countItemInCart(@Param("userId") int userId);
//	public void payForCart(@Param("userId") int userId, Cart cart);
	public void payForProduct(@Param("userId") int userId, @Param("productId") int productId, @Param("postNumber") String postNumber,
			@Param("address") String address, @Param("addressDetail") String addressDetail);
	public List<Map> showCustomerOrderList(int userId);

	public void applyForRefund(PayBack payBack);
	public Sale findTid(int id);
	public int deleteRefundFromSale(int id);
	public List<Map> showCancelList(int userId);
	public void addToBookmark(@Param("userId") int userId, @Param("productId") int productId);
	public int checkWishList(@Param("userId") int userId, @Param("productId") int productId);
	public List<Map> showWishList(int id);
	public int deleteWishList(@Param("userId") int userId, @Param("productId") int productId);
	public void updateTid(@Param("tid") String tid, @Param("userId") int userId, @Param("productId") int productId);
	public int deleteFromSale(@Param("userId") int userId, @Param("productId") int productId);
	public int countReview(int productId);
	public List<Map> showReview(int productId);
	public List<Map> showRentList(int userId);
	public Rent findRentList(int id);
	public String findFirstCategoryName(int id);
	public String findSecondCategoryName(int id);
	


	
	//무한스크롤 관련
	public List<Map> searchProduct(String keyword);
	public List<Map> searchProductHighPrice(String keyword, String sortBy);
	public List<Map> searchProductLowPrice(String keyword, String sortBy);

	public List<Map> searchProductCreatedAt(String keyword, String sortBy);
	public List<Map> searchProductInfinite(@Param("keyword") String keyword, @Param("offset") int offset,@Param("limit") int limit);
	public int searchMaxPrice();


	public List<Product> findByCategoryId(Integer id);
	public List<Product> findByfsCategoryId(Integer id,Integer sId);
	public List<SecondCategory> findBysCategoryId(Integer id);

    List<Product> findProductForMain();
}
