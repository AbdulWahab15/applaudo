import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:applaudo_second_round/based_injection/di.dart' as di;
import 'package:applaudo_second_round/features/issues/presentation/bloc/git_repo_issue_bloc.dart';
import 'package:applaudo_second_round/features/issues/presentation/bloc/git_repo_issue_events.dart';
import 'package:applaudo_second_round/features/search/presentation/bloc/search_repo_bloc.dart';
import 'package:applaudo_second_round/features/search/presentation/bloc/search_repo_events.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  return GoldenToolkit.runWithConfiguration(
    () async {
      await loadAppFonts();
      await testMain();
    },
    config: GoldenToolkitConfiguration(
      skipGoldenAssertion: () => !Platform.isMacOS,
    ),
  );
}

extension TestWidgetWrapper on Widget {
  Widget wrapWithMaterialApp() {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) =>
                di.sl<SearchRepoBloc>()..add(const SearchRepoInitialEvent())),
        BlocProvider(
            create: (_) => di.sl<GitRepoIssuesBloc>()
              ..add(const GitRepoIssuesEventInitialEvent())),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: this,
      ),
    );
  }
}
