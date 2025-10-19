import 'package:fpdart/fpdart.dart';
import 'package:freelancer_visuals/core/error/faliures.dart';
import 'package:freelancer_visuals/core/usecase/usecase.dart';
import 'package:freelancer_visuals/features/projects/domain/entities/project.dart';
import 'package:freelancer_visuals/features/projects/domain/repositories/project_repository.dart';

class GetAllProjects implements UseCase<List<Project>, AllProjectParams> {
  final ProjectRepository projectRepository;
  GetAllProjects(this.projectRepository);
  @override
  Future<Either<Failure, List<Project>>> call(AllProjectParams params) async {
    return await projectRepository.getAllProjects(params.userId);
  }
}

class AllProjectParams {
  final String userId;
  AllProjectParams({required this.userId});
}
