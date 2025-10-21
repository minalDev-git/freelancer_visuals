import 'package:freelancer_visuals/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:freelancer_visuals/core/secrets/app_secrets.dart';
import 'package:freelancer_visuals/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:freelancer_visuals/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:freelancer_visuals/features/auth/domain/repository/auth_repository.dart';
import 'package:freelancer_visuals/features/auth/domain/usecases/current_user.dart';
import 'package:freelancer_visuals/features/auth/domain/usecases/google_auth.dart';
import 'package:freelancer_visuals/features/auth/domain/usecases/user_login.dart';
import 'package:freelancer_visuals/features/auth/domain/usecases/user_sign_up.dart';
import 'package:freelancer_visuals/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:freelancer_visuals/features/projects/data/datasources/client_remote_datasource.dart';
import 'package:freelancer_visuals/features/projects/data/datasources/invoice_remote_datasource.dart';
import 'package:freelancer_visuals/features/projects/data/datasources/project_remote_datasource.dart';
import 'package:freelancer_visuals/features/projects/data/repositories/client_repository_impl.dart';
import 'package:freelancer_visuals/features/projects/data/repositories/invoice_repository_impl.dart';
import 'package:freelancer_visuals/features/projects/data/repositories/project_repository_impl.dart';
import 'package:freelancer_visuals/features/projects/domain/repositories/client_repository.dart';
import 'package:freelancer_visuals/features/projects/domain/repositories/invoice_repository.dart';
import 'package:freelancer_visuals/features/projects/domain/repositories/project_repository.dart';
import 'package:freelancer_visuals/features/projects/domain/usecases/client/delete_client.dart';
import 'package:freelancer_visuals/features/projects/domain/usecases/client/get_all_clients.dart';
import 'package:freelancer_visuals/features/projects/domain/usecases/client/get_client.dart';
import 'package:freelancer_visuals/features/projects/domain/usecases/client/get_monthly_clients.dart';
import 'package:freelancer_visuals/features/projects/domain/usecases/client/get_total_clients.dart';
import 'package:freelancer_visuals/features/projects/domain/usecases/client/update_client.dart';
import 'package:freelancer_visuals/features/projects/domain/usecases/client/upload_client.dart';
import 'package:freelancer_visuals/features/projects/domain/usecases/invoice/delete_invoice.dart';
import 'package:freelancer_visuals/features/projects/domain/usecases/invoice/get_all_client_invoices.dart';
import 'package:freelancer_visuals/features/projects/domain/usecases/invoice/get_all_invoices.dart';
import 'package:freelancer_visuals/features/projects/domain/usecases/invoice/get_all_invoices_by_satus.dart';
import 'package:freelancer_visuals/features/projects/domain/usecases/invoice/get_invoice.dart';
import 'package:freelancer_visuals/features/projects/domain/usecases/invoice/get_invoice_by_status.dart';
import 'package:freelancer_visuals/features/projects/domain/usecases/invoice/get_monthly_invoices.dart';
import 'package:freelancer_visuals/features/projects/domain/usecases/invoice/get_total_invoices.dart';
import 'package:freelancer_visuals/features/projects/domain/usecases/invoice/get_total_invoices_by_status.dart';
import 'package:freelancer_visuals/features/projects/domain/usecases/invoice/update_invoice.dart';
import 'package:freelancer_visuals/features/projects/domain/usecases/invoice/upload_invoice.dart';
import 'package:freelancer_visuals/features/projects/domain/usecases/project/delete_project.dart';
import 'package:freelancer_visuals/features/projects/domain/usecases/project/get_all_projects.dart';
import 'package:freelancer_visuals/features/projects/domain/usecases/project/get_all_projects_by_status.dart';
import 'package:freelancer_visuals/features/projects/domain/usecases/project/get_all_projects_of_client.dart';
import 'package:freelancer_visuals/features/projects/domain/usecases/project/get_monthly_projects.dart';
import 'package:freelancer_visuals/features/projects/domain/usecases/project/get_project.dart';
import 'package:freelancer_visuals/features/projects/domain/usecases/project/get_project_by_id.dart';
import 'package:freelancer_visuals/features/projects/domain/usecases/project/get_project_by_status.dart';
import 'package:freelancer_visuals/features/projects/domain/usecases/project/get_total_projects.dart';
import 'package:freelancer_visuals/features/projects/domain/usecases/project/get_total_projects_by_status.dart';
import 'package:freelancer_visuals/features/projects/domain/usecases/project/update_project.dart';
import 'package:freelancer_visuals/features/projects/domain/usecases/project/upload_project.dart';
import 'package:freelancer_visuals/features/projects/presentation/bloc/client/client_bloc.dart';
import 'package:freelancer_visuals/features/projects/presentation/bloc/invoice/invoice_bloc.dart';
import 'package:freelancer_visuals/features/projects/presentation/bloc/project/project_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final GetIt serviceLocator = GetIt.instance;
Future<void> initDependencies() async {
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);
  _initAuth();
  _initClient();
  _initProject();
  _initInvoice();

  //core
  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

void _initAuth() {
  //DataSource
  serviceLocator.registerFactory<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(serviceLocator()),
  );
  //Repository
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(serviceLocator()),
  );
  //UseCases
  serviceLocator.registerFactory(() => UserSignUp(serviceLocator()));
  serviceLocator.registerFactory(() => UserLogin(serviceLocator()));
  serviceLocator.registerFactory(() => GoogleAuth(serviceLocator()));
  serviceLocator.registerFactory(() => CurrentUser(serviceLocator()));

  //Bloc
  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      userSignUp: serviceLocator(),
      userLogin: serviceLocator(),
      googleUser: serviceLocator(),
      currentUser: serviceLocator(),
      appUserCubit: serviceLocator(),
    ),
  );
}

