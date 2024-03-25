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

  String selectedYear="";

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
                    ),

              // 日期滚动组件

              Container(
                height: 200,
                width: double.maxFinite,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Text(selectedYear.toString()),
                          Expanded(child: ListWheelScrollView(
                            itemExtent: 40,
                            children: List.generate(100, (index) {
                              if(selectedYear==index.toString()){
                                return Container(
                                    color: Colors.indigo,
                                    child: Text('${index}'));
                              }
                              return Container(
                                  color: Colors.blueGrey,
                                  child: Text('${index}'));
                            }),
                            onSelectedItemChanged: (index) {
                              setState(() {
                                selectedYear = index.toString();
                              });
                            },
                          ),)
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Text(selectedYear.toString()),
                          Expanded(child: ListWheelScrollView(
                            itemExtent: 40,
                            children: List.generate(100, (index) {
                              if(selectedYear==index.toString()){
                                return Container(
                                    color: Colors.indigo,
                                    child: Text('${index}'));
                              }
                              return Container(
                                  color: Colors.blueGrey,
                                  child: Text('${index}'));
                            }),
                            onSelectedItemChanged: (index) {
                              setState(() {
                                selectedYear = index.toString();
                              });
                            },
                          ),)
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Text(selectedYear.toString()),
                          Expanded(child: ListWheelScrollView(
                            itemExtent: 40,
                            children: List.generate(100, (index) {
                              if(selectedYear==index.toString()){
                                return Container(
                                    color: Colors.indigo,
                                    child: Text('${index}'));
                              }
                              return Container(
                                  color: Colors.blueGrey,
                                  child: Text('${index}'));
                            }),
                            onSelectedItemChanged: (index) {
                              setState(() {
                                selectedYear = index.toString();
                              });
                            },
                          ),)
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              InkWell(onTap: (){
                DateTool.generateYMD(startTime: "2023-01-25",endTime: "2024-03-25");
                // DateTool.getCompleteData(startTime: "2023-01-25",endTime: "2024-03-25");
              },child: Text("生成日期"),),


            ],
          )
        ],
      ),
    );
  }
}
