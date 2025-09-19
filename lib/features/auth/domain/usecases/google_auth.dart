import 'package:fpdart/fpdart.dart';
import 'package:freelancer_visuals/core/error/faliures.dart';
import 'package:freelancer_visuals/core/usecase/usecase.dart';
import 'package:freelancer_visuals/features/auth/domain/entities/user.dart';
import 'package:freelancer_visuals/features/auth/domain/repository/auth_repository.dart';

class GoogleAuth implements UseCase<User, void> {
  final AuthRepository authRepository;

  GoogleAuth(this.authRepository);
  @override
  Future<Either<Failure, User>> call([void params]) async {
    return await authRepository.handleGoogleAuth();
  }
}
