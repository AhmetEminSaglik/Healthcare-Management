package com.ahmeteminsaglik.ws.model.bloodresult;

import com.ahmeteminsaglik.ws.model.enums.EnumBloodResultContent;

import java.util.HashMap;

public class BloodResultAssessmentValue {
    //    final List<ItemRangeValue> list = new ArrayList<>();
    private final HashMap<String, ItemRangeValue> map = new HashMap();

    public BloodResultAssessmentValue() {
        map.putIfAbsent(EnumBloodResultContent.BLOOD_SUGAR.getName(), bloodSugarRange);
        map.putIfAbsent(EnumBloodResultContent.BLOOD_PRESSURE.getName(), bloodPressureRange);
        map.putIfAbsent(EnumBloodResultContent.CALCIUM.getName(), calciumRange);
        map.putIfAbsent(EnumBloodResultContent.MAGNESIUM.getName(), magnesiumRange);
//        list.add(bloodSugar);
//        list.add(bloodPressure);
//        list.add(magnesium);
//        list.add(calcium);
    }

    private final ItemRangeValue bloodSugarRange = new ItemRangeValue(20, 170);
    private final ItemRangeValue bloodPressureRange = new ItemRangeValue(20, 170);
    private final ItemRangeValue magnesiumRange = new ItemRangeValue(20, 170);
    private final ItemRangeValue calciumRange = new ItemRangeValue(20, 170);

    public HashMap<String, ItemRangeValue> getMap() {
        return map;
    }

    public ItemRangeValue getBloodSugarRange() {
        return bloodSugarRange;
    }

    public ItemRangeValue getBloodPressureRange() {
        return bloodPressureRange;
    }

    public ItemRangeValue getMagnesiumRange() {
        return magnesiumRange;
    }

    public ItemRangeValue getCalciumRange() {
        return calciumRange;
    }
}
