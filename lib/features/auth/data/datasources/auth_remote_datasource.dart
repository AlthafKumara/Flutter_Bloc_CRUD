import '../../../../core/api/api_url.dart';
import '../models/login_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

sealed class AuthRemoteDatasource {
  Future<void> login(LoginModel model);
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  @override
  Future<void> login(LoginModel model) async {
    try {
      await ApiUrl.auth.signInWithPassword(
        password: model.password,
        email: model.email,
      );
    } on PostgrestException catch (_) {
      throw AuthException("Email atau password salah");
    } catch (e) {
      throw AuthException(e.toString());
    }
  }
}
