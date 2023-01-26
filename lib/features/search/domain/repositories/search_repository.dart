import 'package:dartz/dartz.dart';
import 'package:applaudo_second_round/core/error/failures.dart';
import 'package:applaudo_second_round/features/search/data/datamodels/searchrepo/search_repo.dart';

abstract class SearchRepositories {
  Future<Either<Failure, Repos>> getSearchRepos(
      {required int pageNo, required String keyWords});
  }
