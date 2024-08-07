package com.harpia.HarpiaHealthAnalysisWS.controller.timer;

import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.firebase.notification.FcmService;
import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.firebase.token.FcmTokenService;
import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.timer.PatientTimerService;
import com.harpia.HarpiaHealthAnalysisWS.controller.firebase.FcmTokenController;
import com.harpia.HarpiaHealthAnalysisWS.model.enums.EnumFcmMessageReason;
import com.harpia.HarpiaHealthAnalysisWS.model.firebase.FcmData;
import com.harpia.HarpiaHealthAnalysisWS.model.firebase.FcmMessage;
import com.harpia.HarpiaHealthAnalysisWS.model.firebase.FcmNotification;
import com.harpia.HarpiaHealthAnalysisWS.model.timer.PatientTimer;
import com.harpia.HarpiaHealthAnalysisWS.utility.CustomLog;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.DataResult;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.SuccessDataResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Objects;

@RestController
@RequestMapping("/timers")
public class PatientTimerController {
    private static CustomLog log = new CustomLog(PatientTimerController.class);

    @Autowired
    PatientTimerService service;
    //    @Autowired
//    FcmTokenService fcmTokenService;
    @Autowired
    FcmTokenController fcmTokenController;
    @Autowired
    FcmService fcmService;

    @PostMapping()
    public ResponseEntity<DataResult<PatientTimer>> savePatientTimer(@RequestBody PatientTimer patientTimer) {
        PatientTimer newPatientTimer = service.findByPatientId(patientTimer.getPatientId());
        String msg;
        if (newPatientTimer == null) {
            newPatientTimer = service.save(patientTimer);
            msg = "Patient Timer is created";
        } else {
            newPatientTimer.setHours(patientTimer.getHours());
            newPatientTimer.setMinutes(patientTimer.getMinutes());
            newPatientTimer = service.save(newPatientTimer);
            msg = "Patient Timer is updated";
//            log.info("PATIENT TIMER UPDATE FCMMSG GONDERILECEK");
//            log.info("FcmTokenController :"+fcmTokenController);
            sendFcmMessage(patientTimer.getPatientId());
        }
        DataResult result = new SuccessDataResult(newPatientTimer, msg);
        return ResponseEntity.status(HttpStatus.CREATED).body(result);
    }

    @GetMapping("/patients/{id}")
    public ResponseEntity<DataResult<PatientTimer>> findPatientTimerByPatientId(@PathVariable long id) {
        PatientTimer timer = service.findByPatientId(id);
        String msg = "PatientTimer belongs to Patient ID " + id + " is retrived";
        DataResult result = new SuccessDataResult(timer, msg);
        return ResponseEntity.status(HttpStatus.CREATED).body(result);
    }

    @GetMapping
    public ResponseEntity<DataResult<List<PatientTimer>>> findAllPatientTimers() {
        List<PatientTimer> list = service.findAll();
        String msg = "All patientTimers are retrived";
        DataResult result = new SuccessDataResult(list, msg);
        return ResponseEntity.status(HttpStatus.OK).body(result);
    }

    private void sendFcmMessage(long patientId) {
        String msgTitle = "Updated Notification";
        String msgBody = "Patient Timer is Updated";
        log.info("patient Timer > sendFcmMessage ");
        FcmNotification notification = createNotification(msgTitle, msgBody);
        FcmData data = createData(msgTitle, msgBody, patientId, false);
        FcmMessage fcmMessage = createFcmMessage(patientId, notification, data);
        fcmService.sendNotification(fcmMessage);
  /*      try {
            FcmMessage fcmMessage = createFcmMessage(patientId, notification, data);
        fcmService.sendNotification(fcmMessage);
        }catch ( Exception e){
            log.error("Exception Occured : "+e.getMessage());
        }*/

    }

    private FcmNotification createNotification(String msgTitle, String msgBody) {
        FcmNotification notification = new FcmNotification();
        notification.setTitle(msgTitle);
        notification.setBody(msgBody);
        return notification;
    }

    private FcmData createData(String msgTitle, String msgBody, long patientId, boolean showNotification) {
        FcmData data = new FcmData();
        data.setPatientId(patientId);
        data.setShowNotification(showNotification);
        data.setReasonSend(EnumFcmMessageReason.UPDATE_SENSOR_TIMER.getReason());
        data.setReasonCode(EnumFcmMessageReason.UPDATE_SENSOR_TIMER.getCode());
        data.setMsgTitle(msgTitle);
        data.setMsg(msgBody);
        return data;
    }

    private FcmMessage createFcmMessage(long patientId, FcmNotification notification, FcmData data) {
        log.info("patient Timer > sendFcmMessage  > createFcmMessage Patient Id : " + patientId);
        FcmMessage fcmMessage = new FcmMessage();

//        fcmTokenController.
//        log.info(" TOKEN : Alicak " + fcmTokenService.findByUserId(patientId).getToken());
//        log.info(" fcmTokenService  " + fcmTokenService);
//        String token = fcmTokenService.findByUserId(patientId).getToken();
        String token = Objects.requireNonNull(fcmTokenController.findTokenByPatientId(patientId).getBody()).getData().getToken();
        fcmMessage.setTo(token);
        fcmMessage.setNotification(notification);
        fcmMessage.setData(data);
        return fcmMessage;
    }
}
