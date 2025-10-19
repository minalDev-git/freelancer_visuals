import 'package:fpdart/fpdart.dart';
import 'package:freelancer_visuals/core/error/faliures.dart';
import 'package:freelancer_visuals/core/usecase/usecase.dart';
import 'package:freelancer_visuals/features/projects/domain/entities/client.dart';
import 'package:freelancer_visuals/features/projects/domain/repositories/client_repository.dart';

class UpdateClients implements UseCase<Client, UpdateClientParams> {
  final ClientRepository clientRepository;
  UpdateClients(this.clientRepository);
  @override
  Future<Either<Failure, Client>> call(UpdateClientParams params) async {
    return await clientRepository.updateClient(
      clientId: params.clientId,
      userId: params.userId,
      clientName: params.clientName,
      companyName: params.companyName,
      clientEmail: params.clientEmail,
    );
  }
}

class UpdateClientParams {
  final String clientId;
  final String userId;
  final String clientName;
  final String companyName;
  final String clientEmail;

  UpdateClientParams({
    required this.clientId,
    required this.userId,
    required this.clientName,
    required this.companyName,
    required this.clientEmail,
  });
}
