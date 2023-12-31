import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {

  ThemeCubit() : super(const ThemeInitial(false));

  void onToggle() {
    if (state.runtimeType == ThemeInitial) {
      ThemeInitial themeState  = state as ThemeInitial;
      emit(ThemeInitial(!themeState.isDark));
    }
  }

}
