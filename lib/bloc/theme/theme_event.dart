part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  final AppTheme appTheme;
  ThemeEvent({this.appTheme});
  @override
  // TODO: implement props
  List<Object> get props => [];
}
