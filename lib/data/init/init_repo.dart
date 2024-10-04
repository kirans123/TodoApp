import 'package:login_and_registration/app/app_config/config.dart';
import 'package:login_and_registration/data/repo/auth/auth_repo.dart';
import 'package:login_and_registration/data/repo/auth/auth_repo_impl.dart';
import 'package:login_and_registration/data/repo/sync_repo/sync_repo.dart';
import 'package:login_and_registration/data/repo/sync_repo/sync_repo_impl.dart';
import 'package:login_and_registration/data/repo/task/task_repo.dart';
import 'package:login_and_registration/data/repo/task/task_repo_impl.dart';

void initRepo() {
  getIt.registerLazySingleton<TaskRepository>(() => TaskRepoImpl());
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());
  getIt.registerLazySingleton<SyncRepo>(() => SyncRepoImpl());
}

TaskRepository get taskRepository => getIt.get();
AuthRepository get authRepository => getIt.get();
SyncRepo get syncRepo => getIt.get();
