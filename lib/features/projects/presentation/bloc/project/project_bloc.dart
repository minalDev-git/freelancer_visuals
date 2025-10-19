import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer_visuals/features/projects/domain/entities/project.dart';
import 'package:freelancer_visuals/features/projects/domain/usecases/project/delete_project.dart';
import 'package:freelancer_visuals/features/projects/domain/usecases/project/get_all_projects.dart';
import 'package:freelancer_visuals/features/projects/domain/usecases/project/get_all_projects_by_status.dart';
import 'package:freelancer_visuals/features/projects/domain/usecases/project/get_all_projects_of_client.dart';
import 'package:freelancer_visuals/features/projects/domain/usecases/project/get_monthly_projects.dart';
import 'package:freelancer_visuals/features/projects/domain/usecases/project/get_project.dart';
import 'package:freelancer_visuals/features/projects/domain/usecases/project/get_project_by_status.dart';
import 'package:freelancer_visuals/features/projects/domain/usecases/project/get_total_projects.dart';
import 'package:freelancer_visuals/features/projects/domain/usecases/project/get_total_projects_by_status.dart';
import 'package:freelancer_visuals/features/projects/domain/usecases/project/update_project.dart';
import 'package:freelancer_visuals/features/projects/domain/usecases/project/upload_project.dart';

