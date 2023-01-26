import 'package:applaudo_second_round/features/datasource/issues_repo_datasource.dart';
import 'package:applaudo_second_round/features/issues/data/datamodels/issues/issues_repo.dart';
import 'package:applaudo_second_round/features/issues/domain/repositories/issues_repository.dart';
import 'package:applaudo_second_round/core/error/failures.dart';
import 'package:dartz/dartz.dart';

class IssuesRepoImplementation extends IssuesRepositories {
  final IssueRepoDataSource repositories;
  IssuesRepoImplementation({required this.repositories});

  @override
  Future<Either<Failure, Issues>> getReposIssues(
      {required int pageNo, required String fullName}) async {
    try {
      final remotePosts = await repositories.getSearchReposIssues(
          pageNo: pageNo, fullName: fullName);

      return Right(remotePosts);
    } catch (exp) {
      return Left(SerivceFailure());
    }
  }
}