void _initClient() {
  //Datasource
  serviceLocator.registerFactory<ClientRemoteDataSource>(
    () => ClientRemoteDataSourceImpl(serviceLocator()),
  );
  //Repository
  serviceLocator.registerFactory<ClientRepository>(
    () => ClientRepositoryImpl(serviceLocator()),
  );
  //Usecase Client
  serviceLocator.registerFactory(() => UploadClient(serviceLocator()));
  serviceLocator.registerFactory(() => UpdateClients(serviceLocator()));
  serviceLocator.registerFactory(() => DeleteClient(serviceLocator()));
  serviceLocator.registerFactory(() => GetAllClients(serviceLocator()));
  serviceLocator.registerFactory(() => GetClients(serviceLocator()));
  serviceLocator.registerFactory(() => GetTotalClients(serviceLocator()));
  serviceLocator.registerFactory(() => GetMonthlyClients(serviceLocator()));

  //Client Bloc
  serviceLocator.registerLazySingleton(
    () => ClientBloc(
      updateClients: serviceLocator(),
      uploadClient: serviceLocator(),
      deleteClient: serviceLocator(),
      getAllClients: serviceLocator(),
      getClient: serviceLocator(),
      getMonthlyClients: serviceLocator(),
      getTotalClients: serviceLocator(),
    ),
  );
}

void _initProject() {
  // ✅ 1. Data sources
  serviceLocator.registerFactory<ProjectRemoteDataSource>(
    () => ProjectRemoteDataSourceImpl(serviceLocator()),
  );
  // ✅ 2. Repositories
  serviceLocator.registerFactory<ProjectRepository>(
    () => ProjectRepositoryImpl(serviceLocator()),
  );

  //Usecase Project
  serviceLocator.registerFactory(() => UploadProject(serviceLocator()));
  serviceLocator.registerFactory(() => UpdateProject(serviceLocator()));
  serviceLocator.registerFactory(() => DeleteProject(serviceLocator()));
  serviceLocator.registerFactory(() => GetAllProjects(serviceLocator()));
  serviceLocator.registerFactory(() => GetAllClientProject(serviceLocator()));

  serviceLocator.registerFactory(
    () => GetAllProjectsByStatus(serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => GetTotalProjectsByStatus(serviceLocator()),
  );
  serviceLocator.registerFactory(() => GetProjectByStatus(serviceLocator()));
  serviceLocator.registerFactory(() => GetProject(serviceLocator()));
  serviceLocator.registerFactory(() => GetTotalProjects(serviceLocator()));
  serviceLocator.registerFactory(() => GetMonthlyProjects(serviceLocator()));
  serviceLocator.registerFactory(() => GetProjectById(serviceLocator()));

  //Project Bloc
  serviceLocator.registerLazySingleton(
    () => ProjectBloc(
      uploadProject: serviceLocator(),
      updateProject: serviceLocator(),
      deleteProject: serviceLocator(),
      getAllClientProject: serviceLocator(),
      getAllProjects: serviceLocator(),
      getAllProjectsByStatus: serviceLocator(),
      getMonthlyProjects: serviceLocator(),
      getProject: serviceLocator(),
      getProjectByStatus: serviceLocator(),
      getTotalProjects: serviceLocator(),
      getTotalProjectsByStatus: serviceLocator(),
      getProjectById: serviceLocator(),
    ),
  );
}

void _initInvoice() {
  //Datasource
  serviceLocator.registerFactory<InvoiceRemoteDataSource>(
    () => InvoiceRemoteDataSourceImpl(serviceLocator()),
  );
  //Repository
  serviceLocator.registerFactory<InvoiceRepository>(
    () => InvoiceRepositoryImpl(serviceLocator()),
  );
  //Usecase Invoice
  serviceLocator.registerFactory(() => UploadInvoice(serviceLocator()));
  serviceLocator.registerFactory(() => UpdateInvoice(serviceLocator()));
  serviceLocator.registerFactory(() => DeleteInvoice(serviceLocator()));
  serviceLocator.registerFactory(() => GetAllInvoices(serviceLocator()));
  serviceLocator.registerFactory(() => GetInvoice(serviceLocator()));
  serviceLocator.registerFactory(() => GetInvoiceByStatus(serviceLocator()));

  serviceLocator.registerFactory(
    () => GetTotalInvoicesByStatus(serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => GetAllInvoicesByStatus(serviceLocator()),
  );
  serviceLocator.registerFactory(() => GetAllClientInvoices(serviceLocator()));
  serviceLocator.registerFactory(() => GetTotalInvoices(serviceLocator()));
  serviceLocator.registerFactory(() => GetMonthlyInvoices(serviceLocator()));
  //Invoice Bloc
  serviceLocator.registerLazySingleton(
    () => InvoiceBloc(
      uploadInvoice: serviceLocator(),
      updateInvoice: serviceLocator(),
      deleteInvoice: serviceLocator(),
      getAllInvoices: serviceLocator(),
      getInvoice: serviceLocator(),
      getMonthlyInvoices: serviceLocator(),
      getTotalInvoices: serviceLocator(),
      invoiceSearchByStatus: serviceLocator(),
      allInvoiceSearchByStatus: serviceLocator(),
      getCountInvoiceByStatus: serviceLocator(),
    ),
  );
}
