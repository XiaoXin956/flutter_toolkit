part of 'root_cubit.dart';

abstract class RootState extends Equatable {
  const RootState();
  @override
  List<Object> get props => [];
}

class RootInitial extends RootState {
}

class RootChangeThemeDataState extends RootState {
  final ThemeData themeData;

  RootChangeThemeDataState({required this.themeData});

  @override
  List<Object> get props => [themeData];
}

