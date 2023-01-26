import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:applaudo_second_round/features/issues/presentation/bloc/git_repo_issue_bloc.dart';
import 'package:applaudo_second_round/features/issues/presentation/bloc/git_repo_issue_events.dart';
import 'package:applaudo_second_round/features/issues/presentation/bloc/git_repo_issue_states.dart';
import 'package:applaudo_second_round/features/issues/presentation/ui/git_repo_issues.dart';
import '../../../helper/helper.dart';
import '../mock_repo/mock_data.dart';

void main() {
  GitRepoIssuesBloc gitIssueBloc;
  MockIssueBloc? mockMyBloc;

  group('Git repo isse ', () {
    setUpAll(() async {
      loadAppFonts();
      registerFallbackValue<GitRepoIssuesEvent>(FakeIssueRepoEvent());
      registerFallbackValue<GitRepoIssuesState>(FakeIssueRepoState());
      mockMyBloc = MockIssueBloc();
      final di = GetIt.instance;
      di.registerFactory<GitRepoIssuesBloc>(() => mockMyBloc!);
      gitIssueBloc = di<GitRepoIssuesBloc>();
    });

    testGoldens('succes state with data', (WidgetTester tester) async {
      when(() => mockMyBloc!.state).thenAnswer((invocation) =>
          GitIssueRepoSuccessState(reposItem: mockIssuesItemsData));
      when(() => mockMyBloc!.hasMoreData).thenAnswer((invocation) => false);
      when(() => mockMyBloc!.reposIssues).thenAnswer((invocation) => []);
      var customWidget = const GitReposIssuesListPage(
        fullName: 'abdul/abdul',
      ).wrapWithMaterialApp();
      await tester.pumpWidgetBuilder(customWidget,
          surfaceSize: const Size(800, 800));
      await tester.pumpAndSettle();
      await screenMatchesGolden(tester, 'issue_list_success_with_data');
    });
    testGoldens('succes state with empty data', (WidgetTester tester) async {
      when(() => mockMyBloc!.hasMoreData).thenAnswer((invocation) => false);
      when(() => mockMyBloc!.state).thenAnswer(
          (invocation) => const GitIssueRepoSuccessState(reposItem: []));
      mockMyBloc!.hasMoreData = true;
      var customWidget = const GitReposIssuesListPage(
        fullName: 'abdul/abdul',
      ).wrapWithMaterialApp();
      await tester.pumpWidgetBuilder(customWidget,
          surfaceSize: const Size(800, 800));
      await tester.pumpAndSettle();
      await screenMatchesGolden(tester, 'issue_list_success_without_data');
    });
  });
}

class MockIssueBloc extends MockCubit<GitRepoIssuesState>
    implements GitRepoIssuesBloc {}

class FakeIssueRepoEvent extends Fake implements GitRepoIssuesEvent {}

class FakeIssueRepoState extends Fake implements GitRepoIssuesState {}