part 'project_event.dart';
part 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  final UploadProject _uploadProject;
  final DeleteProject _deleteProject;
  final GetAllProjectsByStatus _getAllProjectsByStatus;
  final GetAllClientProject _getAllClientProject;
  final GetAllProjects _getAllProjects;
  final GetMonthlyProjects _getMonthlyProjects;
  final GetProjectByStatus _getProjectByStatus;
  final GetProject _getProject;
  // final GetTotalProjectsByStatus _getTotalProjectsByStatus;
  final GetTotalProjects _getTotalProjects;
  final UpdateProject _updateProject;
  ProjectBloc({
    required UploadProject uploadProject,
    required DeleteProject deleteProject,
    required GetAllProjectsByStatus getAllProjectsByStatus,
    required GetAllClientProject getAllClientProject,
    required GetAllProjects getAllProjects,
    required GetMonthlyProjects getMonthlyProjects,
    required GetProjectByStatus getProjectByStatus,
    required GetProject getProject,
    required GetTotalProjectsByStatus getTotalProjectsByStatus,
    required GetTotalProjects getTotalProjects,
    required UpdateProject updateProject,
  }) : _uploadProject = uploadProject,
       _updateProject = updateProject,
       _deleteProject = deleteProject,
       _getAllClientProject = getAllClientProject,
       _getAllProjects = getAllProjects,
       _getAllProjectsByStatus = getAllProjectsByStatus,
       _getMonthlyProjects = getMonthlyProjects,
       _getProject = getProject,
       _getProjectByStatus = getProjectByStatus,
       _getTotalProjects = getTotalProjects,
       //  _getTotalProjectsByStatus = getTotalProjectsByStatus,
       super(ProjectInitial()) {
    on<ProjectEvent>((event, emit) {
      emit(ProjectLoading());
    });
    on<ProjectUpload>(_onProjectUpload);
    on<ProjectUpdate>(_onUpdateProject);
    on<ProjectDelete>(_onDeleteProject);
    on<ProjectSearch>(_onProjectSearch);
    on<CountAllProjects>(_onCountAllProjects);
    on<CountMonthlyProjects>(_onCountMonthlyProjects);
    on<AllProjectsList>(_onAllProjectsList);
    on<ProjectSearchByStatus>(_onProjectSearchByStatus);
    on<AllProjectsByStatusList>(_onAllProjectsByStatus);
    on<AllClientProjects>(_onGetAllClientProjects);
  }

  void _onProjectUpload(ProjectUpload event, Emitter<ProjectState> emit) async {
    final res = await _uploadProject(
      UploadProjectParams(
        clientId: event.clientId,
        userId: event.userId,
        projectName: event.projectName,
        category: event.category,
        startDate: event.startDate,
        deadline: event.deadline,
        status: event.status,
        ammount: event.ammount,
      ),
    );
    res.fold(
      (l) => emit(ProjectFailure(l.message)),
      (r) => emit(ProjectUploadSuccess()),
    );
  }

  void _onUpdateProject(ProjectUpdate event, Emitter<ProjectState> emit) async {
    final res = await _updateProject(
      UpdateProjectParams(
        projectId: event.projectId,
        projectName: event.projectName,
        clientId: event.clientId,
        userId: event.userId,
        category: event.category,
        startDate: event.startDate,
        deadline: event.deadline,
        ammount: event.ammount,
        status: event.status,
      ),
    );
    res.fold(
      (l) => emit(ProjectFailure(l.message)),
      (r) => emit(ProjectUploadSuccess()),
    );
  }

  void _onDeleteProject(ProjectDelete event, Emitter<ProjectState> emit) async {
    final res = await _deleteProject(
      DelProjectParams(projectId: event.projectId),
    );
    res.fold(
      (l) => emit(ProjectFailure(l.message)),
      (r) => emit(ProjectUploadSuccess()),
    );
  }

  void _onProjectSearch(ProjectSearch event, Emitter<ProjectState> emit) async {
    final res = await _getProject(
      GetProjectParams(projectName: event.projectName),
    );
    res.fold(
      (l) => emit(ProjectFailure(l.message)),
      (r) => emit(ProjectUploadSuccess()),
    );
  }

  void _onProjectSearchByStatus(
    ProjectSearchByStatus event,
    Emitter<ProjectState> emit,
  ) async {
    final res = await _getProjectByStatus(
      ProjectByStatusParams(clientId: event.clientId, status: event.status),
    );
    res.fold(
      (l) => emit(ProjectFailure(l.message)),
      (r) => emit(ProjectUploadSuccess()),
    );
  }

  void _onCountAllProjects(
    CountAllProjects event,
    Emitter<ProjectState> emit,
  ) async {
    final res = await _getTotalProjects(
      TotalProjectsParams(userId: event.userId),
    );
    res.fold(
      (l) => emit(ProjectFailure(l.message)),
      (r) => emit(ProjectUploadSuccess()),
    );
  }

  void _onCountMonthlyProjects(
    CountMonthlyProjects event,
    Emitter<ProjectState> emit,
  ) async {
    final res = await _getMonthlyProjects(
      MonthlyProjectParams(userId: event.userId),
    );
    res.fold(
      (l) => emit(ProjectFailure(l.message)),
      (r) => emit(ProjectUploadSuccess()),
    );
  }

  void _onAllProjectsList(
    AllProjectsList event,
    Emitter<ProjectState> emit,
  ) async {
    final res = await _getAllProjects(AllProjectParams(userId: event.userId));
    res.fold(
      (l) => emit(ProjectFailure(l.message)),
      (r) => emit(ProjectDisplaySuccess(r)),
    );
  }

  void _onAllProjectsByStatus(
    AllProjectsByStatusList event,
    Emitter<ProjectState> emit,
  ) async {
    final res = await _getAllProjectsByStatus(
      AllProjectByStatusParams(userId: event.userId, status: event.status),
    );
    res.fold(
      (l) => emit(ProjectFailure(l.message)),
      (r) => emit(ProjectDisplaySuccess(r)),
    );
  }

  void _onGetAllClientProjects(
    AllClientProjects event,
    Emitter<ProjectState> emit,
  ) async {
    final res = await _getAllClientProject(
      AllClientProjectParams(userId: event.userId, clientId: event.clientId),
    );
    res.fold(
      (l) => emit(ProjectFailure(l.message)),
      (r) => emit(ProjectDisplaySuccess(r)),
    );
  }
}
