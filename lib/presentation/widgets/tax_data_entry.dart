import 'package:coding_challenge/presentation/widgets/custom_label.dart';
import 'package:coding_challenge/shared/app_colors.dart';
import 'package:coding_challenge/shared/app_constants.dart';
import 'package:coding_challenge/data/models/item_dropdown.dart';
import 'package:coding_challenge/data/models/tax_data_model.dart';
import 'package:coding_challenge/logic/cubit/tax_data_cubit/tax_data_cubit.dart';
import 'package:coding_challenge/logic/cubit/tax_item_drop_down_cubit/tax_item_drop_down_cubit.dart';
import 'package:coding_challenge/presentation/widgets/secondary_button.dart';
import 'package:coding_challenge/shared/app_strings.dart';
import 'package:coding_challenge/util/validators.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum TaxEntryFieldType { country, id }

/// A customized Widget for tax data entry it has two required input fields.
/// The first one is country input allow user to select country the user will not be able to choose a previously selected country.
/// The second one is Tax Number input allow user to enter his tax number.
/// it has secondary button to allow the user to remove specific entry.
///

class TaxEntryField extends StatefulWidget {
  /// The [tax] is required argument to access the Tax Data.
  /// [index] is optional argument.
  /// [onRemove] is optional argument. if this entry can be removed.
  /// Both [index],[onRemove] != null => indicates that this Tax Entry is not Primary tax residence and can be removed.
  ///
  final Tax tax;
  final int? index;
  final Function(int)? onRemove;

  const TaxEntryField(
      {super.key, required this.tax, this.index, this.onRemove});

  @override
  State<TaxEntryField> createState() => _TaxEntryFieldState();
}

class _TaxEntryFieldState extends State<TaxEntryField> {
  Tax get _taxDataEntry => widget.tax;
  Function(int)? get _onRemove => widget.onRemove;
  int? get _index => widget.index;
  bool get _isPrimaryTaxResidence => _onRemove == null && _index == null;

  final TextEditingController _taxController = TextEditingController();
  ItemDropDown? _selectedDropDownItem;

  @override
  void initState() {
    super.initState();
    // Get the ItemDropDown by searching for country in the CountriesConstants.
    _selectedDropDownItem = context
        .read<TaxItemDropDownCubit>()
        .getSelectedDropDownItem(country: _taxDataEntry.country);
    // Fill the taxController with the tax number.
    _taxController.text = _taxDataEntry.id;
  }

  @override
  void dispose() {
    // clean the controller.
    _taxController.dispose();
    super.dispose();
  }

  void _onEntryChanged(
      {required TaxEntryFieldType taxEntryFieldType, required String value}) {
    if (value.isNotEmpty) {
      context.read<TaxDataCubit>().editTaxData(
          index: _index, taxEntryFieldType: taxEntryFieldType, value: value);
    }
  }

  Widget _buildLabelWidget({required String text}) {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.only(left: AppConstants.paddingElement),
      margin: const EdgeInsets.only(
          bottom: AppConstants.marginElement,
          top: AppConstants.marginElement * 4),
      child: CustomLabel(
        text: text,
        textStyle: Theme.of(context).textTheme.labelMedium!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildLabelWidget(
            text: _isPrimaryTaxResidence
                ? AppStrings.taxDataModalPrimaryTitle
                : AppStrings.taxDataModalSecondaryTitle),
        BlocBuilder<TaxItemDropDownCubit, TaxItemDropDownState>(
          builder: (context, state) {
            return DropdownSearch<ItemDropDown>(
              dropdownDecoratorProps: const DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                contentPadding: EdgeInsets.all(AppConstants.paddingElement * 8),
                suffixIconColor: AppColors.lightGrey,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: AppConstants.borderElement,
                      color: AppColors.lightGrey),
                  borderRadius: BorderRadius.all(
                      Radius.circular(AppConstants.radiusElement)),
                ),
              )),
              selectedItem: _selectedDropDownItem,
              validator: AppValidators.isValidCountry,
              onChanged: (value) {
                if (value != null) {
                  _onEntryChanged(
                      taxEntryFieldType: TaxEntryFieldType.country,
                      value: value.code);
                }
              },
              items: context.watch<TaxItemDropDownCubit>().state.items,
              popupProps: PopupProps.modalBottomSheet(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.7),
                showSearchBox: true,
                title: Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppConstants.radiusElement * 5),
                      topRight: Radius.circular(AppConstants.radiusElement * 5),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: AppConstants.paddingElement * 7),
                  child: Text(AppStrings.taxDataModalCountryLabel,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: AppColors.white)),
                ),
                listViewProps: const ListViewProps(
                    padding: EdgeInsets.only(
                        bottom: AppConstants.defaultPadding * 2)),
                itemBuilder: (BuildContext context, ItemDropDown itemDropDown,
                    bool isSelected) {
                  return Padding(
                    padding:
                        const EdgeInsets.all(AppConstants.paddingElement * 10),
                    child: Text(
                      itemDropDown.label,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  );
                },
                searchFieldProps: TextFieldProps(
                  autocorrect: false,
                  decoration: InputDecoration(
                    hintText: AppStrings.taxDataModalCountryHintText,
                    hintStyle: Theme.of(context).textTheme.bodyMedium,
                    contentPadding:
                        const EdgeInsets.all(AppConstants.paddingElement * 7),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          width: AppConstants.borderElement,
                          color: AppColors.lightGrey),
                      borderRadius: BorderRadius.all(
                          Radius.circular(AppConstants.radiusElement * 2)),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.only(top: AppConstants.paddingElement * 2),
          child: _buildLabelWidget(text: AppStrings.taxDataModalTaxNumberLabel),
        ),
        TextFormField(
          autocorrect: false,
          textInputAction: TextInputAction.done,
          onChanged: (String value) {
            _onEntryChanged(
                taxEntryFieldType: TaxEntryFieldType.id, value: value.trim());
          },
          validator: AppValidators.isValidTaxId,
          controller: _taxController,
          scrollPadding: const EdgeInsets.symmetric(
              vertical: AppConstants.defaultPadding * 3),
          decoration: InputDecoration(
              hintText: AppStrings.taxDataModalTaxNumberHintText,
              hintStyle: Theme.of(context).textTheme.bodyMedium,
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.defaultPadding,
                  vertical: AppConstants.paddingElement * 7),
              focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(AppConstants.radiusElement)),
                  borderSide: BorderSide(
                    color: AppColors.primary,
                  )),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                    width: AppConstants.borderElement,
                    color: AppColors.lightGrey),
                borderRadius: BorderRadius.all(
                    Radius.circular(AppConstants.radiusElement * 2)),
              )),
        ),
        if (!_isPrimaryTaxResidence)
          Container(
            margin: const EdgeInsets.only(top: AppConstants.marginElement),
            alignment: Alignment.bottomRight,
            child: SecondaryButton(
                text: AppStrings.removeTaxEntryBtnText,
                textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppColors.accent, fontWeight: FontWeight.w700),
                icon: Icons.remove,
                iconColor: AppColors.accent,
                iconSize: AppConstants.iconSize * 2,
                onPressed: () {
                  _onRemove!(_index!);
                }),
          )
      ],
    );
  }
}
