import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_toolkit/blocs/data_loading/data_load_event.dart';
import 'package:flutter_toolkit/blocs/data_loading/data_load_state.dart';

class DataLoadBloc extends Bloc<DataLoadEvent, DataLoadState> {
  DataLoadBloc() : super(DataLoadInitialState()) {
    on<DataLoadInitialEvent>((event, emit) {


    });

    on<DataLoadLoadEvent>((event, emit) async {
      // 开始加载
      emit(DataLoadLoadingState());
      dynamic dataMap = event.data; // 参数
      if(dataMap["type"]==0){
        //刷新
        await Future.delayed(Duration(seconds: 1));
        emit(DataLoadSuccessState(dataSuccess: ["1","2","3","4","5"]));
      }else{
        // 加载
        // 模拟异常
        await Future.delayed(Duration(seconds: 1));
        emit(DataLoadFailState(dataFail: "加载异常"));
      }
    });

  }




}
