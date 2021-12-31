package com.ling.vhr.calendar;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Constants;
import org.junit.jupiter.api.Test;
import org.springframework.util.CollectionUtils;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.*;
import java.util.List;

/**
 * @author zhangling
 * @date 2021/12/31 11:40 上午
 */
public class CalendarTest {

    // public void createCalendar(WorkCalendarDTO workCalendarDTO) {
    //     // 1. 创建工作日历方案
    //     Long planId = createPlan(workCalendarDTO);
    //     // 2. 批量设置工作时间
    //     BatchWorkHoursDTO batchWorkHours = workCalendarDTO.getBatchWorkHours();
    //     Map<Integer, List<LocalDate>> dayOfWeekMap = getDayOfWeekMap(batchWorkHours.getEffectiveTimeStart(), batchWorkHours.getEffectiveTimeEnd());
    //
    //     // 休息日
    //     List<WorkCalendarDateDO> dateList = new ArrayList<>();
    //     setDateList(planId, dayOfWeekMap, dateList, batchWorkHours.getRestDays(), Constants.CalDateType.REST_DAY);
    //     // 工作日
    //     setDateList(planId, dayOfWeekMap, dateList, batchWorkHours.getWorkDays(), Constants.CalDateType.WORK_DAY);
    //     // 半工作日
    //     setDateList(planId, dayOfWeekMap, dateList, batchWorkHours.getAmRestDays(), Constants.CalDateType.HALF_REST_DAY);
    //     setDateList(planId, dayOfWeekMap, dateList, batchWorkHours.getPmRestDays(), Constants.CalDateType.HALF_REST_DAY);
    //     this.saveBatch(dateList);
    //
    //     // 3. 批量日期时间段处理
    //     List<WorkCalendarTimeDO> timeList = new ArrayList<>();
    //     for (WorkCalendarDateDO dateDO : dateList) {
    //         WorkCalendarTimeDO amTime = new WorkCalendarTimeDO()
    //                 .setDateId(dateDO.getDateId())
    //                 .setPeriodType(Constants.ZERO)
    //                 .setStartTime(batchWorkHours.getAmWorkTimeStart())
    //                 .setEndTime(batchWorkHours.getAmWorkTimeEnd())
    //                 .setWorkHours(batchWorkHours.getAmWorkTimeEnd().getSecond() - batchWorkHours.getAmWorkTimeStart().getSecond());
    //         timeList.add(amTime);
    //         WorkCalendarTimeDO pmTime = new WorkCalendarTimeDO()
    //                 .setDateId(dateDO.getDateId())
    //                 .setPeriodType(Constants.ONE)
    //                 .setStartTime(batchWorkHours.getPmWorkTimeStart())
    //                 .setEndTime(batchWorkHours.getPmWorkTimeEnd())
    //                 .setWorkHours(batchWorkHours.getPmWorkTimeEnd().getSecond() - batchWorkHours.getPmWorkTimeStart().getSecond());
    //         timeList.add(pmTime);
    //     }
    //     workCalendarTimeService.saveBatch(timeList);
    //     // 4. 特定工作日历日期处理
    //     List<CalendarDayDTO> calendarDayList = workCalendarDTO.getCalendarDayList();
    //     List<WorkCalendarDateDO> insertDateDOList = new ArrayList<>();
    //     List<WorkCalendarDateDO> updateDateDOList = new ArrayList<>();
    //     List<WorkCalendarTimeDO> insertTimeDOList = new ArrayList<>();
    //     List<WorkCalendarTimeDO> updateTimeDOList = new ArrayList<>();
    //     for (CalendarDayDTO calendarDayDTO : calendarDayList) {
    //         QueryWrapper<WorkCalendarDateDO> query = new QueryWrapper<>(new WorkCalendarDateDO()
    //                 .setPlanId(planId)
    //                 .setCalendarDay(calendarDayDTO.getCalendarDay()));
    //         if (this.count(query) > 0) {
    //             WorkCalendarDateDO dateDO = this.getOne(query);
    //             updateDateDOList.add(new WorkCalendarDateDO()
    //                     .setDateId(dateDO.getDateId())
    //                     .setDateType(calendarDayDTO.getDateType()));
    //             // 特定日期时间段处理
    //             QueryWrapper<WorkCalendarTimeDO> queryWrapper = new QueryWrapper<>(new WorkCalendarTimeDO().setDateId(dateDO.getDateId()));
    //             List<WorkCalendarTimeDO> list = workCalendarTimeService.list(queryWrapper);
    //             for (WorkCalendarTimeDO timeDO : list) {
    //                 if (Constants.ZERO.equals(timeDO.getPeriodType())) {
    //                     updateTimeDOList.add(new WorkCalendarTimeDO()
    //                             .setTimeId(timeDO.getTimeId())
    //                             .setStartTime(calendarDayDTO.getAmWorkTimeStart())
    //                             .setEndTime(calendarDayDTO.getAmWorkTimeEnd()));
    //                 } else {
    //                     updateTimeDOList.add(new WorkCalendarTimeDO()
    //                             .setTimeId(timeDO.getTimeId())
    //                             .setStartTime(calendarDayDTO.getPmWorkTimeStart())
    //                             .setEndTime(calendarDayDTO.getPmWorkTimeEnd()));
    //                 }
    //             }
    //
    //         } else {
    //             WorkCalendarDateDO dateDO = new WorkCalendarDateDO()
    //                     .setDateType(calendarDayDTO.getDateType())
    //                     .setCalendarDay(calendarDayDTO.getCalendarDay())
    //                     .setPlanId(planId);
    //             this.save(dateDO);
    //             insertTimeDOList.add(new WorkCalendarTimeDO()
    //                     .setDateId(dateDO.getDateId())
    //                     .setPeriodType(Constants.ZERO)
    //                     .setStartTime(calendarDayDTO.getAmWorkTimeStart())
    //                     .setEndTime(calendarDayDTO.getAmWorkTimeEnd())
    //                     .setWorkHours(calendarDayDTO.getAmWorkTimeEnd().getSecond() - calendarDayDTO.getAmWorkTimeStart().getSecond()));
    //             insertTimeDOList.add(new WorkCalendarTimeDO()
    //                     .setDateId(dateDO.getDateId())
    //                     .setPeriodType(Constants.ZERO)
    //                     .setStartTime(calendarDayDTO.getPmWorkTimeStart())
    //                     .setEndTime(calendarDayDTO.getPmWorkTimeEnd())
    //                     .setWorkHours(calendarDayDTO.getPmWorkTimeEnd().getSecond() - calendarDayDTO.getPmWorkTimeStart().getSecond()));
    //         }
    //     }
    //     this.saveBatch(insertDateDOList);
    //     this.updateBatchById(updateDateDOList);
    //     workCalendarTimeService.updateBatchById(updateTimeDOList);
    //     for (WorkCalendarDateDO dateDO : insertDateDOList) {
    //
    //     }
    //
    // }

