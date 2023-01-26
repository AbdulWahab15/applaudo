import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:applaudo_second_round/features/issues/presentation/bloc/git_repo_issue_bloc.dart';
import 'package:applaudo_second_round/features/issues/presentation/bloc/git_repo_issue_events.dart';
import 'package:applaudo_second_round/features/issues/presentation/bloc/git_repo_issue_states.dart';
import '../mock_repo/mock_data.dart';
import '../mock_repo/mock_issues_use_case.dart';

void main() {
  group('Search repo bloc test', () {
    late GitRepoIssuesBloc issuesRepoBloc;
    MockIssuesUseCase mockIssueRepo;
    setUpAll(() {
      mockIssueRepo = MockIssuesUseCase();
      issuesRepoBloc = GitRepoIssuesBloc(getRepo: mockIssueRepo);
    });
    blocTest('emit [GetSearchRepoLoadingState ,GetSearchRepoPaginatedState] ',
        build: () => issuesRepoBloc,
        act: (bloc) => bloc.add(
            const GitRepoIssuesPaginatedIssuesEvent(fullName: 'abdul/tournamen')),
        expect: (() => [
              GitIssueRepoLoadingState(),
              GitIssueRepoSuccessState(reposItem: mockIssuesItemsData)
            ]));

    tearDown(() {
      issuesRepoBloc.close();
    });
  });
}


/*
fvm flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
 */