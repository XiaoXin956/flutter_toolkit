
import 'package:equatable/equatable.dart';
import 'package:flutter_toolkit/blocs/language/language_bean.dart';

abstract class LanguageEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LanguageInitEvent extends LanguageEvent {

  @override
  List<Object?> get props => [];
}

class LanguageGetTypeEvent extends LanguageEvent {

  @override
  List<Object?> get props => [];
}

class LanguageSelectEvent extends LanguageEvent {
  final LanguageBean languageBean;

  LanguageSelectEvent({required this.languageBean});

}
