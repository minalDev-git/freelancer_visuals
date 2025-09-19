import 'package:flutter/services.dart';
import 'package:freelancer_visuals/core/error/exceptions.dart';

abstract interface class DocumentDatasource {
  Future<String> loadDocument({
    required String title,
    required String assetPath,
  });
}

class DocumentDatasourceImpl implements DocumentDatasource {
  @override
  Future<String> loadDocument({
    required String title,
    required String assetPath,
  }) async {
    try {
      final text = await rootBundle.loadString(assetPath);
      if (text.isEmpty) {
        throw ServerException('Document not found!');
      }
      return text;
    } on ServerException catch (e) {
      throw ServerException(e.toString());
    }
  }
}
