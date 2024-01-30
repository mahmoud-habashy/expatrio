import 'package:coding_challenge/logic/cubit/auth_cubit/auth_cubit.dart';
import 'package:coding_challenge/presentation/widgets/tax_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:coding_challenge/shared/app_assets.dart';
import 'package:coding_challenge/shared/app_colors.dart';
import 'package:coding_challenge/shared/app_constants.dart';
import 'package:coding_challenge/shared/app_strings.dart';
import 'package:coding_challenge/data/models/auth_model.dart';
import 'package:coding_challenge/logic/cubit/user_cubit/user_cubit.dart';
import 'package:coding_challenge/presentation/screens/error_screen.dart';
import 'package:coding_challenge/presentation/widgets/bottom_modal.dart';
import 'package:coding_challenge/presentation/widgets/primary_button.dart';

/// Dashboard Screen.
/// This page could be opened:
/// if user logged in with valid credentials.
/// if user opens the app and the device has a valid token.
///
/// NOTE: the logout button in the [AppBar] for testing the logout.
///

class DashboardScreen extends StatefulWidget {
  /// The [authModel] is required argument to get the userId and his email.
  ///
  final AuthModel authModel;
  const DashboardScreen({super.key, required this.authModel});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  AuthModel get _authModel => widget.authModel;

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

// Call the API to get the user data by userId.
  void _getUserData() =>
      context.read<UserCubit>().getUserById(userId: _authModel.userId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: AppColors.shadowColor,
        elevation: AppConstants.appBarElevation,
        title: const Text(AppStrings.dashboardAppBarTitle),
        centerTitle: true,
        actions: [
          // NOTE: This Button For Test the logout.
          IconButton(
              onPressed: () => AuthCubit.logout(),
              icon: const Icon(Icons.logout, color: AppColors.accent))
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<UserCubit, UserState>(
            builder: (BuildContext context, UserState state) {
          if (state is UserFetchLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }
          if (state is UserFetchError) {
            return ErrorScreen(
              title: AppStrings.dashboardErrorTitle,
              subtitle: state.errorMessage ?? AppStrings.dashboardErrorSubtitle,
              buttonText: AppStrings.dashboardErrorBtnText,
              onRefresh: _getUserData,
            );
          }
          if (state is UserFetchSuccess) {
            return Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      AppAssets.errorImage,
                      height: AppConstants.containerElement * 23,
                      width: AppConstants.containerElement * 18,
                    ),
                    Text(AppStrings.dashboardNeedTaxDataTitle,
                        style: Theme.of(context).textTheme.displayLarge),
                    const SizedBox(height: AppConstants.containerElement),
                    SizedBox(
                      width: AppConstants.containerElement * 21,
                      child: Text(
                        AppStrings.dashboardNeedTaxDataSubtitle,
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          top: AppConstants.marginElement * 5),
                      width: AppConstants.containerElement * 20,
                      child: PrimaryButton(
                          text: AppStrings.dashboardUpdateTaxDataBtnText,
                          onPressed: () {
                            openBottomSheet(
                                context: context,
                                content: TaxData(userId: state.userModel.id));
                          }),
                    ),
                  ],
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        }),
      ),
    );
  }
}
