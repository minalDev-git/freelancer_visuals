import 'package:fpdart/fpdart.dart';
import 'package:freelancer_visuals/core/error/faliures.dart';
import 'package:freelancer_visuals/core/usecase/usecase.dart';
import 'package:freelancer_visuals/features/projects/domain/entities/project.dart';
import 'package:freelancer_visuals/features/projects/domain/repositories/project_repository.dart';

class GetProject implements UseCase<Project, GetProjectParams> {
  final ProjectRepository projectRepository;
  GetProject(this.projectRepository);
  @override
  Future<Either<Failure, Project>> call(GetProjectParams params) async {
    return await projectRepository.getProject(params.projectName);
  }
}

class GetProjectParams {
  final String projectName;
  GetProjectParams({required this.projectName});
}
