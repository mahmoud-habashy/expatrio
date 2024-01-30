import 'package:coding_challenge/config/app_config.dart';
import 'package:coding_challenge/presentation/widgets/action_result.dart';
import 'package:coding_challenge/shared/app_assets.dart';
import 'package:coding_challenge/shared/app_colors.dart';
import 'package:coding_challenge/shared/app_constants.dart';
import 'package:coding_challenge/shared/app_strings.dart';
import 'package:coding_challenge/data/models/auth_model.dart';
import 'package:coding_challenge/logic/cubit/auth_cubit/auth_cubit.dart';
import 'package:coding_challenge/presentation/widgets/bottom_modal.dart';
import 'package:coding_challenge/presentation/widgets/chip_button.dart';
import 'package:coding_challenge/presentation/widgets/login_entry_field.dart';
import 'package:coding_challenge/presentation/widgets/primary_button.dart';
import 'package:coding_challenge/util/app_router.dart';
import 'package:coding_challenge/util/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

/// Login Screen;
/// This page could be opened:
///  1. User opens the app for first time.
///  2. The device has a invalid token.
///  3. The device does not have token data.
///

class LoginScreen extends StatefulWidget {
  /// [authModel] is optional argument, if you provide it email filed only will be filled with the user email.
  /// if [authModel] is null email and password fields both will be empty.
  ///
  /// NOTE: For Testing in the initState method i override the email and password.
  /// email: "tito+bs792@expatrio.com"
  /// password: "nemampojma"
  ///
  final AuthModel? authModel;
  const LoginScreen({super.key, this.authModel});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();

  final FocusNode _emailInputFocusNode = FocusNode();
  final FocusNode _passwordInputFocusNode = FocusNode();

  AuthModel? get _authModel => widget.authModel;

  @override
  void initState() {
    super.initState();

    if (_authModel != null && _authModel!.subject != null) {
      _emailTextEditingController.text = _authModel!.subject!.email;
    } else {
      // TODO(Mahmoud) else block should be removed after testing.
      // NOTE: This else block only for testing to add the default email and password.
      _emailTextEditingController.text = "tito+bs792@expatrio.com";
      _passwordTextEditingController.text = "nemampojma";
      //
    }
  }

  @override
  void dispose() {
    // Clean up the controllers and focus nodes.
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    _emailInputFocusNode.dispose();
    _passwordInputFocusNode.dispose();
    super.dispose();
  }

  void _onFormSubmit() async {
    if (_formKey.currentState!.validate()) {
      String email = _emailTextEditingController.text;
      String password = _passwordTextEditingController.text;
      await context.read<AuthCubit>().login(email: email, password: password);
    }
  }

  void _navigateToDashboard(AuthModel authModel) {
    // Duration to give the bottom modal sheet time to dismiss.
    Future.delayed(
        const Duration(milliseconds: AppConstants.animationDuration * 2), () {
      Navigator.of(context).pushReplacementNamed(AppRoutes.dashboardScreen,
          arguments: authModel);
    });
  }

  // Open the Expatrio website when user clicks on help chip button.
  void _openWebsite() async {
    final Uri uri = Uri.parse(AppConfig.fAQsWebsiteUrl);
    if (await canLaunchUrl(uri)) {
      launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoadingState) {
            showSnackBarMessage(
                context: context, message: AppStrings.loginSnackBarMessage);
          } else if (state is AuthErrorState) {
            openBottomSheet(
                context: context,
                content: ActionResult(
                  lottieAsset: AppAssets.errorAnimation,
                  repeatAnimation: true,
                  title: AppStrings.loginFaildTitle,
                  subtitle: state.errorMessage ?? AppStrings.loginFaildSubtitle,
                  primaryBtnText: AppStrings.loginBottomModalsBtnText,
                  onPrimaryBtnPressed: () => Navigator.of(context).pop(),
                ));
          } else if (state is AuthSuccessfulState) {
            openBottomSheet(
                context: context,
                content: ActionResult(
                  lottieAsset: AppAssets.successAnimation,
                  repeatAnimation: false,
                  title: AppStrings.loginSuccessTitle,
                  subtitle: AppStrings.loginSuccessSubtitle,
                  primaryBtnText: AppStrings.loginBottomModalsBtnText,
                  onPrimaryBtnPressed: () => Navigator.of(context).pop(),
                )).whenComplete(
              () => _navigateToDashboard(state.authModel),
            );
          }
        },
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Lottie.asset(AppAssets.loginBackgroundAnimation,
                  repeat: true),
            ),
            Container(
              color: AppColors.white.withOpacity(0.6),
            ),
            SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.defaultPadding * 4),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              top: AppConstants.defaultMargin,
                              bottom: AppConstants.marginElement * 6),
                          child: Image.asset(
                            AppAssets.expatrioLogo,
                            height: AppConstants.containerElement * 5,
                            width: double.infinity,
                          ),
                        ),
                        LoginEntryField(
                          entryType: LoginEntryType.email,
                          validator: AppValidators.isValidEmail,
                          inputFocusNode: _emailInputFocusNode,
                          nextInputFocusNode: _passwordInputFocusNode,
                          textEditingController: _emailTextEditingController,
                          hintText: AppStrings.emailEntryHintText,
                        ),
                        const SizedBox(
                            height: AppConstants.containerElement * 2),
                        LoginEntryField(
                          entryType: LoginEntryType.password,
                          validator: AppValidators.isValidPassword,
                          inputFocusNode: _passwordInputFocusNode,
                          textEditingController: _passwordTextEditingController,
                          hintText: AppStrings.passwordEntryHintText,
                          onFormSubmit: _onFormSubmit,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: AppConstants.defaultPadding),
                          child: PrimaryButton(
                            onPressed: _onFormSubmit,
                            text: AppStrings.loginBtnText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
                bottom: MediaQuery.of(context).padding.bottom,
                child: Container(
                  margin: const EdgeInsets.only(
                      bottom: AppConstants.marginElement * 5,
                      left: AppConstants.defaultMargin),
                  child: ChipButton(
                      icon: Icons.question_mark_rounded,
                      text: AppStrings.loginScreenHelpBtnText,
                      onTap: _openWebsite),
                )),
          ],
        ),
      ),
    );
  }
}
