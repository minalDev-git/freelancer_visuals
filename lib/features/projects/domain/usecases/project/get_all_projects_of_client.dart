import 'package:fpdart/fpdart.dart';
import 'package:freelancer_visuals/core/error/faliures.dart';
import 'package:freelancer_visuals/core/usecase/usecase.dart';
import 'package:freelancer_visuals/features/projects/domain/entities/project.dart';
import 'package:freelancer_visuals/features/projects/domain/repositories/project_repository.dart';

class GetAllClientProject
    implements UseCase<List<Project>, AllClientProjectParams> {
  final ProjectRepository projectRepository;
  GetAllClientProject(this.projectRepository);
  @override
  Future<Either<Failure, List<Project>>> call(
    AllClientProjectParams params,
  ) async {
    return await projectRepository.getAllProjectsOfClient(
      params.userId,
      params.clientId,
    );
  }
}

class AllClientProjectParams {
  final String userId;
  final String clientId;
  AllClientProjectParams({required this.userId, required this.clientId});
}
