import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:applaudo_second_round/core/utils/constants.dart';
import 'package:applaudo_second_round/features/issues/presentation/ui/git_repo_issues.dart';
import 'package:applaudo_second_round/features/search/data/datamodels/searchrepo/search_repo.dart';
import 'package:applaudo_second_round/features/search/presentation/bloc/search_repo_bloc.dart';
import 'package:applaudo_second_round/features/search/presentation/bloc/search_repo_events.dart';
import 'package:applaudo_second_round/features/search/presentation/bloc/search_repo_states.dart';
import 'package:applaudo_second_round/features/search/widgets/lazy_list.dart';
import 'package:applaudo_second_round/features/search/widgets/loading_widget.dart';

class GitReposListPage extends StatefulWidget {
  const GitReposListPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<GitReposListPage> createState() => _GitReposListPageState();
}

class _GitReposListPageState extends State<GitReposListPage> {
  final TextEditingController _searchCont = TextEditingController();
  List<Items>? data = [];
  Future<void> _onRefresh(BuildContext context) async {
    context.read<SearchRepoBloc>().repos.clear();
    _fetchRepoData();
  }

  @override
  void dispose() {
    data!.clear();
    super.dispose();
  }

  Future<void> _fetchRepoData() async {
    BlocProvider.of<SearchRepoBloc>(context, listen: false)
        .add(SearchRepoPaginatedEvent(keyWords: _searchCont.text));
  }

  Future<void> _clearBloc() async {
    data!.clear();
    BlocProvider.of<SearchRepoBloc>(context, listen: false)
        .add(const SearchRepoInitialEvent());
  }

  Future<void> _naviagteToIssue(String fullName) async {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) =>
            GitReposIssuesListPage(fullName: fullName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildBody());
  }

  Widget _buildBody() {
    var moreData = context.watch<SearchRepoBloc>().hasMoreData;
    return Column(
      children: [
        _buildSearchFieldWidget(),
        BlocBuilder<SearchRepoBloc, SearchRepoState>(
          builder: (context, state) {
            if (state is GetSearchRepoLoadingState &&
                context.read<SearchRepoBloc>().repos.isEmpty) {
              return const LoadingWidget();
            } else if (state is GetSearchRepoPaginatedState) {
              data!.addAll(state.reposItem!);
              return _buildRepoList(data!, moreData);
            } else if (state is GetSearchRepoPaginatedErrorState &&
                context.read<SearchRepoBloc>().repos.isEmpty) {
              return Center(child: Text(state.message));
            }
            return _buildRepoList(data!, moreData);
          },
        ),
      ],
    );
  }

  Widget _buildRepoList(List<Items> data, bool moreData) {
    return Expanded(
      child: RefreshIndicator(
          onRefresh: () => _onRefresh(context),
          child: ReposLazyListWidget(
              data: data,
              loadMoreCallBack: () => _fetchRepoData(),
              onTapCallBack: (key) => _naviagteToIssue(key),
              hasMore: moreData,
              childType: Repos)),
    );
  }

  Widget _buildSearchFieldWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: (value) {
          if (value.length == Constants.searchMaxLength) {
            log("start search");
            FocusScope.of(context).unfocus();
            _clearBloc();
            _fetchRepoData();
          }
        },
        controller: _searchCont,
        maxLength: Constants.searchMaxLength,
        decoration: const InputDecoration(
            labelText: "Search",
            hintText: "Search",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)))),
      ),
    );
  }

  AppBar _buildAppBar() => AppBar(title: const Text('Git Repo'));
}
