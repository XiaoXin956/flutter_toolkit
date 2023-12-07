import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_toolkit/utils/date_tool.dart';
import 'package:meta/meta.dart';

part 'date_select_state.dart';

class DateSelectCubit extends Cubit<DateSelectState> {
  DateSelectCubit() : super(DataSelectInitialState());

  // 选择时间选项
  checkStartDateDay({
    required List<DateBean> dateData, // 现有的数据
    required DateBean checkDate, // 选中的日期
    required int index, // 选中的下标
    required DateBean? startDate, // 开始日期
    required DateBean? endDate, // 结束日期
  }) {
    // 判断开始是否为空
    if (startDate == null) {
      DateBean selectDate = dateData[index];
      selectDate.itemState = DateStatus.begin;
      emit(DateSelectStartCheckState(startDateBean: selectDate, index: index));
    } else {
      dateData.forEach((element) {
        if(element.itemState != DateStatus.disabled){
          element.itemState = DateStatus.normal;
        }
      });
      // 重新设置开始日期
      DateBean selectDate = dateData[index];
      selectDate.itemState = DateStatus.begin;
      emit(DateSelectStartCheckState(startDateBean: selectDate, index: index));
    }
  }

  // 选择时间选项
  checkEndDateDay({
    required List<DateBean> dateData, // 现有的数据
    required DateBean checkDate, // 选中的日期
    required int index, // 选中的下标
    required DateBean? startDate, // 开始日期
    required DateBean? endDate, // 结束日期
  }) {
    // 判断开始是否为空


      DateBean selectDate = dateData[index];
      int lastIndex = dateData.indexWhere((element) {
        if (element.id == startDate!.id) {
          return true;
        }
        return false;
      });
      selectDate.itemState = DateStatus.end;

      dateData.getRange(lastIndex, index).forEach((element) {

        if(element.id == startDate!.id){
          element.itemState = DateStatus.begin;
        }else{
          if(element.itemState != DateStatus.disabled){
            element.itemState = DateStatus.check;
          }
        }

      });

      emit(DateSelectEndCheckState(endDateBean: selectDate, index: index));
  }
}
