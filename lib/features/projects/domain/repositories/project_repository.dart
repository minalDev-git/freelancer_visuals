import 'package:fpdart/fpdart.dart';
import 'package:freelancer_visuals/core/error/faliures.dart';
import 'package:freelancer_visuals/features/projects/domain/entities/project.dart';

abstract interface class ProjectRepository {
  Future<Either<Failure, Project>> createProject({
    required String clientId,
    required String userId,
    required String category,
    required String projectName,
    required DateTime startDate,
    required DateTime deadline,
    required PStatus status,
    required double ammount,
  });
  Future<Either<Failure, List<Project>>> getAllProjects(String userId);
  Future<Either<Failure, List<Project>>> getAllProjectsOfClient(
    String userId,
    String clientId,
  );
  Future<Either<Failure, int>> getTotalProjects(String userId);
  Future<Either<Failure, int>> getMonthlyProjects(String userId);
  Future<Either<Failure, Project>> updateProject({
    required String projectId,
    required String clientId,
    required String userId,
    required String category,
    required String projectName,
    required DateTime startDate,
    required DateTime deadline,
    required PStatus status,
    required double ammount,
  });
  Future<Either<Failure, bool>> deleteProject(String projectId);
  Future<Either<Failure, Project>> getProject(String projectName);
  Future<Either<Failure, Project>> getProjectById(String projectId);
  Future<Either<Failure, Project>> getProjectByStatus(
    String clientId,
    PStatus status,
  );
  Future<Either<Failure, List<Project>>> getAllProjectsByStatus(
    String userId,
    PStatus status,
  );
  Future<Either<Failure, int>> getTotalProjectsByStatus(
    String userId,
    PStatus status,
  );
}
