import 'package:activity_tracker/data/data_providers/activity_data_provider.dart';
import 'package:activity_tracker/data/data_providers/person_data_provider.dart';
import 'package:activity_tracker/data/repositories/activity_repository.dart';
import 'package:activity_tracker/data/repositories/person_repository.dart';
import 'package:activity_tracker/logic/bloc/activity_bloc/activity_bloc.dart';
import 'package:activity_tracker/logic/bloc/person_bloc/person_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'core/constants/strings.dart';
import 'core/themes/app_theme.dart';
import 'logic/debug/app_bloc_observer.dart';
import 'presentation/router/app_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
          create: (context) => PersonRepository(personData: PersonData())
        ),
        Provider<ActivityRepository>(
          create: (context) => ActivityRepository(activityData: ActivityData())
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<PersonBloc>(
            create: (context) => PersonBloc(context.read<PersonRepository>()),
          ),
          BlocProvider<ActivityBloc>(create: (context) => ActivityBloc(activityRepository : context.read<ActivityRepository>())),
        ],
        child: MaterialApp(
          title: Strings.appTitle,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          debugShowCheckedModeBanner: false,
          initialRoute: AppRouter.home,
          onGenerateRoute: AppRouter.onGenerateRoute,
        ),
      ),
    );
  }
}
