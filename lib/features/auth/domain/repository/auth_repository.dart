import 'package:fpdart/fpdart.dart';
import 'package:freelancer_visuals/core/error/faliures.dart';
import 'package:freelancer_visuals/core/common/entities/user.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  });
  Future<Either<Failure, User>> handleGoogleAuth();
  Future<Either<Failure, User>> currentUser();

  Future<Either<Failure, double>> getTotalEarningsForMonth({
    required String userId,
    required int month,
    required int year,
  });

  Future<Either<Failure, void>> signOut();
}
