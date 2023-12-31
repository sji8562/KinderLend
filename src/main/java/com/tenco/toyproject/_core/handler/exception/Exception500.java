package com.tenco.toyproject._core.handler.exception;

import org.springframework.http.HttpStatus;

import com.tenco.toyproject._core.utils.ApiUtils;

import lombok.Getter;

// 서버 에러
@Getter
public class Exception500 extends RuntimeException {
    public Exception500(String message) {
        super(message);
    }

    public ApiUtils.ApiResult<?> body() {
        return ApiUtils.error(getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
    }

    public HttpStatus status() {
        return HttpStatus.INTERNAL_SERVER_ERROR;
    }
}