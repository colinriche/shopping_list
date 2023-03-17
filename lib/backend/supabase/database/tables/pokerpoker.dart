import '../database.dart';

class PokerpokerTable extends SupabaseTable<PokerpokerRow> {
  @override
  String get tableName => 'pokerpoker';

  @override
  PokerpokerRow createRow(Map<String, dynamic> data) => PokerpokerRow(data);
}

class PokerpokerRow extends SupabaseDataRow {
  PokerpokerRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => PokerpokerTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  String? get pokerurl => getField<String>('pokerurl');
  set pokerurl(String? value) => setField<String>('pokerurl', value);

  String? get url2 => getField<String>('url2');
  set url2(String? value) => setField<String>('url2', value);

  String? get sometext => getField<String>('sometext');
  set sometext(String? value) => setField<String>('sometext', value);

  String? get question => getField<String>('question');
  set question(String? value) => setField<String>('question', value);

  String? get shoppingName => getField<String>('shopping_name');
  set shoppingName(String? value) => setField<String>('shopping_name', value);

  bool? get foodSelect => getField<bool>('food_select');
  set foodSelect(bool? value) => setField<bool>('food_select', value);
}
