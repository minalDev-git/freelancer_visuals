import 'package:fpdart/fpdart.dart';
import 'package:freelancer_visuals/core/error/faliures.dart';
import 'package:freelancer_visuals/core/usecase/usecase.dart';
import 'package:freelancer_visuals/features/projects/domain/entities/project.dart';
import 'package:freelancer_visuals/features/projects/domain/repositories/project_repository.dart';

class GetProjectByStatus implements UseCase<Project, ProjectByStatusParams> {
  final ProjectRepository projectRepository;
  GetProjectByStatus(this.projectRepository);
  @override
  Future<Either<Failure, Project>> call(ProjectByStatusParams params) async {
    return await projectRepository.getProjectByStatus(
      params.clientId,
      params.status,
    );
  }
}

class ProjectByStatusParams {
  final String clientId;
  final PStatus status;
  ProjectByStatusParams({required this.clientId, required this.status});
}
