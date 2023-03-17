import '../database.dart';

class ShoppingTable extends SupabaseTable<ShoppingRow> {
  @override
  String get tableName => 'Shopping';

  @override
  ShoppingRow createRow(Map<String, dynamic> data) => ShoppingRow(data);
}

class ShoppingRow extends SupabaseDataRow {
  ShoppingRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ShoppingTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  String? get photoUrl => getField<String>('photo_url');
  set photoUrl(String? value) => setField<String>('photo_url', value);

  String? get shoppingName => getField<String>('shopping_name');
  set shoppingName(String? value) => setField<String>('shopping_name', value);

  bool? get foodSelect => getField<bool>('food_select');
  set foodSelect(bool? value) => setField<bool>('food_select', value);

  String? get category => getField<String>('category');
  set category(String? value) => setField<String>('category', value);

  String? get shop => getField<String>('shop');
  set shop(String? value) => setField<String>('shop', value);
}
