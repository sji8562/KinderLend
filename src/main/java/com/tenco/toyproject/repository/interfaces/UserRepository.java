package com.tenco.toyproject.repository.interfaces;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.tenco.toyproject.dto.UserSignInFormDto;
import com.tenco.toyproject.repository.entity.User;

@Mapper
public interface UserRepository {
	// 사용자 단일 조회
	public User findById(Integer id);
//	수정
	public String selectPassword(String email);
	public User selectUser(String email);
	public int insertUser(User user);
	public User selectUserEmail(String email);
	public User selectUserSns(String sns);
	
	public Map findByNameAndPhone(@Param("userName") String userName,@Param("phoneNumber") String phoneNumber);
	public int updatePassword(@Param("password") String passowrd, @Param("email") String email);
}

