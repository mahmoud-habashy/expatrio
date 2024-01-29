import 'package:equatable/equatable.dart';

class ItemDropDown extends Equatable {
  const ItemDropDown({required this.code, required this.label});
  final String code;
  final String label;

  @override
  String toString() => label;

  @override
  List<Object?> get props => [code, label];
}
