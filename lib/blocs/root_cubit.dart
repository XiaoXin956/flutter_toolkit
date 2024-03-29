import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'root_state.dart';

class RootCubit extends Cubit<RootState> {
  RootCubit() : super(RootInitial());

  changeThemeData({required ThemeData? themeData}) {
    emit(RootChangeThemeDataState(themeData: themeData!));
  }


}


