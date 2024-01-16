import 'package:flutter_toolkit/utils/print_utils.dart';

class DateTool {
  /// 年月日时分秒
  static String getToDay() {
    DateTime currentTime = DateTime.now();
    var month = (currentTime.month.toString().length == 1) ? "0${currentTime.month}" : currentTime.month;
    var day = (currentTime.day.toString().length == 1) ? "0${currentTime.day}" : currentTime.day;
    var hour = (currentTime.hour.toString().length == 1) ? "0${currentTime.hour}" : currentTime.hour;
    var minute = (currentTime.minute.toString().length == 1) ? "0${currentTime.minute}" : currentTime.minute;
    var second = (currentTime.second.toString().length == 1) ? "0${currentTime.second}" : currentTime.second;
    return "${currentTime.year}-$month-$day $hour:$minute:$second";
  }

  /// 年月日
  static String getYMDHMS({String? date}) {
    DateTime currentTime = DateTime.parse(date.toString());
    var month = (currentTime.month.toString().length == 1) ? "0${currentTime.month}" : currentTime.month;
    var day = (currentTime.day.toString().length == 1) ? "0${currentTime.day}" : currentTime.day;
    var hour = (currentTime.hour.toString().length == 1) ? "0${currentTime.hour}" : currentTime.hour;
    var minute = (currentTime.minute.toString().length == 1) ? "0${currentTime.minute}" : currentTime.minute;
    var second = (currentTime.second.toString().length == 1) ? "0${currentTime.second}" : currentTime.second;
    return "${currentTime.year}-$month-$day $hour:$minute:$second";
  }

  /// 当前时间 年月日时分
  static String getTodayYearMothDayHourMinute() {
    DateTime currentTime = DateTime.now();
    var month = (currentTime.month.toString().length == 1) ? "0${currentTime.month}" : currentTime.month;
    var day = (currentTime.day.toString().length == 1) ? "0${currentTime.day}" : currentTime.day;
    var hour = (currentTime.hour.toString().length == 1) ? "0${currentTime.hour}" : currentTime.hour;
    var minute = (currentTime.minute.toString().length == 1) ? "0${currentTime.minute}" : currentTime.minute;
    return "${currentTime.year}-$month-$day $hour:$minute";
  }

  /// 当天最后的时间
  static String todayEnd() {
    DateTime currentTime = DateTime.now();
    var month = (currentTime.month.toString().length == 1) ? "0${currentTime.month}" : currentTime.month;
    var day = (currentTime.day.toString().length == 1) ? "0${currentTime.day}" : currentTime.day;
    return "${currentTime.year}-${month}-${day} 23:59:59";
  }

  // 时间戳
  static String timestamp() {
    DateTime currentTime = DateTime.now();
    return "${currentTime.microsecondsSinceEpoch}";
  }

  // 指定时间的多少天前，或者当前的多少天前
  static String ageDay(String currDateTime, int days) {
    DateTime dateTime = (currDateTime != "") ? DateTime.parse(currDateTime) : DateTime.now();
    DateTime dateResult = DateTime(dateTime.year, dateTime.month, dateTime.day - days, dateTime.hour, dateTime.minute, dateTime.second);
    var month = (dateResult.month.toString().length == 1) ? "0${dateResult.month}" : dateResult.month;
    var day = (dateResult.day.toString().length == 1) ? "0${dateResult.day}" : dateResult.day;
    return "${dateResult.year}-$month-$day";
  }

  // 生成时间日期数据
  static List<DateBean> getCompleteData({int defaultWeek = 7,String? startTime = "", String? endTime = "", int apartDay = 140}) {
    List<DateBean> dateData = [];
    DateTime startDate;
    if (startTime != "") {
      startDate = DateTime.parse(startTime.toString());
    } else {
      startDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).subtract(Duration(days: apartDay));
    }
    DateTime endDate;
    if (endTime != "") {
      endDate = DateTime.parse(endTime.toString());
    } else {
      endDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    }
    // 开始日期和结束如期
    printRed(
        "开始日期 ${startDate.year}-${(startDate.month < 10) ? "0${startDate.month}" : startDate.month}-${(startDate.day < 10) ? "0${startDate.day}" : startDate.day}  结束如期${endDate.year}-${(endDate.month < 10) ? "0${endDate.month}" : endDate.month}-${(endDate.day < 10) ? "0${endDate.day}" : endDate.day} ");
    startDate.add(Duration(days: 2));

