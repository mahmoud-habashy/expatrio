import 'package:coding_challenge/config/app_config.dart';
import 'package:coding_challenge/data/models/auth_model.dart';
import 'package:coding_challenge/presentation/screens/dashboard_screen.dart';
import 'package:coding_challenge/presentation/screens/login_screen.dart';
import 'package:coding_challenge/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';

//This is the key that identifies the navigator key used for actual
// navigation throughout the app.
final GlobalKey<NavigatorState> navigatorKey =
    LabeledGlobalKey<NavigatorState>('app');

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splashScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashScreen());

      case AppRoutes.loginScreen:
        AuthModel? authModel = settings.arguments as AuthModel?;
        return MaterialPageRoute(
            builder: (BuildContext context) =>
                LoginScreen(authModel: authModel));

      case AppRoutes.dashboardScreen:
        AuthModel authModel = settings.arguments as AuthModel;
        return MaterialPageRoute(
            builder: (BuildContext context) => DashboardScreen(
                  authModel: authModel,
                ));
    }
    return null;
  }
}