    // private void setDateList(Long planId, Map<Integer, List<LocalDate>> dayOfWeekMap, List<WorkCalendarDateDO> dateList, List<Integer> restDays, Integer dateTye) {
    //     if (!CollectionUtils.isEmpty(restDays)) {
    //         for (Integer restDay : restDays) {
    //             for (LocalDate date : dayOfWeekMap.get(restDay)) {
    //                 WorkCalendarDateDO dateDO = new WorkCalendarDateDO()
    //                         .setPlanId(planId)
    //                         .setDateType(dateTye)
    //                         .setCalendarDay(date)
    //                         .setCreatedBy(UserContext.getUserCode())
    //                         .setUpdatedBy(UserContext.getUserCode());
    //                 dateList.add(dateDO);
    //             }
    //         }
    //     }
    // }
    @Test
    public void tset01() throws Exception{
        // 判断两个日期是否是相等 , 可以使用equals方法比较，LocalDate重载了equals方法，字符串需先解析成对象
        LocalDate today = LocalDate.now();
        LocalDate date1 = LocalDate.of(2020,6,23);

        System.out.println("间隔年 = " + date1.until(today, ChronoUnit.YEARS));
        System.out.println("间隔月 = " + date1.until(today, ChronoUnit.MONTHS));
        System.out.println("间隔天 = " + date1.until(today, ChronoUnit.DAYS));

        if(date1.equals(today)){
            System.out.println("相等");
        }else{
            System.out.println("不相等");
        }

        LocalTime now = LocalTime.now();
        LocalTime time = LocalTime.of(12, 00, 00);
        Duration between = Duration.between(time, now);
        System.out.println("相差天数 = " + between.toDays());
        System.out.println("相差分钟数 = " + between.toMinutes());
        System.out.println("相差毫秒数 = " + between.toMillis());
        System.out.println("相差秒数 = " + between.getSeconds());


    }

