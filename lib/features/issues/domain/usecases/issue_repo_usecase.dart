import 'package:dartz/dartz.dart';
import 'package:applaudo_second_round/core/error/failures.dart';
import 'package:applaudo_second_round/features/issues/data/datamodels/issues/issues_repo.dart';
import 'package:applaudo_second_round/features/issues/domain/repositories/issues_repository.dart';

class IssueRepoUseCase {
  final IssuesRepositories repo;
  IssueRepoUseCase(this.repo);

  Future<Either<Failure, Issues>> call(
      {required int pageNo, required String fullName}) async {
    return await repo.getReposIssues(pageNo: pageNo, fullName: fullName);
  }
}
