import 'package:coding_challenge/shared/app_assets.dart';
import 'package:coding_challenge/shared/app_colors.dart';
import 'package:coding_challenge/shared/app_constants.dart';
import 'package:coding_challenge/logic/cubit/auth_cubit/auth_cubit.dart';
import 'package:coding_challenge/util/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The Splash Screen.
/// When the user opens the app this is the initial page.
///
/// We have three scenarios:
///
/// First:
/// User opens the app for first time or the user already opened the app and click on logout button.
/// the app will not find any token data stored on the device, then the app will redirect the user to [LoginScreen].
/// the email and password fields both will be empty.
///
/// Second:
/// User opens the app and the app will get the token data from the device if the token is valid
/// (check if DateTime.now() is before the token expire date) then the app will redirect the user to [DashboardScreen].
///
/// Third:
/// User opens the app and the app will get the token data from the device if the token is invalid
/// (check if DateTime.now() is after the token expire date) then the app will redirect the user to [LoginScreen].
/// the email filed only will be filled with the user email.
///
/// Note: if the token became invalid while using the app, any request to server with invalid token
/// the server will response with 401 status code then the app will delete the stored token data
/// and redirect the user to [LoginScreen].
/// the email filed only will be filled with the user email.
///
/// Note: if user clicks on logout button, the app will delete the all user data from the device
/// then the app will redirect the user to [LoginScreen]
/// the email and password fields both will be empty.
///
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().getStoredUserDataAndCheckTokenValidation();
  }

  void _navigateToNextScreen(String route, dynamic arguments) {
    if (context.mounted) {
      Future.delayed(
          const Duration(seconds: AppConstants.splashScreenDurationInSeconds),
          () => Navigator.of(context)
              .pushReplacementNamed(route, arguments: arguments));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthValidToken) {
            _navigateToNextScreen(AppRoutes.dashboardScreen, state.authModel);
          } else if (state is AuthInvalidToken) {
            _navigateToNextScreen(AppRoutes.loginScreen, state.authModel);
          } else {
            _navigateToNextScreen(AppRoutes.loginScreen, null);
          }
        },
        child: Center(
          child: Image.asset(
            AppAssets.expatrioLogo,
            height: AppConstants.containerElement * 6,
            width: double.infinity,
          ),
        ),
      ),
    );
  }
}
