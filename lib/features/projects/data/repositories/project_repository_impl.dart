import 'package:fpdart/fpdart.dart';
import 'package:freelancer_visuals/core/error/exceptions.dart';
import 'package:freelancer_visuals/core/error/faliures.dart';
import 'package:freelancer_visuals/features/projects/data/datasources/project_remote_datasource.dart';
import 'package:freelancer_visuals/features/projects/data/models/project_model.dart';
import 'package:freelancer_visuals/features/projects/domain/entities/project.dart';
import 'package:freelancer_visuals/features/projects/domain/repositories/project_repository.dart';
import 'package:uuid/uuid.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final ProjectRemoteDataSource projectRemoteDataSource;
  ProjectRepositoryImpl(this.projectRemoteDataSource);
  @override
  Future<Either<Failure, Project>> createProject({
    required String clientId,
    required String userId,
    required String projectName,
    required String category,
    required DateTime startDate,
    required DateTime deadline,
    required PStatus status,
    required double ammount,
  }) async {
    try {
      ProjectModel projectModel = ProjectModel(
        projectId: const Uuid().v1(),
        clientId: clientId,
        userId: userId,
        projectName: projectName,
        category: category,
        startDate: startDate,
        deadline: deadline,
        status: status,
        ammount: ammount,
      );
      final uploadedProject = await projectRemoteDataSource.createProject(
        projectModel,
      );
      return right(uploadedProject);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteProject(String projectId) async {
    try {
      await projectRemoteDataSource.deleteProject(projectId);
      return right(true);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Project>>> getAllProjects(String userId) async {
    try {
      final projects = await projectRemoteDataSource.getAllProjects(userId);
      return right(projects);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Project>>> getAllProjectsByStatus(
    String userId,
    PStatus status,
  ) async {
    try {
      final projects = await projectRemoteDataSource.getAllProjectsByStatus(
        userId,
        status,
      );
      return right(projects);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Project>>> getAllProjectsOfClient(
    String userId,
    String clientId,
  ) async {
    try {
      final projects = await projectRemoteDataSource.getAllProjectsOfClient(
        userId,
        clientId,
      );
      return right(projects);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, int>> getMonthlyProjects(String userId) async {
    try {
      final count = await projectRemoteDataSource.getMonthlyProjects(userId);
      return right(count);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Project>> getProject(String projectName) async {
    try {
      final project = await projectRemoteDataSource.getProject(projectName);
      return right(project);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Project>> getProjectByStatus(
    String clientId,
    PStatus status,
  ) async {
    try {
      final project = await projectRemoteDataSource.getProjectByStatus(
        clientId,
        status,
      );
      return right(project);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, int>> getTotalProjects(String userId) async {
    try {
      final count = await projectRemoteDataSource.getTotalProjects(userId);
      return right(count);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, int>> getTotalProjectsByStatus(
    String userId,
    PStatus status,
  ) async {
    try {
      final count = await projectRemoteDataSource.getTotalProjectsByStatus(
        userId,
        status,
      );
      return right(count);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
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
  }) async {
    try {
      ProjectModel projectModel = ProjectModel(
        projectId: projectId,
        clientId: clientId,
        userId: userId,
        projectName: projectName,
        category: category,
        startDate: startDate,
        deadline: deadline,
        status: status,
        ammount: ammount,
      );
      final project = await projectRemoteDataSource.updateProject(projectModel);
      return right(project);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
