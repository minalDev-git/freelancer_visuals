import 'package:fpdart/fpdart.dart';
import 'package:freelancer_visuals/core/error/faliures.dart';
import 'package:freelancer_visuals/core/usecase/usecase.dart';
import 'package:freelancer_visuals/features/projects/domain/entities/client.dart';
import 'package:freelancer_visuals/features/projects/domain/repositories/client_repository.dart';

class GetAllClients implements UseCase<List<Client>, AllClientParams> {
  final ClientRepository clientRepository;
  GetAllClients(this.clientRepository);
  @override
  Future<Either<Failure, List<Client>>> call(AllClientParams params) async {
    return await clientRepository.getAllClients(params.userId);
  }
}

class AllClientParams {
  final String userId;

  AllClientParams({required this.userId});
}
