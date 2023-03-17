import 'package:supabase_flutter/supabase_flutter.dart' hide Provider;

export 'database/database.dart';

const _kSupabaseUrl = 'https://uuqahzyoaaulvmyomppn.supabase.co';
const _kSupabaseAnonKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InV1cWFoenlvYWF1bHZteW9tcHBuIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzIwNjkzNzYsImV4cCI6MTk4NzY0NTM3Nn0.1O3M8Mr4wy6yKV8qztsOpc77uOEu313lqaUs3ddGvho';

class SupaFlow {
  SupaFlow._();

  static SupaFlow? _instance;
  static SupaFlow get instance => _instance ??= SupaFlow._();

  final _supabase = Supabase.instance.client;
  static SupabaseClient get client => instance._supabase;

  static Future initialize() => Supabase.initialize(
        url: _kSupabaseUrl,
        anonKey: _kSupabaseAnonKey,
      );
}
