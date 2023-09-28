import 'package:equatable/equatable.dart';

abstract class DataLoadEvent extends Equatable {

  @override
  List<Object?> get props => [];

}

class DataLoadInitialEvent extends DataLoadEvent {

  @override
  List<Object?> get props => [];

}

class DataLoadLoadEvent extends DataLoadEvent {

  final dynamic data ;

  DataLoadLoadEvent({required this.data});

  @override
  List<Object?> get props => [data];

}