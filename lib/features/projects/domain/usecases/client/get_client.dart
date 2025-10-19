import 'package:fpdart/fpdart.dart';
import 'package:freelancer_visuals/core/error/faliures.dart';
import 'package:freelancer_visuals/core/usecase/usecase.dart';
import 'package:freelancer_visuals/features/projects/domain/entities/client.dart';
import 'package:freelancer_visuals/features/projects/domain/repositories/client_repository.dart';

class GetClients implements UseCase<List<Client>, ClientParams> {
  final ClientRepository clientRepository;
  GetClients(this.clientRepository);
  @override
  Future<Either<Failure, List<Client>>> call(ClientParams params) async {
    return await clientRepository.getClient(params.clientName);
  }
}

class ClientParams {
  final String clientName;

  ClientParams({required this.clientName});
}
