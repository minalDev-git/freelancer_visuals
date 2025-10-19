import 'package:fpdart/fpdart.dart';
import 'package:freelancer_visuals/core/error/faliures.dart';
import 'package:freelancer_visuals/core/usecase/usecase.dart';
import 'package:freelancer_visuals/features/projects/domain/repositories/project_repository.dart';

class DeleteProject implements UseCase<bool, DelProjectParams> {
  final ProjectRepository projectRepository;
  DeleteProject(this.projectRepository);
  @override
  Future<Either<Failure, bool>> call(DelProjectParams params) async {
    return await projectRepository.deleteProject(params.projectId);
  }
}

class DelProjectParams {
  final String projectId;

  DelProjectParams({required this.projectId});
}
