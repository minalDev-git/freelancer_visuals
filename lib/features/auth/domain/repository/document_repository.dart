import 'package:fpdart/fpdart.dart';
import 'package:freelancer_visuals/core/error/faliures.dart';
import 'package:freelancer_visuals/features/auth/domain/entities/document.dart';

abstract interface class DocumentRepository {
  Future<Either<Failure, Document>> loadDocument({
    required String title,
    required String assetPath,
  });
}
