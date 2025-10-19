import 'package:fpdart/fpdart.dart';
import 'package:freelancer_visuals/core/error/faliures.dart';
import 'package:freelancer_visuals/core/usecase/usecase.dart';
import 'package:freelancer_visuals/features/projects/domain/repositories/client_repository.dart';

class GetTotalClients implements UseCase<int, TotalClientParams> {
  final ClientRepository clientRepository;
  GetTotalClients(this.clientRepository);
  @override
  Future<Either<Failure, int>> call(TotalClientParams params) async {
    return await clientRepository.getTotalClients(params.userId);
  }
}

class TotalClientParams {
  final String userId;

  TotalClientParams({required this.userId});
}
