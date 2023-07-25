package com.harpia.HarpiaHealthAnalysisWS.utility.validator;

import com.harpia.HarpiaHealthAnalysisWS.business.concretes.login.LoginCredentialsValidation;
import com.harpia.HarpiaHealthAnalysisWS.model.enums.EnumInputName;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.ErrorResult;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.Result;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.SuccessResult;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class LengthValidator {
    private static final Logger log = LoggerFactory.getLogger(LoginCredentialsValidation.class);

    public static Result isLengthValid(EnumInputName enumInputName, String input, int minLength, int maxLength) {
        final String inputName = enumInputName.getName();
        String errMsg;
        if (input == null) {
            errMsg = "Data is null";
            log.info(errMsg);
            return new ErrorResult(errMsg);
        }

        if (input.length() < minLength) {
            errMsg = inputName + " length must be min " + minLength;
            log.info(errMsg);
            return new ErrorResult(errMsg);
        }
        if (input.length() > maxLength) {
            errMsg = inputName + " length must be max " + maxLength;
            log.info(errMsg);
            return new ErrorResult(errMsg);
        }
        return new SuccessResult(inputName + " length is valid");
    }
}
