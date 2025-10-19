import 'package:fpdart/fpdart.dart';
import 'package:freelancer_visuals/core/error/exceptions.dart';
import 'package:freelancer_visuals/core/error/faliures.dart';
import 'package:freelancer_visuals/features/projects/data/datasources/client_remote_datasource.dart';
import 'package:freelancer_visuals/features/projects/data/models/client_model.dart';
import 'package:freelancer_visuals/features/projects/domain/entities/client.dart';
import 'package:freelancer_visuals/features/projects/domain/repositories/client_repository.dart';
import 'package:uuid/uuid.dart';

class ClientRepositoryImpl implements ClientRepository {
  final ClientRemoteDataSource clientRemoteDataSource;

  ClientRepositoryImpl(this.clientRemoteDataSource);

  @override
  Future<Either<Failure, Client>> createClient({
    required String userId,
    required String clientName,
    required String companyName,
    required String clientEmail,
  }) async {
    try {
      ClientModel clientModel = ClientModel(
        clientId: const Uuid().v1(),
        userId: userId,
        clientName: clientName,
        companyName: companyName,
        clientEmail: clientEmail,
        createdAt: DateTime.now(),
      );
      final uploadedClient = await clientRemoteDataSource.createClient(
        clientModel,
      );
      return right(uploadedClient);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteClient(String clientId) async {
    try {
      await clientRemoteDataSource.deleteClient(clientId);
      return right(true);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Client>>> getAllClients(String userId) async {
    try {
      final clients = await clientRemoteDataSource.getAllClients(userId);
      return right(clients);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Client>>> getClient(String clientName) async {
    try {
      final client = await clientRemoteDataSource.getClient(clientName);
      return right(client);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, int>> getMonthlyClients(String userId) async {
    try {
      final totalMonthlyClients = await clientRemoteDataSource
          .getMonthlyClients(userId);
      return right(totalMonthlyClients);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> getTotalClients(String userId) async {
    try {
      final totalClients = await clientRemoteDataSource.getTotalClients(userId);
      return right(totalClients);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Client>> updateClient({
    required String clientId,
    required String userId,
    required String clientName,
    required String companyName,
    required String clientEmail,
  }) async {
    try {
      ClientModel clientModel = ClientModel(
        clientId: clientId,
        userId: userId,
        clientName: clientName,
        companyName: companyName,
        clientEmail: clientEmail,
        createdAt: DateTime.now(),
      );
      final updatedClient = await clientRemoteDataSource.updateClient(
        clientModel,
      );
      return right(updatedClient);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
