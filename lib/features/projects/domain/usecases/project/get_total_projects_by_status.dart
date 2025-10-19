import 'package:fpdart/fpdart.dart';
import 'package:freelancer_visuals/core/error/faliures.dart';
import 'package:freelancer_visuals/core/usecase/usecase.dart';
import 'package:freelancer_visuals/features/projects/domain/entities/project.dart';
import 'package:freelancer_visuals/features/projects/domain/repositories/project_repository.dart';

class GetTotalProjectsByStatus
    implements UseCase<int, TotalProjectByStatusParams> {
  final ProjectRepository projectRepository;
  GetTotalProjectsByStatus(this.projectRepository);
  @override
  Future<Either<Failure, int>> call(TotalProjectByStatusParams params) async {
    return await projectRepository.getTotalProjectsByStatus(
      params.userId,
      params.status,
    );
  }
}

class TotalProjectByStatusParams {
  final String userId;
  final PStatus status;
  TotalProjectByStatusParams({required this.userId, required this.status});
}
