import 'package:fpdart/fpdart.dart';
import 'package:freelancer_visuals/core/error/faliures.dart';
import 'package:freelancer_visuals/features/projects/domain/entities/client.dart';

abstract interface class ClientRepository {
  Future<Either<Failure, Client>> createClient({
    required String userId,
    required String clientName,
    required String companyName,
    required String clientEmail,
  });

  Future<Either<Failure, List<Client>>> getClient(String clientName);
  Future<Either<Failure, List<Client>>> getAllClients(String userId);
  Future<Either<Failure, Client>> updateClient({
    required String clientId,
    required String userId,
    required String clientName,
    required String companyName,
    required String clientEmail,
  });
  Future<Either<Failure, bool>> deleteClient(String clientId);
  Future<Either<Failure, int>> getTotalClients(String userId);
  Future<Either<Failure, int>> getMonthlyClients(String userId);
}
