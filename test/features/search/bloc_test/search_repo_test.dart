import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:applaudo_second_round/features/search/presentation/bloc/search_repo_bloc.dart';
import 'package:applaudo_second_round/features/search/presentation/bloc/search_repo_events.dart';
import 'package:applaudo_second_round/features/search/presentation/bloc/search_repo_states.dart';

import '../mock_repo/mock_data.dart';
import '../mock_repo/mock_use_case.dart';

void main() {
  group('Search repo bloc test', () {
    late SearchRepoBloc searchRepoBloc;
    MockSearcUseCase mockSearcRepo;
    setUpAll(() {
      mockSearcRepo = MockSearcUseCase();
      searchRepoBloc = SearchRepoBloc(getRepo: mockSearcRepo);
    });
    blocTest('emit [GetSearchRepoLoadingState ,GetSearchRepoPaginatedState] ',
        build: () => searchRepoBloc,
        act: (bloc) =>
            bloc.add(const SearchRepoPaginatedEvent(keyWords: 'abdul')),
        expect: (() => [
              GetSearchRepoLoadingState(),
              GetSearchRepoPaginatedState(
                  pageNo: 1, reposItem: mockRepoItemsData)
            ]));

    blocTest('emit [] on clear bloc values.',
        build: () => searchRepoBloc,
        act: (bloc) => bloc.add(const SearchRepoInitialEvent()),
        expect: (() => []));

    tearDown(() {
      searchRepoBloc.close();
    });
  });
}

/*
fvm flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
 */
