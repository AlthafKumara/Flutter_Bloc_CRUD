import '../../../../core/cache/local_storage.dart';
import '../../../../core/errors/exception.dart';
import '../models/profile_model.dart';
import '../../domain/entities/profile_entity.dart';

sealed class ProfileLocalDatasource {
  Future<ProfileEntity?> getProfile();
}

class ProfileLocalDataSourceImpl extends ProfileLocalDatasource {
  final LocalStorage localStorage;

  ProfileLocalDataSourceImpl(this.localStorage);
  @override
  Future<ProfileEntity?> getProfile() => _getProfileFromCache();

  Future<ProfileEntity?> _getProfileFromCache() async {
    try {
      final response = await localStorage.load(key: "profile", boxName: "user");

      if (response == null) return null;

      return response as ProfileModel;
    } on CacheException catch (e) {
      throw CacheException(e.message);
    } catch (e) {
      throw CacheException(e.toString());
    }
  }
}
