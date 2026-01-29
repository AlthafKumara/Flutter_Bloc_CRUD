import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/api/api_url.dart';
import '../../../../core/errors/exception.dart';
import '../../domain/entities/profile_entity.dart';
import '../models/profile_model.dart';

sealed class ProfileRemoteDatasource {
  Future<ProfileEntity> getProfile();
}

class ProfileRemoteDatasourceImpl implements ProfileRemoteDatasource {
  @override
  Future<ProfileEntity> getProfile() async {
    try {
      final user = ApiUrl.auth.currentUser;
      final id = user?.id;

      if (id == null) {
        throw Exception('User not found');
      }

      final response = await ApiUrl.profile.select().eq('id', id).single();

      return ProfileModel.fromJson(response);
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
