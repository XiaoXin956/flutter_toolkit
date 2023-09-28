import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter_toolkit/blocs/language/language_bean.dart';
import 'package:flutter_toolkit/blocs/language/language_event.dart';
import 'package:flutter_toolkit/blocs/language/language_state.dart';
import 'package:flutter_toolkit/generated/l10n.dart';


class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageInitialState()) {
    on<LanguageEvent>((event, emit) {

    });
    on<LanguageGetTypeEvent>((event, emit) {
      List<LanguageBean> languages = [
        LanguageBean(id: 1,local: "zh",language: "中文"),
        LanguageBean(id: 2,local: "en",language: "英文"),
      ];
      emit(LanguageTypeSuccessState(languages:languages));
    });
    on<LanguageSelectEvent>((event, emit) async {
      String locale = event.languageBean.local.toString();
      S.load(Locale(locale));
      emit(LanguageRefreshState(selectLanguageBean: event.languageBean));
    });
  }
}
