import 'package:coding_challenge/presentation/widgets/custom_label.dart';
import 'package:coding_challenge/shared/app_colors.dart';
import 'package:coding_challenge/shared/app_constants.dart';
import 'package:coding_challenge/shared/app_strings.dart';
import 'package:flutter/material.dart';

enum LoginEntryType { email, password }

/// A customized Widget for login data entry.
/// it can be used for inputting data for email or password depends on [LoginEntryType]
/// case email:
/// it has suffix button to clear input field and the textInputAction is next.
/// case password:
/// it has suffix button to show or hide the password and the textInputAction is done.
///
class LoginEntryField extends StatefulWidget {
  /// The [entryType] is required argument to render password input field or email input field.
  /// [textEditingController] is required argument for the input field.
  /// [inputFocusNode] is required argument for the input field.
  /// [hintText] is required argument for the input field hint text.
  /// [validator] is required argument for input field validation.
  /// [nextInputFocusNode] is optional argument. when user clicks on next in keyboard it request a focus node for next input field.
  /// [onFormSubmit] is optional argument. when user clicks on done in keyboard it submit the form.(optional if the input field is email) AND (required if the input field is password).
  ///
  final LoginEntryType entryType;
  final TextEditingController textEditingController;
  final FocusNode inputFocusNode;
  final String hintText;
  final String? Function(String?) validator;
  final FocusNode? nextInputFocusNode;
  final VoidCallback? onFormSubmit;
  const LoginEntryField(
      {super.key,
      required this.entryType,
      required this.textEditingController,
      required this.inputFocusNode,
      required this.hintText,
      required this.validator,
      this.nextInputFocusNode,
      this.onFormSubmit});

  @override
  State<LoginEntryField> createState() => _LoginEntryFieldState();
}

class _LoginEntryFieldState extends State<LoginEntryField> {
  TextEditingController get _textEditingController =>
      widget.textEditingController;
  FocusNode get _inputFocusNode => widget.inputFocusNode;
  LoginEntryType get _entryType => widget.entryType;
  FocusNode? get _nextInputFocusNode => widget.nextInputFocusNode;
  String get _hintText => widget.hintText;
  VoidCallback? get _onFormSubmit => widget.onFormSubmit;

  bool _passwordVisible = false;

  @override
  void initState() {
    _textEditingController.addListener(_textEditingChange);
    _inputFocusNode.addListener(_textEditingChange);
    super.initState();
  }

  @override
  void dispose() {
    // Remove the listeners.
    _inputFocusNode.removeListener(() {});
    _textEditingController.removeListener(() {});
    super.dispose();
  }

  void _textEditingChange() => setState(() {});

  void _passwordSuffixOnTap() =>
      setState(() => _passwordVisible = !_passwordVisible);

  void _emailSuffixOnTap() =>
      Future.microtask(() => _textEditingController.clear());

  void _onFieldSubmitted(String value) {
    // case: email input field => request the next focus node.
    if (_onFormSubmit == null) {
      FocusScope.of(context).requestFocus(_nextInputFocusNode);
      return;
    }
    // case: password input field => submit the login form.
    _onFormSubmit!();
  }

  Widget _getSuffixIcon() {
    IconData icon = Icons.close;
    VoidCallback onPressed = _emailSuffixOnTap;

    if (_entryType == LoginEntryType.password) {
      icon = _passwordVisible ? Icons.visibility_off : Icons.visibility;
      onPressed = _passwordSuffixOnTap;
    }
    return IconButton(
        onPressed: onPressed, icon: Icon(icon, color: AppColors.primary));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin:
                const EdgeInsets.only(bottom: AppConstants.marginElement * 2),
            child: _getLabelWidget()),
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          autocorrect: false,
          obscureText:
              _entryType == LoginEntryType.password ? !_passwordVisible : false,
          textInputAction: _entryType == LoginEntryType.password
              ? TextInputAction.done
              : TextInputAction.next,
          onTapOutside: (_) {
            FocusScope.of(context).unfocus();
          },
          validator: widget.validator,
          onFieldSubmitted: _onFieldSubmitted,
          focusNode: _inputFocusNode,
          controller: _textEditingController,
          decoration: InputDecoration(
              hintText: _hintText,
              hintStyle: Theme.of(context).textTheme.bodyMedium,
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.paddingElement * 6,
                  vertical: AppConstants.defaultPadding),
              suffixIcon: _textEditingController.text.isNotEmpty
                  ? _getSuffixIcon()
                  : null,
              focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(AppConstants.radiusElement * 2)),
                  borderSide: BorderSide(
                    color: AppColors.primary,
                  )),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(AppConstants.radiusElement * 2)),
              )),
        ),
      ],
    );
  }

  Widget _getLabelWidget() {
    IconData icon = Icons.email_outlined;
    String text = AppStrings.emailEntryLabelText;
    if (_entryType == LoginEntryType.password) {
      icon = Icons.lock_outline;
      text = AppStrings.passwordEntryLabelText;
    }
    return CustomLabel(
      text: text,
      textStyle: Theme.of(context).textTheme.labelSmall!,
      icon: icon,
      iconSize: AppConstants.iconSize * 4,
    );
  }
}