    bool isFirst = true;
    // 遍历月的范围
    while (startDate.isBefore(endDate)) {
      // 月份数据
      DateBean dateMonthBean = DateBean();
      dateMonthBean.id =
          "${startDate.year.toString()}${(startDate.month < 10) ? "0${startDate.month}" : startDate.month.toString()}${(startDate.day < 10) ? "0${startDate.day}" : "${startDate.day.toString()}"}";
      dateMonthBean.month = (startDate.month < 10) ? "0${startDate.month}" : startDate.month.toString();
      dateMonthBean.day = (startDate.day < 10) ? "0${startDate.day}" : startDate.day.toString();
      dateMonthBean.itemType = DateType.month;
      dateMonthBean.itemState = DateStatus.disabled;
      dateMonthBean.dateTime = startDate;
      dateMonthBean.year = startDate.year.toString();
      dateMonthBean.show = startDate.year.toString();
      dateData.add(dateMonthBean);
      // 月份数据
      DateBean dateMonthDayBean = DateBean();
      dateMonthBean.id =
          "${startDate.year.toString()}${(startDate.month < 10) ? "0${startDate.month}" : startDate.month.toString()}${(startDate.day < 10) ? "0${startDate.day}" : "${startDate.day.toString()}"}";
      dateMonthDayBean.month = (startDate.month < 10) ? "0${startDate.month}" : startDate.month.toString();
      dateMonthDayBean.day = (startDate.day < 10) ? "0${startDate.day}" : startDate.day.toString();
      dateMonthDayBean.itemType = DateType.month;
      dateMonthDayBean.itemState = DateStatus.disabled;
      dateMonthDayBean.dateTime = startDate;
      dateMonthDayBean.year = startDate.year.toString();
      dateMonthDayBean.show = (startDate.month < 10) ? "0${startDate.month}" : startDate.month.toString();
      dateData.add(dateMonthDayBean);

      _addDatePlaceholder(dateData, 5, "${startDate.year}${(startDate.month < 10) ? "0${startDate.month}" : startDate.month.toString()}");

      DateTime startMonthDate = startDate; // 当月的开始数据

      DateTime endMonthDate = DateTime(startMonthDate.year, startMonthDate.month + 1, 1); // 月尾的结束数据
      // 判断结束时间是否在当月内
      if (startMonthDate.year == endDate.year && startMonthDate.month == endDate.month) {
        endMonthDate = DateTime(endDate.year, endDate.month, endDate.day);
      }
      // 遍历日数据
      while (startMonthDate.isBefore(endMonthDate) || startMonthDate.isAtSameMomentAs(endDate)) {
        int weekday = startMonthDate.weekday;
        if (isFirst) {
          isFirst = false;
          // 获取时间点
          weekday = startMonthDate.weekday;
          _firstDatePlaceholder(dateData, weekday, "${startMonthDate.month > 10 ? "0${startMonthDate.month}" : startMonthDate.month}");
        } else {
          // 判断是否为当月1号
          if (startMonthDate.day == 1) {
            weekday = startMonthDate.weekday;
            _firstDatePlaceholder(dateData, weekday, "${startMonthDate.month > 10 ? "0${startMonthDate.month}" : startMonthDate.month}");
          }
        }
        DateBean dayDate = DateBean();
        dayDate.id =
            "${startMonthDate.year.toString()}${(startMonthDate.month < 10) ? "0${startMonthDate.month}" : startMonthDate.month.toString()}${(startMonthDate.day < 10) ? "0${startMonthDate.day}" : "${startMonthDate.day.toString()}"}";
        dayDate.day = "${startMonthDate.day < 10 ? "0${startMonthDate.day}" : startMonthDate.day}";
        dayDate.month = "${startMonthDate.month < 10 ? "0${startMonthDate.month}" : startMonthDate.month}";
        dayDate.year = startMonthDate.year.toString();
        dayDate.dateTime = startMonthDate;
        dayDate.itemState = DateStatus.normal;
        dayDate.itemType = DateType.day;
        dayDate.show = (startDate.day < 10) ? "0${startDate.day}" : startDate.day.toString();
        dateData.add(dayDate);
        printRed("今天是周 $weekday   开始日期 $startMonthDate    当月结束日期$endMonthDate");
        // 判断是否为当月的最后一天
        DateTime nextDay = DateTime(startMonthDate.year, startMonthDate.month, startMonthDate.day + 1);
        if (nextDay.month != startMonthDate.month) {
          weekday = startMonthDate.weekday;
          _lastDatePlaceholder(dateData, weekday, "${startMonthDate.month < 10 ? "0${startMonthDate.month}" : startMonthDate.month}");
        }
        startMonthDate = DateTime(startMonthDate.year, startMonthDate.month, startMonthDate.day).add(Duration(days: 1));
      }
      startDate = DateTime(startDate.year, startDate.month + 1, 1);
    }
    // 遍历日的范围

