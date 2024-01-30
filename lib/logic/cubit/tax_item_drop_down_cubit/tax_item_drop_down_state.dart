part of 'tax_item_drop_down_cubit.dart';

final class TaxItemDropDownState extends Equatable {
  final List<ItemDropDown> items;
  const TaxItemDropDownState(this.items);

  @override
  List<Object?> get props => [items];
}
