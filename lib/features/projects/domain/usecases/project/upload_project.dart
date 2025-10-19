import 'package:fpdart/fpdart.dart';
import 'package:freelancer_visuals/core/error/faliures.dart';
import 'package:freelancer_visuals/core/usecase/usecase.dart';
import 'package:freelancer_visuals/features/projects/domain/entities/project.dart';
import 'package:freelancer_visuals/features/projects/domain/repositories/project_repository.dart';

class UploadProject implements UseCase<Project, UploadProjectParams> {
  final ProjectRepository projectRepository;
  UploadProject(this.projectRepository);
  @override
  Future<Either<Failure, Project>> call(UploadProjectParams params) async {
    return await projectRepository.createProject(
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

class UploadProjectParams {
  final String clientId;
  final String userId;
  final String projectName;
  final String category;
  final DateTime startDate;
  final DateTime deadline;
  final PStatus status;
  final double ammount;

  UploadProjectParams({
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