    return dateData;
  }

  static void _firstDatePlaceholder(List<DateBean> dateBeans, int weekday, String monthStr) {
    switch (weekday) {
      case 1:
        _addDatePlaceholder(dateBeans, 1, monthStr);
        break;
      case 2:
        _addDatePlaceholder(dateBeans, 2, monthStr);
        break;
      case 3:
        _addDatePlaceholder(dateBeans, 3, monthStr);
        break;
      case 4:
        _addDatePlaceholder(dateBeans, 4, monthStr);
        break;
      case 5:
        _addDatePlaceholder(dateBeans, 5, monthStr);
        break;
      case 6:
        _addDatePlaceholder(dateBeans, 6, monthStr);
        break;
      case 7:
        _addDatePlaceholder(dateBeans, 0, monthStr);
        break;
    }
  }

  static void _lastDatePlaceholder(List<DateBean> dateBeans, int weekday, String monthStr) {
    switch (weekday) {
      case 1:
        _addDatePlaceholder(dateBeans, 5, monthStr);
        break;
      case 2:
        _addDatePlaceholder(dateBeans, 4, monthStr);
        break;
      case 3:
        _addDatePlaceholder(dateBeans, 3, monthStr);
        break;
      case 4:
        _addDatePlaceholder(dateBeans, 2, monthStr);
        break;
      case 5:
        _addDatePlaceholder(dateBeans, 1, monthStr);
        break;
      case 6:
        _addDatePlaceholder(dateBeans, 0, monthStr);
        break;
      case 7:
        _addDatePlaceholder(dateBeans, 6, monthStr);
        break;
    }
  }

  static void _addDatePlaceholder(List<DateBean> dateBeans, int count, String monthStr) {
    printWhite("占位 $count 个");
    for (int i = 0; i < count; i++) {
      DateBean dateBean = DateBean();
      dateBean.id = "$monthStr$i";
      dateBean.month = monthStr;
      dateBean.itemState = DateStatus.disabled; // 空白处禁用
      dateBeans.add(dateBean);
    }
  }
}

class DateBean {
  DateType itemType = DateType.day; //默认是日期item
  DateStatus itemState = DateStatus.normal; // 当天的日期状态
  DateTime? dateTime; //具体日期
  String? day; //一个月的某天
  String? month; //月份
  String? year; //年
  String? show; //显示的数据
  String? id; // 日期id
}

// 日期状态
enum DateStatus { check, disabled, normal, begin, end }

// 日期类型
enum DateType { day, month }
