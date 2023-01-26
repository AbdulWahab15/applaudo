import 'package:dartz/dartz.dart';
import 'package:applaudo_second_round/core/error/failures.dart';
import 'package:applaudo_second_round/features/issues/data/datamodels/issues/issues_repo.dart';

abstract class IssuesRepositories {
  Future<Either<Failure, Issues>> getReposIssues(
      {required int pageNo, required String fullName});
}
