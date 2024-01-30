import 'package:coding_challenge/shared/app_strings.dart';
import 'package:coding_challenge/shared/app_theme.dart';
import 'package:coding_challenge/logic/cubit/auth_cubit/auth_cubit.dart';
import 'package:coding_challenge/logic/cubit/tax_data_cubit/tax_data_cubit.dart';
import 'package:coding_challenge/logic/cubit/tax_item_drop_down_cubit/tax_item_drop_down_cubit.dart';
import 'package:coding_challenge/logic/cubit/user_cubit/user_cubit.dart';
import 'package:coding_challenge/util/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(ExpatrioApp(
    appRouter: AppRouter(),
  ));
}

class ExpatrioApp extends StatelessWidget {
  final AppRouter appRouter;
  const ExpatrioApp({super.key, required this.appRouter});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (BuildContext context) => AuthCubit()),
        BlocProvider<UserCubit>(create: (BuildContext context) => UserCubit()),
        BlocProvider<TaxDataCubit>(
            create: (BuildContext context) => TaxDataCubit()),
        BlocProvider<TaxItemDropDownCubit>(
            create: (BuildContext context) => TaxItemDropDownCubit()),
      ],
      child: Builder(builder: (context) {
        return MaterialApp(
          title: AppStrings.appTitle,
          theme: expatrioThemeData,
          initialRoute: AppRoutes.splashScreen,
          navigatorKey: navigatorKey,
          onGenerateRoute: appRouter.generateRoute,
        );
      }),
    );
  }
}
