import 'package:fpdart/fpdart.dart';
import 'package:freelancer_visuals/core/error/faliures.dart';
import 'package:freelancer_visuals/core/usecase/usecase.dart';
import 'package:freelancer_visuals/features/projects/domain/entities/project.dart';
import 'package:freelancer_visuals/features/projects/domain/repositories/project_repository.dart';

class UpdateProject implements UseCase<Project, UpdateProjectParams> {
  final ProjectRepository projectRepository;
  UpdateProject(this.projectRepository);
  @override
  Future<Either<Failure, Project>> call(UpdateProjectParams params) async {
    return await projectRepository.updateProject(
      projectId: params.projectId,
      clientId: params.clientId,
      userId: params.userId,
      projectName: params.projectName,
      category: params.category,
      startDate: params.startDate,
      deadline: params.deadline,
      status: params.status,
      ammount: params.ammount,
    );
  }
}

class UpdateProjectParams {
  final String projectId;
  final String clientId;
  final String userId;
  final String projectName;
  final String category;
  final DateTime startDate;
  final DateTime deadline;
  final PStatus status;
  final double ammount;

  UpdateProjectParams({
    required this.projectId,
    required this.clientId,
    required this.userId,
    required this.projectName,
    required this.category,
    required this.startDate,
    required this.deadline,
    required this.status,
    required this.ammount,
  });
}
