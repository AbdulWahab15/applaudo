import 'package:dartz/dartz.dart';
import 'package:applaudo_second_round/core/error/failures.dart';
import 'package:applaudo_second_round/features/issues/data/datamodels/issues/issues_repo.dart';
import 'package:applaudo_second_round/features/issues/domain/repositories/issues_repository.dart';

import 'mock_data.dart';

class MockIssuesRepo implements IssuesRepositories {
  @override
  Future<Either<Failure, Issues>> getReposIssues(
      {required int pageNo, required String fullName}) {
    return Future.value(Right(Issues(
        incompleteResults: false, totalCount: 2, items: mockIssuesItemsData)));
  }
}
