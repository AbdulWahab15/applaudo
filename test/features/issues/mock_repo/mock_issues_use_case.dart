import 'package:dartz/dartz.dart';
import 'package:applaudo_second_round/core/error/failures.dart';
import 'package:applaudo_second_round/features/issues/domain/repositories/issues_repository.dart';
import 'package:applaudo_second_round/features/issues/data/datamodels/issues/issues_repo.dart';
import 'package:applaudo_second_round/features/issues/domain/usecases/issue_repo_usecase.dart';

import 'mock_data.dart';
import 'mock_issues_repo.dart';

class MockIssuesUseCase implements IssueRepoUseCase {
  @override
  Future<Either<Failure, Issues>> call(
      {required int pageNo, required String fullName}) {
    return Future.value(Right(Issues(
        incompleteResults: false, totalCount: 2, items: mockIssuesItemsData)));
  }

  @override
  IssuesRepositories get repo => MockIssuesRepo();
}
