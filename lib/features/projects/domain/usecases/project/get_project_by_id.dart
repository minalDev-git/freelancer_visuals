import 'package:fpdart/fpdart.dart';
import 'package:freelancer_visuals/core/error/faliures.dart';
import 'package:freelancer_visuals/core/usecase/usecase.dart';
import 'package:freelancer_visuals/features/projects/domain/entities/project.dart';
import 'package:freelancer_visuals/features/projects/domain/repositories/project_repository.dart';

class GetProjectById implements UseCase<Project, GetProjectByIDParams> {
  final ProjectRepository projectRepository;
  GetProjectById(this.projectRepository);
  @override
  Future<Either<Failure, Project>> call(GetProjectByIDParams params) async {
    return await projectRepository.getProject(params.projectId);
  }
}

class GetProjectByIDParams {
  final String projectId;
  GetProjectByIDParams({required this.projectId});
}
