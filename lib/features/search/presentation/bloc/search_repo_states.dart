import 'package:equatable/equatable.dart';
import 'package:applaudo_second_round/features/search/data/datamodels/searchrepo/search_repo.dart';

abstract class SearchRepoState extends Equatable {
  const SearchRepoState();

  @override
  List<Object> get props => [];
}

class SearchRepoInitialState extends SearchRepoState {}

class GetSearchRepoLoadingState extends SearchRepoState {}

class GetSearchRepoPaginatedState extends SearchRepoState {
  final List<Items>? reposItem;
  final int? pageNo;
  const GetSearchRepoPaginatedState(
      {required this.reposItem, required this.pageNo});
  @override
  List<Object> get props => [reposItem!, pageNo!];
}

class GetSearchRepoPaginatedErrorState extends SearchRepoState {
  final String message;

  const GetSearchRepoPaginatedErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
