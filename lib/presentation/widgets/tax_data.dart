import 'package:coding_challenge/presentation/widgets/custom_checkbox.dart';
import 'package:coding_challenge/presentation/widgets/action_result.dart';
import 'package:coding_challenge/shared/app_assets.dart';
import 'package:coding_challenge/shared/app_colors.dart';
import 'package:coding_challenge/shared/app_constants.dart';
import 'package:coding_challenge/data/models/tax_data_model.dart';
import 'package:coding_challenge/logic/cubit/tax_data_cubit/tax_data_cubit.dart';
import 'package:coding_challenge/logic/cubit/tax_item_drop_down_cubit/tax_item_drop_down_cubit.dart';
import 'package:coding_challenge/presentation/screens/error_screen.dart';
import 'package:coding_challenge/presentation/widgets/primary_button.dart';
import 'package:coding_challenge/presentation/widgets/secondary_button.dart';
import 'package:coding_challenge/presentation/widgets/tax_data_entry.dart';
import 'package:coding_challenge/shared/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Widget that supports displaying a column of [TaxEntryField].
/// It has secondary button to add new tax data entry and checkbox for verifying the accuracy of the tax information
/// before being able to submit it.
/// it also has primary button for submit the tax data if the user checked the checkbox.
///

class TaxData extends StatefulWidget {
  /// [userId] is required argument to call the API for fetching the tax data by user id.
  ///
  final int userId;
  const TaxData({super.key, required this.userId});

  @override
  State<TaxData> createState() => _TaxDataState();
}

class _TaxDataState extends State<TaxData> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int get _userId => widget.userId;

  bool _isConfirmed = false;
  bool _saveButtonClicked = false;
  bool _updateTaxDataSuccess = false;

  @override
  void initState() {
    super.initState();
    _getTaxData();
  }

  void _getTaxData() =>
      context.read<TaxDataCubit>().getTaxDataByUserId(userId: _userId);

  void _addNewTaxDataEntry() =>
      context.read<TaxDataCubit>().addNewTaxData(Tax(country: '', id: ''));

  void _removeTaxDataEntry(int index) =>
      context.read<TaxDataCubit>().removeTaxData(index);

  void _onFormSubmit() async {
    setState(() => _saveButtonClicked = true);
    if (_formKey.currentState!.validate() && _isConfirmed) {
      await context.read<TaxDataCubit>().updateTaxDataByUserId(userId: _userId);
      setState(() => _saveButtonClicked = false);
    }
  }

  void _onUpdateTaxDataSuccess() {
    setState(() => _updateTaxDataSuccess = true);
    Future.delayed(
        const Duration(milliseconds: AppConstants.animationDuration * 15), () {
      if (mounted) {
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _updateTaxDataSuccess
        ? const ActionResult(
            lottieAsset: AppAssets.successAnimation,
            title: AppStrings.taxDataUpdatedTitle,
            subtitle: AppStrings.taxDataUpdatedSubtitle,
          )
        : BlocConsumer<TaxDataCubit, TaxDataState>(
            listener: (context, state) {
              if (state is TaxDataFetchSuccess) {
                context.read<TaxItemDropDownCubit>().filterDropDownItems(
                    state.taxDataModel.primaryTaxResidence,
                    state.taxDataModel.secondaryTaxResidence);
              } else if (state is TaxDataUpdateSuccess) {
                _onUpdateTaxDataSuccess();
              }
            },
            builder: (context, state) {
              if (state is TaxDataFetchLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                );
              }
              if (state is TaxDataFetchError) {
                return ErrorScreen(
                  title: AppStrings.taxDataModalErrorTitle,
                  subtitle: state.errorMessage ??
                      AppStrings.taxDataModalErrorSubtitle,
                  buttonText: AppStrings.taxDataModalErrorBtnText,
                  onRefresh: _getTaxData,
                );
              }
              if (state is TaxDataFetchSuccess) {
                return Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                          vertical: AppConstants.defaultPadding * 2,
                          horizontal: AppConstants.paddingElement * 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                bottom: AppConstants.marginElement,
                                top: AppConstants.marginElement * 5),
                            child: Text(AppStrings.taxDataModalTitle,
                                style: Theme.of(context).textTheme.titleLarge),
                          ),
                          // Primary Tax Residence
                          TaxEntryField(
                            key: ObjectKey(
                                state.taxDataModel.primaryTaxResidence),
                            tax: state.taxDataModel.primaryTaxResidence,
                          ),
                          //
                          // Secondary Tax Residences.
                          for (int index = 0;
                              index <
                                  state.taxDataModel.secondaryTaxResidence
                                      .length;
                              index++)
                            TaxEntryField(
                                key: ObjectKey(state
                                    .taxDataModel.secondaryTaxResidence[index]),
                                tax: state
                                    .taxDataModel.secondaryTaxResidence[index],
                                index: index,
                                onRemove: _removeTaxDataEntry),
                          //
                          Container(
                            alignment: Alignment.bottomLeft,
                            margin: const EdgeInsets.only(
                                top: AppConstants.marginElement * 2,
                                bottom: AppConstants.defaultMargin * 2),
                            child: SecondaryButton(
                              text: AppStrings.addMoreTaxEntryBtnText,
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w700),
                              icon: Icons.add,
                              iconColor: AppColors.primary,
                              iconSize: AppConstants.iconSize * 4,
                              onPressed: _addNewTaxDataEntry,
                            ),
                          ),
                          CustomCheckbox(
                              text: AppStrings
                                  .taxDataModalCheckBoxConfirmationText,
                              checkBoxBorderColor:
                                  (_saveButtonClicked && !_isConfirmed)
                                      ? AppColors.accent
                                      : AppColors.green,
                              value: _isConfirmed,
                              onChanged: (_) =>
                                  setState(() => _isConfirmed = !_isConfirmed)),
                          Container(
                            margin: const EdgeInsets.only(
                                top: AppConstants.defaultMargin * 2,
                                bottom: AppConstants.marginElement * 3),
                            width: AppConstants.containerElement * 16,
                            child: PrimaryButton(
                              text: AppStrings.saveTaxEntryBtnText,
                              onPressed: () {
                                _onFormSubmit();
                              },
                            ),
                          ),
                        ],
                      ),
                    ));
              }
              return const SizedBox.shrink();
            },
          );
  }
}
