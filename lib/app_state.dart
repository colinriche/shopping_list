import 'package:flutter/material.dart';
import 'backend/supabase/supabase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static final FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal() {
    initializePersistedState();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  int _idx = 2;
  int get idx => _idx;
  set idx(int _value) {
    _idx = _value;
  }

  List<int> _idr = [3, 5, 7, 9];
  List<int> get idr => _idr;
  set idr(List<int> _value) {
    _idr = _value;
  }

  void addToIdr(int _value) {
    _idr.add(_value);
  }

  void removeFromIdr(int _value) {
    _idr.remove(_value);
  }

  void removeAtIndexFromIdr(int _index) {
    _idr.removeAt(_index);
  }

  String _category = 'misc';
  String get category => _category;
  set category(String _value) {
    _category = _value;
  }

  String _shop = 'aldi';
  String get shop => _shop;
  set shop(String _value) {
    _shop = _value;
  }

  bool _pageToggle = false;
  bool get pageToggle => _pageToggle;
  set pageToggle(bool _value) {
    _pageToggle = _value;
  }
}

LatLng? _latLngFromString(String? val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}
