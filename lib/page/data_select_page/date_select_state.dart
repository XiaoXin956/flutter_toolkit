part of 'date_select_cubit.dart';

@immutable
abstract class DateSelectState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DataSelectInitialState extends DateSelectState {}

class DateSelectStartCheckState extends DateSelectState {
  final DateBean startDateBean;
  final int index;

  DateSelectStartCheckState({required this.startDateBean, required this.index});

  @override
  List<Object?> get props => [startDateBean.id, index];
}

class DateSelectEndCheckState extends DateSelectState {
  final DateBean endDateBean;
  final int index;

  DateSelectEndCheckState({required this.endDateBean, required this.index});

  @override
  List<Object?> get props => [endDateBean.id, index];
}
