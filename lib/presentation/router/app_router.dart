import 'package:activity_tracker/data/models/person_model.dart';
import 'package:activity_tracker/presentation/screens/activity_details/activity_details_screen.dart';
import 'package:activity_tracker/presentation/screens/activity_details/add_activity_screen.dart';
import 'package:activity_tracker/presentation/screens/home_screen/add_person_screen.dart';
import 'package:flutter/material.dart';

import '../../core/constants/strings.dart';
import '../../core/exceptions/route_exception.dart';
import '../screens/home_screen/home_screen.dart';

class AppRouter {
  static const String home = "/";

  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(
            title: Strings.homeScreenTitle,
          ),
        );
      case "/addPerson":
        return MaterialPageRoute(
          builder: (context) => const AddNewPerson()
        );
      case "/personActivityDetails": {
        return MaterialPageRoute(
          builder: (_) => PersonActivityDetails(person: settings.arguments as Person)
        );
      }
      default:
        throw const RouteException('Route not found!');
    }
  }
}
