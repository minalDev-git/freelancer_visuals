import 'package:fpdart/fpdart.dart';
import 'package:freelancer_visuals/core/error/faliures.dart';
import 'package:freelancer_visuals/core/usecase/usecase.dart';
import 'package:freelancer_visuals/features/projects/domain/repositories/project_repository.dart';

class GetTotalProjects implements UseCase<int, TotalProjectsParams> {
  final ProjectRepository projectRepository;
  GetTotalProjects(this.projectRepository);
  @override
  Future<Either<Failure, int>> call(TotalProjectsParams params) async {
    return await projectRepository.getTotalProjects(params.userId);
  }
}

class TotalProjectsParams {
  final String userId;
  TotalProjectsParams({required this.userId});
}
