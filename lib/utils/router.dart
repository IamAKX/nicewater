import 'package:flutter/material.dart';
import 'package:nice_water/screens/home_container/home_container.dart';
import 'package:nice_water/screens/onboarding/login.dart';
import 'package:nice_water/screens/onboarding/register.dart';
import 'package:nice_water/screens/onboarding/reset_password.dart';
import 'package:nice_water/screens/report_waste/create_report.dart';
import 'package:nice_water/screens/report_waste/location_picker.dart';

class NavRoute {
  static MaterialPageRoute<dynamic> generatedRoute(RouteSettings settings) {
    switch (settings.name) {
      case RegisterScreen.routePath:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case LoginScreen.routePath:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case ResetPasswordScreen.routePath:
        return MaterialPageRoute(builder: (_) => const ResetPasswordScreen());
      case LocationPicker.routePath:
        return MaterialPageRoute(builder: (_) => const LocationPicker());
      case HomeContainer.routePath:
        return MaterialPageRoute(builder: (_) => const HomeContainer());
      case CreateReport.routePath:
        return MaterialPageRoute(builder: (_) => const CreateReport());
      default:
        return errorRoute();
    }
  }
}

errorRoute() {
  return MaterialPageRoute(builder: (_) {
    return const Scaffold(
      body: Center(
        child: Text('Undefined route'),
      ),
    );
  });
}
