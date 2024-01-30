import 'package:coding_challenge/data/models/item_dropdown.dart';
import 'package:coding_challenge/data/models/tax_data_model.dart';
import 'package:coding_challenge/shared/countries_constants.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tax_item_drop_down_state.dart';

class TaxItemDropDownCubit extends Cubit<TaxItemDropDownState> {
  TaxItemDropDownCubit() : super(const TaxItemDropDownState([]));

  void filterDropDownItems(
      Tax primaryTaxResidence, List<Tax> secondaryTaxResidence) {
    List<ItemDropDown> result = [];
    for (Map<String, Object> nationality in CountriesConstants.nationality) {
      if (primaryTaxResidence.country != nationality['code'] &&
          !secondaryTaxResidence
              .any((Tax tax) => tax.country == nationality['code'])) {
        result.add(ItemDropDown(
            code: nationality['code'].toString(),
            label: nationality['label'].toString()));
      }
    }
    emit(TaxItemDropDownState(result));
  }

  ItemDropDown? getSelectedDropDownItem({required String country}) {
    ItemDropDown? result;
    int countryIndex = CountriesConstants.nationality
        .indexWhere((nat) => nat['code'] == country);
    if (countryIndex > -1) {
      result = ItemDropDown(
        code: CountriesConstants.nationality[countryIndex]['code'].toString(),
        label: CountriesConstants.nationality[countryIndex]['label'].toString(),
      );
    }
    return result;
  }
}
