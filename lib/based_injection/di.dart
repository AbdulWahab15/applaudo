import 'package:get_it/get_it.dart';
import 'package:applaudo_second_round/core/error/failures.dart';
import 'package:applaudo_second_round/features/datasource/issues_repo_datasource.dart';
import 'package:applaudo_second_round/features/datasource/search_repo_datasource.dart';
import 'package:applaudo_second_round/features/issues/data/repository/issues_repo_impl.dart';
import 'package:applaudo_second_round/features/issues/domain/repositories/issues_repository.dart';
import 'package:applaudo_second_round/features/issues/domain/usecases/issue_repo_usecase.dart';
import 'package:applaudo_second_round/features/issues/presentation/bloc/git_repo_issue_bloc.dart';
import 'package:applaudo_second_round/features/search/data/repository/search_repo_impl.dart';
import 'package:applaudo_second_round/features/search/domain/repositories/search_repository.dart';
import 'package:applaudo_second_round/features/search/domain/usecases/search_repo_usecase.dart';
import 'package:applaudo_second_round/features/search/presentation/bloc/search_repo_bloc.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => SearchRepoBloc(getRepo: sl()));
  sl.registerFactory(() => GitRepoIssuesBloc(getRepo: sl()));

  sl.registerLazySingleton(() => SearchRepoUseCase(sl()));
  sl.registerLazySingleton(() => IssueRepoUseCase(sl()));

  sl.registerLazySingleton<SearchRepositories>(
      () => SearchRepoImplementation(repositories: sl()));
  sl.registerLazySingleton<SearchRepoDataSource>(
      () => SearchRepoDataSourceImpl(client: sl()));

  sl.registerLazySingleton<IssuesRepositories>(
      () => IssuesRepoImplementation(repositories: sl()));
  sl.registerLazySingleton<IssueRepoDataSource>(
      () => IssuesRepoDataSourceImpl(client: sl()));
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => http.Client());
}
