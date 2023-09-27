
import 'package:equatable/equatable.dart';
import 'package:flutter_toolkit/blocs/language/language_bean.dart';

abstract class LanguageState extends Equatable{
  @override
  List<Object?> get props => [];
}

class LanguageInitialState extends LanguageState {}

class LanguageTypeSuccessState extends LanguageState{

  final List<LanguageBean> languages;

  LanguageTypeSuccessState({required this.languages});

  @override
  List<Object?> get props => languages.map((e) => e).toList();

}

class LanguageRefreshState extends LanguageState{

  final LanguageBean selectLanguageBean;

  LanguageRefreshState({required this.selectLanguageBean});

  @override
  List<Object?> get props => [selectLanguageBean];

}
