import 'package:fpdart/fpdart.dart';
import 'package:freelancer_visuals/core/error/faliures.dart';
import 'package:freelancer_visuals/core/usecase/usecase.dart';
import 'package:freelancer_visuals/features/projects/domain/repositories/client_repository.dart';

class DeleteClient implements UseCase<bool, DelClientParams> {
  final ClientRepository clientRepository;
  DeleteClient(this.clientRepository);
  @override
  Future<Either<Failure, bool>> call(DelClientParams params) async {
    return await clientRepository.deleteClient(params.clientId);
  }
}

class DelClientParams {
  final String clientId;

  DelClientParams({required this.clientId});
}
