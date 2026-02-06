// lib/core/supabase/supabase_client.dart
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static const supabaseUrl = 'https://rptbjddgtomakhhttkkk.supabase.co';
  static const anonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJwdGJqZGRndG9tYWtoaHR0a2trIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU4Mzg2MzgsImV4cCI6MjA4MTQxNDYzOH0.9y1hPfGmbFmMVNRTDCSfCr0RbCFxTuZaXFzBQlZrd6A';
}

Future<void> initSupabase() async {
  await Supabase.initialize(
    url: SupabaseConfig.supabaseUrl,
    anonKey: SupabaseConfig.anonKey,
  );
}

SupabaseClient get supabase => Supabase.instance.client;
