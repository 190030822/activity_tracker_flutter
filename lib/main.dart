import 'package:activity_tracker/core/firebase_service/firebase_options.dart';
import 'package:activity_tracker/data/data_providers/activity_data_provider.dart';
import 'package:activity_tracker/data/data_providers/person_data_provider.dart';
import 'package:activity_tracker/data/repositories/activity_repository.dart';
import 'package:activity_tracker/data/repositories/auth_repository.dart';
import 'package:activity_tracker/data/repositories/person_repository.dart';
import 'package:activity_tracker/logic/bloc/activity_bloc/activity_bloc.dart';
import 'package:activity_tracker/logic/bloc/authenticate_bloc/authenticate_bloc.dart';
import 'package:activity_tracker/logic/bloc/person_bloc/person_bloc.dart';
import 'package:activity_tracker/logic/cubit/theme_cubit/theme_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'core/constants/strings.dart';
import 'logic/debug/app_bloc_observer.dart';
import 'presentation/router/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        Provider<PersonRepository>(
            create: (context) => PersonRepository(personData: PersonData())),
        Provider<ActivityRepository>(
            create: (context) =>
                ActivityRepository(activityData: ActivityData())),
        Provider<AuthRepository>(
            create: (context) => AuthRepository(FirebaseAuth.instance))
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<PersonBloc>(
            create: (context) => PersonBloc(context.read<PersonRepository>()),
          ),
          BlocProvider<ActivityBloc>(
              create: (context) => ActivityBloc(
                  activityRepository: context.read<ActivityRepository>())),
          BlocProvider<AuthenticateBloc>(
              create: (context) =>
                  AuthenticateBloc(context.read<AuthRepository>())),
          BlocProvider<ThemeCubit>(
            create: (context) => ThemeCubit())
        ],
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            if (state.runtimeType == ThemeInitial) {
              ThemeInitial themeinitialState = state as ThemeInitial;
              return MaterialApp(
                title: Strings.appTitle,
                themeMode: themeinitialState.isDark ? ThemeMode.dark : ThemeMode.light,
                darkTheme: FlexColorScheme.dark(scheme: FlexScheme.red).toTheme,
                theme: FlexColorScheme.light(scheme: FlexScheme.red).toTheme,
                debugShowCheckedModeBanner: false,
                initialRoute: AppRouter.home,
                onGenerateRoute: AppRouter.onGenerateRoute,
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
