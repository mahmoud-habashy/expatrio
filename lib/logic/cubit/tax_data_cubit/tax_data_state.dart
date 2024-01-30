part of 'tax_data_cubit.dart';

@immutable
sealed class TaxDataState {}

final class TaxDataInitial extends TaxDataState {}

class TaxDataFetchError extends TaxDataState {
  final String? errorMessage;
  TaxDataFetchError({this.errorMessage});
}

class TaxDataFetchLoading extends TaxDataState {}

class TaxDataFetchSuccess extends TaxDataState {
  final TaxDataModel taxDataModel;
  TaxDataFetchSuccess({required this.taxDataModel});
}

class TaxDataUpdateSuccess extends TaxDataState {}

class TaxDataUpdateError extends TaxDataState {
  final String? errorMessage;
  TaxDataUpdateError({this.errorMessage});
}
