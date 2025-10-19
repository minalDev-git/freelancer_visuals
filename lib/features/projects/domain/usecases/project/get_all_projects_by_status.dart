import 'package:fpdart/fpdart.dart';
import 'package:freelancer_visuals/core/error/faliures.dart';
import 'package:freelancer_visuals/core/usecase/usecase.dart';
import 'package:freelancer_visuals/features/projects/domain/entities/project.dart';
import 'package:freelancer_visuals/features/projects/domain/repositories/project_repository.dart';

class GetAllProjectsByStatus
    implements UseCase<List<Project>, AllProjectByStatusParams> {
  final ProjectRepository projectRepository;
  GetAllProjectsByStatus(this.projectRepository);
  @override
  Future<Either<Failure, List<Project>>> call(
    AllProjectByStatusParams params,
  ) async {
    return await projectRepository.getAllProjectsByStatus(
      params.userId,
      params.status,
    );
  }
}

class AllProjectByStatusParams {
  final String userId;
  final PStatus status;
  AllProjectByStatusParams({required this.userId, required this.status});
}
