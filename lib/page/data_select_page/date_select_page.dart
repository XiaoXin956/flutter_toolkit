import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_toolkit/page/data_select_page/date_select_cubit.dart';
import 'package:flutter_toolkit/utils/date_tool.dart';

class DataSelectPage extends StatefulWidget {
  String? startDate = "";
  String? endDate = "";

  DataSelectPage({super.key, this.startDate, this.endDate});

  @override
  State<DataSelectPage> createState() => _DataSelectPageState();
}

class _DataSelectPageState extends State<DataSelectPage> {
  DateSelectCubit? dateSelectCubit;
  List<Widget> weekWidget = [];
  List<DateBean> dateData = [];
  bool isDay = false;
  DateBean? startDate;
  DateBean? endDate;

  @override
  void initState() {
    super.initState();

    weekWidget.add(Expanded(child: Center(child: Padding(padding: EdgeInsets.only(top: 3, bottom: 3), child: Text("日", style: TextStyle(fontSize: 16))))));
    weekWidget.add(Expanded(child: Center(child: Padding(padding: EdgeInsets.only(top: 3, bottom: 3), child: Text("一", style: TextStyle(fontSize: 16))))));
    weekWidget.add(Expanded(child: Center(child: Padding(padding: EdgeInsets.only(top: 3, bottom: 3), child: Text("二", style: TextStyle(fontSize: 16))))));
    weekWidget.add(Expanded(child: Center(child: Padding(padding: EdgeInsets.only(top: 3, bottom: 3), child: Text("三", style: TextStyle(fontSize: 16))))));
    weekWidget.add(Expanded(child: Center(child: Padding(padding: EdgeInsets.only(top: 3, bottom: 3), child: Text("四", style: TextStyle(fontSize: 16))))));
    weekWidget.add(Expanded(child: Center(child: Padding(padding: EdgeInsets.only(top: 3, bottom: 3), child: Text("五", style: TextStyle(fontSize: 16))))));
    weekWidget.add(Expanded(child: Center(child: Padding(padding: EdgeInsets.only(top: 3, bottom: 3), child: Text("六", style: TextStyle(fontSize: 16))))));
    dateData = DateTool.getCompleteData();
  }

  @override
  void reassemble() {
    super.reassemble();
    dateData.clear();
    dateData = DateTool.getCompleteData();
    printBlue(dateData);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return DateSelectCubit();
      },
      child: BlocBuilder<DateSelectCubit, DateSelectState>(
        builder: (BuildContext context, state) {
          dateSelectCubit = context.read<DateSelectCubit>();
          if (state is DateSelectStartCheckState) {
            // 开始时间
            startDate = state.startDateBean;
            endDate = null;
            printBlue(startDate);
          } else if (state is DateSelectEndCheckState) {
            // 结束时间
            endDate = state.endDateBean;
          }
          return buildUI();
        },
      ),
    );
  }

  Widget buildUI() {
    return Container(
        height: 500,
        child: Column(
          children: [
            Container(
              child: Row(
                children: weekWidget,
              ),
              color: Colors.grey,
              padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
            ),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.only(left: 10, right: 10),
                // padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
                itemCount: dateData.length,
                itemBuilder: (BuildContext context, int index) {
                  DateBean selectDateBean = dateData[index];
                  if (selectDateBean.day != null) {
                    isDay = true;
                  } else {
                    isDay = false;
                  }
                  // 选中的颜色
                  Color bgColor = Colors.white;
                  if (selectDateBean.itemType == DateType.day) {
                    // 只修改日数据的ui
                    if (selectDateBean.itemState == DateStatus.normal) {
                      bgColor = Colors.white;
                    } else if (selectDateBean.itemState == DateStatus.begin) {
                      bgColor = Colors.green;
                    } else if (selectDateBean.itemState == DateStatus.end) {
                      bgColor = Colors.green;
                    } else if (selectDateBean.itemState == DateStatus.check) {
                      bgColor = Colors.green;
                    } else if (selectDateBean.itemState == DateStatus.disabled) {
                      bgColor = Colors.white;
                    }
                  }
                  Color textColor = Colors.black;
                  if (selectDateBean.itemType == DateType.day) {
                    // 只修改日数据的ui
                    if (selectDateBean.itemState == DateStatus.normal) {
                      textColor = Colors.black;
                    } else if (selectDateBean.itemState == DateStatus.begin) {
                      textColor = Colors.white;
                    } else if (selectDateBean.itemState == DateStatus.end) {
                      textColor = Colors.white;
                    } else if (selectDateBean.itemState == DateStatus.check) {
                      textColor = Colors.white;
                    } else if (selectDateBean.itemState == DateStatus.disabled) {
                      textColor = Colors.black;
                    }
                  }
                  String showText;
                  if (selectDateBean.itemType == DateType.month) {
                    // 月数据
                    showText = selectDateBean.show.toString();
                  } else {
                    // 日数据
                    showText = selectDateBean.day ?? "";
                  }
                  BorderRadius radius = BorderRadius.zero;
                  if (selectDateBean.itemState == DateStatus.begin) {
                    radius = const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    );
                  } else if (selectDateBean.itemState == DateStatus.end) {
                    radius = const BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      topRight: Radius.circular(20),
                    );
                  } else if (selectDateBean.itemState == DateStatus.check) {
                    radius = const BorderRadius.only(
                      bottomRight: Radius.circular(0),
                      topRight: Radius.circular(0),
                    );
                  }

                  return GestureDetector(
                    onTap: () {
                      if (selectDateBean.itemType == DateType.month || selectDateBean.itemState == DateStatus.disabled) {
                        printRed("不能选择");
                        return;
                      }
                      // 如果没有选过，或者再次选择开始的地方，或者选择的比较小的
                      if (startDate == null || startDate?.id == selectDateBean.id || selectDateBean.dateTime!.isBefore(startDate!.dateTime!)) {
                        dateSelectCubit?.checkStartDateDay(dateData: dateData, checkDate: selectDateBean, index: index, startDate: startDate, endDate: null);
                      } else if (selectDateBean.dateTime!.isAfter(startDate!.dateTime!)) {
                        if (startDate != null && endDate != null) {
                          dateSelectCubit?.checkStartDateDay(dateData: dateData, checkDate: selectDateBean, index: index, startDate: startDate, endDate: null);
                        } else {
                          // 选择结束日期
                          dateSelectCubit?.checkEndDateDay(dateData: dateData, checkDate: selectDateBean, index: index, startDate: startDate, endDate: null);
                        }
                      }
                    },
                    child: Container(
                      height: 30,
                      margin: EdgeInsets.only(top: 4, bottom: 4),
                      decoration: BoxDecoration(color: bgColor, borderRadius: radius),
                      alignment: Alignment.center,
                      child: Text(
                        showText,
                        style: TextStyle(color: textColor),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "开始时间",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                Text(
                  "结束时间",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "${startDate == null ? "" : "${startDate?.year}年${startDate?.month}月${startDate?.day}日"}",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                Text(
                  "${endDate == null ? "" : "${endDate?.year}年${endDate?.month}月${endDate?.day}日"}",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              width: double.maxFinite,
              child: ElevatedButton(onPressed: () {}, child: Text("確定")),
            ),
          ],
        ));

  }

}