    public Map<Integer, List<LocalDate>> getDayOfWeekMap(LocalDate effectiveTimeStart, LocalDate effectiveTimeEnd) {
        Calendar startCal = new GregorianCalendar(effectiveTimeStart.getYear(), effectiveTimeStart.getMonthValue() - 1, effectiveTimeStart.getDayOfMonth());
        Calendar endCal = new GregorianCalendar(effectiveTimeEnd.getYear(), effectiveTimeEnd.getMonthValue() - 1, effectiveTimeEnd.getDayOfMonth());
        Map<Integer, List<LocalDate>> dayOfWeekMap = new HashMap<Integer, List<LocalDate>>() {
            {
                put(1, new ArrayList<>());
                put(2, new ArrayList<>());
                put(3, new ArrayList<>());
                put(4, new ArrayList<>());
                put(5, new ArrayList<>());
                put(6, new ArrayList<>());
                put(7, new ArrayList<>());
            }
        };

        int startYear = startCal.get(Calendar.YEAR);
        int endYear = endCal.get(Calendar.YEAR);
        int startWeek = startCal.get(Calendar.WEEK_OF_YEAR);
        int endWeek = endCal.get(Calendar.WEEK_OF_YEAR);

        Calendar cal = new GregorianCalendar();
        while (startYear <= endYear) {
            if (startYear == endYear) {
                dayOfWeekMap.get(1).addAll(getDayOfWeek(startWeek, endWeek, cal, Calendar.MONDAY, startCal, endCal));
                dayOfWeekMap.get(2).addAll(getDayOfWeek(startWeek, endWeek, cal, Calendar.TUESDAY, startCal, endCal));
                dayOfWeekMap.get(3).addAll(getDayOfWeek(startWeek, endWeek, cal, Calendar.WEDNESDAY, startCal, endCal));
                dayOfWeekMap.get(4).addAll(getDayOfWeek(startWeek, endWeek, cal, Calendar.THURSDAY, startCal, endCal));
                dayOfWeekMap.get(5).addAll(getDayOfWeek(startWeek, endWeek, cal, Calendar.FRIDAY, startCal, endCal));
                dayOfWeekMap.get(6).addAll(getDayOfWeek(startWeek, endWeek, cal, Calendar.SATURDAY, startCal, endCal));
                dayOfWeekMap.get(7).addAll(getDayOfWeek(startWeek, endWeek, cal, Calendar.SUNDAY, startCal, endCal));
            } else {
                dayOfWeekMap.get(1).addAll(getDayOfWeek(startWeek, 52, cal, Calendar.MONDAY, startCal, endCal));
                dayOfWeekMap.get(2).addAll(getDayOfWeek(startWeek, 52, cal, Calendar.TUESDAY, startCal, endCal));
                dayOfWeekMap.get(3).addAll(getDayOfWeek(startWeek, 52, cal, Calendar.WEDNESDAY, startCal, endCal));
                dayOfWeekMap.get(4).addAll(getDayOfWeek(startWeek, 52, cal, Calendar.THURSDAY, startCal, endCal));
                dayOfWeekMap.get(5).addAll(getDayOfWeek(startWeek, 52, cal, Calendar.FRIDAY, startCal, endCal));
                dayOfWeekMap.get(6).addAll(getDayOfWeek(startWeek, 52, cal, Calendar.SATURDAY, startCal, endCal));
                dayOfWeekMap.get(7).addAll(getDayOfWeek(startWeek, 52, cal, Calendar.SUNDAY, startCal, endCal));
                startWeek = 1;
            }
            startYear++;
        }
        return dayOfWeekMap;
    }

    public List<LocalDate> getDayOfWeek(int startWeek, int endWeek, Calendar cal, int dayOfWeek, Calendar startCal, Calendar endCal) {
        List<LocalDate> dayOfWeekList = new ArrayList<>();
        cal.set(Calendar.DAY_OF_WEEK, dayOfWeek);
        while (startWeek <= endWeek) {
            cal.set(Calendar.WEEK_OF_YEAR, startWeek);
            if (cal.getTimeInMillis() < startCal.getTimeInMillis() || cal.getTimeInMillis() >= (endCal.getTimeInMillis() + 24 * 60 * 60 * 1000)) {
                startWeek++;
                continue;
            }
            dayOfWeekList.add(cal.getTime().toInstant().atZone(ZoneId.systemDefault()).toLocalDate());
            startWeek++;
        }
        return dayOfWeekList;
    }
}
