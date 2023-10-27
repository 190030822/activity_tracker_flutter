part of 'theme_cubit.dart';

sealed class ThemeState extends Equatable {
  const ThemeState();

  @override
  List<Object> get props => [];
}

final class ThemeInitial extends ThemeState {
  final bool isDark;
  const ThemeInitial(this.isDark);
   @override
  List<Object> get props => [isDark];
}
