import 'package:flutter/material.dart';
import 'package:flutter_toolkit/utils/date_tool.dart';

class DatePage extends StatefulWidget {
  const DatePage({super.key});

  @override
  State<DatePage> createState() => _DatePageState();
}

class _DatePageState extends State<DatePage> {
  List<DateBean> weekData = [];
  List<DateBean> monthData = [];
  String inputWeekData = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //周数据
          Column(
            children: [
              Row(
                children: [
                  Text("周数据"),
                  Expanded(child: TextField(
                    onChanged: (value) {
                      inputWeekData = value;
                    },
                  )),
                  InkWell(
                    onTap: () {
                      try {
                        weekData = DateTool.getWeekData(selectData: inputWeekData);
                        setState(() {});
                      } catch (e) {}
                    },
                    child: Text("获取"),
                  )
                ],
              ),
              inputWeekData.isEmpty
                  ? Container()
                  : Column(
                      children: weekData
                          .map((e) => Container(
                                child: Center(child: Text("${e.year.toString()} ${e.month.toString()} ${e.day.toString()}")),
                              ))
                          .toList(),
                    ),
              Row(
                children: [
                  Text("月数据"),
                  Expanded(child: TextField(
                    onChanged: (value) {
                      inputWeekData = value;
                    },
                  )),
                  InkWell(
                    onTap: () {
                      try {
                        monthData = DateTool.getMonthData(selectData: inputWeekData,placeholder: true);
                        setState(() {});
                      } catch (e) {}
                    },
                    child: Text("获取"),
                  )
                ],
              ),
              inputWeekData.isEmpty
                  ? Container()
                  : Column(
                      children: monthData
                          .map((e) => Container(
                                child: Center(child: Text("${e.year.toString()} ${e.month.toString()} ${e.day.toString()}")),
                              ))
                          .toList(),
                    )
            ],
          )
        ],
      ),
    );
  }
}
