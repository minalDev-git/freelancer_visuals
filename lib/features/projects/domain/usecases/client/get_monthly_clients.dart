import 'package:fpdart/fpdart.dart';
import 'package:freelancer_visuals/core/error/faliures.dart';
import 'package:freelancer_visuals/core/usecase/usecase.dart';
import 'package:freelancer_visuals/features/projects/domain/repositories/client_repository.dart';

class GetMonthlyClients implements UseCase<int, MonthlyClientParams> {
  final ClientRepository clientRepository;
  GetMonthlyClients(this.clientRepository);
  @override
  Future<Either<Failure, int>> call(MonthlyClientParams params) async {
    return await clientRepository.getMonthlyClients(params.userId);
  }
}

class MonthlyClientParams {
  final String userId;

  MonthlyClientParams({required this.userId});
}
