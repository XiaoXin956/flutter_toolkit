import 'package:equatable/equatable.dart';

abstract class DataLoadState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DataLoadInitialState extends DataLoadState {}

class DataLoadLoadingState extends DataLoadState{

}


class DataLoadSuccessState extends DataLoadState {
  final List<String> dataSuccess;

  DataLoadSuccessState({ required this.dataSuccess});

  @override
  List<Object?> get props => [dataSuccess];
}

class DataLoadFailState extends DataLoadState {
  final dynamic dataFail;

  DataLoadFailState({this.dataFail});

  @override
  List<Object?> get props => [dataFail];
}
