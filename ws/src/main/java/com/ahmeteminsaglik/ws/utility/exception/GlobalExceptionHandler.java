package com.ahmeteminsaglik.ws.utility.exception;

import com.ahmeteminsaglik.ws.utility.result.ErrorDataResult;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.cache.support.NullValue;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class GlobalExceptionHandler {

    private static final Logger log = LoggerFactory.getLogger(GlobalExceptionHandler.class);

    @ExceptionHandler(ApiRequestException.class)
    public ResponseEntity<ErrorDataResult<NullValue>> handleCustomException(ApiRequestException ex) {
        log.error("ApiRequestException is handled: "+ex.getMessage());
        return ResponseEntity.status(ex.getHttpStatus())
                .body(new ErrorDataResult<>(ex.getMessage()));
    }
    @ExceptionHandler(Exception.class)
    public ResponseEntity<ErrorDataResult<NullValue>> handleException(Exception ex) {
        log.error("Exception is handled: "+ex.getMessage());
        return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                .body(new ErrorDataResult<>("Exception Handler :"+ex.getMessage()));
    }

}
