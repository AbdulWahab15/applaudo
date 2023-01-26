import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:applaudo_second_round/features/search/presentation/bloc/search_repo_bloc.dart';
import 'package:applaudo_second_round/features/search/presentation/bloc/search_repo_events.dart';
import 'package:applaudo_second_round/features/search/presentation/bloc/search_repo_states.dart';
import 'package:applaudo_second_round/features/search/presentation/ui/search_repo.dart';

import '../../../helper/helper.dart';
import '../mock_repo/mock_data.dart';

void main() {
  SearchRepoBloc searchRepoBloc;
  MockSearchBloc? mockSearchBloc;
  group('Git repo list ', () {
    setUpAll(() async {
      loadAppFonts();
      registerFallbackValue<SearchRepoEvent>(FakeSearchRepoEvent());
      registerFallbackValue<SearchRepoState>(FakeIssueRepoState());
      mockSearchBloc = MockSearchBloc();
      final di = GetIt.instance;
      di.registerFactory<SearchRepoBloc>(() => mockSearchBloc!);
      searchRepoBloc = di<SearchRepoBloc>();
    });

    testGoldens('succes state with data', (WidgetTester tester) async {
      mockSearchBloc!.hasMoreData = false;
      when(() => mockSearchBloc!.hasMoreData).thenAnswer((invocation) => false);

      when(() => mockSearchBloc!.state).thenAnswer((invocation) =>
          GetSearchRepoPaginatedState(reposItem: mockRepoItemsData, pageNo: 2));

      var customWidget = const GitReposListPage(
        title: 'Git Repositories',
      ).wrapWithMaterialApp();

      await tester.pumpWidgetBuilder(customWidget,
          surfaceSize: const Size(800, 800));
      await tester.pumpAndSettle(const Duration(seconds: 4));

      await screenMatchesGolden(tester, 'repo_list_success_with_data');
    });
  });
}

class MockSearchBloc extends MockCubit<SearchRepoState>
    implements SearchRepoBloc {}

class FakeSearchRepoEvent extends Fake implements SearchRepoEvent {}

class FakeIssueRepoState extends Fake implements SearchRepoState {}
