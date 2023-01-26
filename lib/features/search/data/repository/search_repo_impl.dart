import 'package:applaudo_second_round/features/datasource/search_repo_datasource.dart';
import 'package:applaudo_second_round/features/search/data/datamodels/searchrepo/search_repo.dart';
import 'package:applaudo_second_round/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:applaudo_second_round/features/search/domain/repositories/search_repository.dart';

class SearchRepoImplementation extends SearchRepositories {
  final SearchRepoDataSource repositories;
  SearchRepoImplementation({required this.repositories});

  @override
  Future<Either<Failure, Repos>> getSearchRepos(
      {required int pageNo, required String keyWords}) async {
    try {
      final remotePosts =
          await repositories.getSearchRepos(pageNo: pageNo, keyWords: keyWords);

      return Right(remotePosts);
    } catch (exp) {
      return Left(SerivceFailure());
    }
  }

}
