import 'package:freelancer_visuals/core/secrets/app_secrets.dart';
import 'package:freelancer_visuals/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:freelancer_visuals/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:freelancer_visuals/features/auth/domain/repository/auth_repository.dart';
import 'package:freelancer_visuals/features/auth/domain/usecases/google_auth.dart';
import 'package:freelancer_visuals/features/auth/domain/usecases/user_login.dart';
import 'package:freelancer_visuals/features/auth/domain/usecases/user_sign_up.dart';
import 'package:freelancer_visuals/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;
Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );

  serviceLocator.registerLazySingleton(() => supabase.client);
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

  //Bloc
  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      userSignUp: serviceLocator(),
      userLogin: serviceLocator(),
      googleUser: serviceLocator(),
    ),
  );
}
