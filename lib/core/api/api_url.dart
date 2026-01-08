import 'package:supabase_flutter/supabase_flutter.dart';

abstract class SupabaseHelper {
  static SupabaseClient get client => Supabase.instance.client;
}

class ApiUrl {
  ApiUrl._();

  static final book = SupabaseHelper.client.from("book");

  static final bookStorage = SupabaseHelper.client.storage.from("book_cover");

  static final auth = SupabaseHelper.client.auth;
}
