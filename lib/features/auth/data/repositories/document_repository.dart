import 'package:fpdart/fpdart.dart';
import 'package:freelancer_visuals/core/error/exceptions.dart';
import 'package:freelancer_visuals/core/error/faliures.dart';
import 'package:freelancer_visuals/features/auth/data/datasources/document_datasource.dart';
import 'package:freelancer_visuals/features/auth/domain/entities/document.dart';
import 'package:freelancer_visuals/features/auth/domain/repository/document_repository.dart';

class DocumentRepositoryImpl implements DocumentRepository {
  final DocumentDatasource documentDatasource;

  const DocumentRepositoryImpl(this.documentDatasource);

  @override
  Future<Either<Failure, Document>> loadDocument({
    required String title,
    required String assetPath,
  }) async {
    try {
      final text = await documentDatasource.loadDocument(
        title: title,
        assetPath: assetPath,
      );
      return right(Document(title: title, content: text));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
