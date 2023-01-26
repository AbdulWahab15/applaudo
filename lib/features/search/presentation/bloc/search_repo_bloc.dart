import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:applaudo_second_round/core/error/failures.dart';
import 'package:applaudo_second_round/core/utils/sort_extension.dart';
import 'package:applaudo_second_round/features/search/data/datamodels/searchrepo/search_repo.dart';
import 'package:applaudo_second_round/features/search/domain/usecases/search_repo_usecase.dart';
import 'package:applaudo_second_round/features/search/presentation/bloc/search_repo_events.dart';
import 'package:applaudo_second_round/features/search/presentation/bloc/search_repo_states.dart';

class SearchRepoBloc extends Bloc<SearchRepoEvent, SearchRepoState> {
  final SearchRepoUseCase getRepo;
  bool hasMoreData = true;
  int pageNo = 1;
  final List<Items> repos = [];
  SearchRepoBloc({required this.getRepo}) : super(SearchRepoInitialState()) {
    on<SearchRepoEvent>((event, emit) async {
      if (event is SearchRepoPaginatedEvent && hasMoreData) {
        emit(GetSearchRepoLoadingState());
        if (event.keyWords!.isEmpty) {
          emit(const GetSearchRepoPaginatedErrorState(
              message: "Keyword is empty."));
          return;
        }
        final response =
            await getRepo.call(pageNo: pageNo, keyWords: event.keyWords!);
        response.fold(
          (failure) {
            emit(GetSearchRepoPaginatedErrorState(
                message: failure.runtimeType == SerivceFailure
                    ? 'Server Not Responding'
                    : failure.runtimeType == NoInternetException
                        ? 'No Internet connection'
                        : 'Something went wrong!!'));
            hasMoreData = true;
          },
          (searchedItems) {
            hasMoreData = searchedItems.items!.isNotEmpty;
            repos.addAll(searchedItems.items!.toList());
            repos.sortedBy((it) => it.name!);
            emit(GetSearchRepoPaginatedState(
                reposItem: searchedItems.items!, pageNo: pageNo));

            pageNo++;
          },
        );
      } else if (event is SearchRepoInitialEvent) {
        hasMoreData = true;
        pageNo = 1;
        repos.clear();
      }
    });
  }
}
