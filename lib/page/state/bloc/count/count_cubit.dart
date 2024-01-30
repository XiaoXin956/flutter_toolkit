import 'dart:math';

import 'package:bloc/bloc.dart';

import 'count_state.dart';

class CountCubit extends Cubit<CountState> {
  CountCubit() : super(CountState().init());

  getResult(){
    emit(CountResultState(result: "${Random().nextInt(50000)}"));
  }

}
