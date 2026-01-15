import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/profile_entity.dart';
import '../repositories/profile_repository.dart';

class GetProfileUsecase implements UseCase<ProfileEntity, NoParams> {
  final ProfileRepository _repository;
  const GetProfileUsecase(this._repository);
  @override
  Future<Either<Failure, ProfileEntity>> call(NoParams params) async {
    return await _repository.getProfile();
  }
}
