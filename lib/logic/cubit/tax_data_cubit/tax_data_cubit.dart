import 'package:coding_challenge/data/models/tax_data_model.dart';
import 'package:coding_challenge/presentation/widgets/tax_data_entry.dart';
import 'package:coding_challenge/repositories/tax_data_repository.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tax_data_state.dart';

class TaxDataCubit extends Cubit<TaxDataState> {
  TaxDataModel? _taxDataModel;
  TaxDataCubit() : super(TaxDataInitial());

  Future<void> getTaxDataByUserId({required int userId}) async {
    emit(TaxDataFetchLoading());
    try {
      TaxDataModel? result =
          await TaxDataRepository.getTaxDataByUserId(userId: userId);
      if (result != null) {
        _taxDataModel = result;
        emit(TaxDataFetchSuccess(taxDataModel: result));
      } else {
        emit(TaxDataFetchError());
      }
    } catch (err) {
      emit(TaxDataFetchError(errorMessage: err.toString()));
    }
  }

  Future<void> updateTaxDataByUserId({required int userId}) async {
    emit(TaxDataFetchLoading());
    try {
      await TaxDataRepository.updateTaxDataByUserId(
          userId: userId, taxDataModel: _taxDataModel!);

      emit(TaxDataUpdateSuccess());
    } catch (err) {
      emit(TaxDataFetchError(errorMessage: err.toString()));
    }
  }

  void addNewTaxData(Tax tax) {
    if (_taxDataModel != null) {
      _taxDataModel!.secondaryTaxResidence.add(tax);
      emit(TaxDataFetchSuccess(taxDataModel: _taxDataModel!));
    }
  }

  void removeTaxData(int index) {
    if (_taxDataModel != null) {
      _taxDataModel!.secondaryTaxResidence.removeAt(index);
      emit(TaxDataFetchSuccess(taxDataModel: _taxDataModel!));
    }
  }

  void editTaxData(
      {int? index, required taxEntryFieldType, required String value}) {
    if (_taxDataModel != null) {
      Tax record = index != null
          ? _taxDataModel!.secondaryTaxResidence[index]
          : _taxDataModel!.primaryTaxResidence;
      if (taxEntryFieldType == TaxEntryFieldType.id) {
        record.id = value;
      } else {
        record.country = value;
      }
      emit(TaxDataFetchSuccess(taxDataModel: _taxDataModel!));
    }
  }
}
