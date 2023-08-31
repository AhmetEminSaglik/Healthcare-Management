package com.harpia.HarpiaHealthAnalysisWS.business.concretes.firebase.notification;

import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.firebase.notification.FcmMsgService;
import com.harpia.HarpiaHealthAnalysisWS.model.firebase.FcmData;
import com.harpia.HarpiaHealthAnalysisWS.model.firebase.FcmMessage;
import com.harpia.HarpiaHealthAnalysisWS.model.firebase.FcmNotification;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RestController;

import java.awt.*;

@Service
@RestController
public class FcmMsgManager implements FcmMsgService {

    @Override
    public String generateTextWithHtmlColor(String notificationTitle, Color color) {
        String cssColor = rgbToCssColor(color.getRed(), color.getGreen(), color.getBlue());
        String generatedText = "<p style='color:" + cssColor + "'>" + notificationTitle + "<p/>";
        return generatedText;
    }

    @Override
    public FcmMessage generateFcmMsg(String token, FcmNotification notification, FcmData data) {
        FcmMessage fcmMessage = new FcmMessage();
        fcmMessage.setTo(token);
        fcmMessage.setNotification(notification);
        fcmMessage.setData(data);
        return fcmMessage;
    }


    public String rgbToCssColor(int red, int green, int blue) {
        return String.format("#%02X%02X%02X", red, green, blue);
    }
}
