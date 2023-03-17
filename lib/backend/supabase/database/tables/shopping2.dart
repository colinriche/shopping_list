import '../database.dart';

class Shopping2Table extends SupabaseTable<Shopping2Row> {
  @override
  String get tableName => 'Shopping2';

  @override
  Shopping2Row createRow(Map<String, dynamic> data) => Shopping2Row(data);
}

class Shopping2Row extends SupabaseDataRow {
  Shopping2Row(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => Shopping2Table();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  String? get url => getField<String>('url');
  set url(String? value) => setField<String>('url', value);

  String? get info => getField<String>('info');
  set info(String? value) => setField<String>('info', value);

  bool? get select => getField<bool>('select');
  set select(bool? value) => setField<bool>('select', value);

  String? get foodType => getField<String>('food_type');
  set foodType(String? value) => setField<String>('food_type', value);
}
