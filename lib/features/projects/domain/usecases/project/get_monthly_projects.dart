import 'package:fpdart/fpdart.dart';
import 'package:freelancer_visuals/core/error/faliures.dart';
import 'package:freelancer_visuals/core/usecase/usecase.dart';

import 'package:freelancer_visuals/features/projects/domain/repositories/project_repository.dart';

class GetMonthlyProjects implements UseCase<int, MonthlyProjectParams> {
  final ProjectRepository projectRepository;
  GetMonthlyProjects(this.projectRepository);
  @override
  Future<Either<Failure, int>> call(MonthlyProjectParams params) async {
    return await projectRepository.getMonthlyProjects(params.userId);
  }
}

class MonthlyProjectParams {
  final String userId;
  MonthlyProjectParams({required this.userId});
}
