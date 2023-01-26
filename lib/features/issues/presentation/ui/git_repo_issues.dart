import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:applaudo_second_round/features/issues/data/datamodels/issues/issues_repo.dart';
import 'package:applaudo_second_round/features/issues/presentation/bloc/git_repo_issue_bloc.dart';
import 'package:applaudo_second_round/features/issues/presentation/bloc/git_repo_issue_events.dart';
import 'package:applaudo_second_round/features/issues/presentation/bloc/git_repo_issue_states.dart';
import 'package:applaudo_second_round/features/search/widgets/lazy_list.dart';
import 'package:applaudo_second_round/features/search/widgets/loading_widget.dart';

class GitReposIssuesListPage extends StatefulWidget {
  const GitReposIssuesListPage({Key? key, required this.fullName})
      : super(key: key);
  final String fullName;

  @override
  State<GitReposIssuesListPage> createState() => _GitReposIssuesListPageState();
}

class _GitReposIssuesListPageState extends State<GitReposIssuesListPage> {
  Future<void> _onRefresh(BuildContext context) async {
    context.read<GitRepoIssuesBloc>().reposIssues.clear();
    BlocProvider.of<GitRepoIssuesBloc>(context, listen: false)
        .add(const GitRepoIssuesEventInitialEvent());
    _loadRepoIssues();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GitRepoIssuesBloc>().reposIssues.clear();
      BlocProvider.of<GitRepoIssuesBloc>(context, listen: false)
          .add(const GitRepoIssuesEventInitialEvent());
      _loadRepoIssues();
    });
    super.initState();
  }

  Future<void> _loadRepoIssues() async {
    BlocProvider.of<GitRepoIssuesBloc>(context)
        .add(GitRepoIssuesPaginatedIssuesEvent(fullName: widget.fullName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildBody());
  }

  Widget _buildBody() {
    return Column(
      children: [
        BlocBuilder<GitRepoIssuesBloc, GitRepoIssuesState>(
          builder: (context, state) {
            if (state is GitIssueRepoLoadingState &&
                context.read<GitRepoIssuesBloc>().reposIssues.isEmpty) {
              return const LoadingWidget();
            } else if (state is GitIssueRepoSuccessState) {
              return Expanded(
                child: RefreshIndicator(
                    onRefresh: () => _onRefresh(context),
                    child: ReposLazyListWidget(
                        data: state.reposItem,
                        loadMoreCallBack:() => _loadRepoIssues(),
                        childType: Issues,
                        hasMore: context.read<GitRepoIssuesBloc>().hasMoreData,
                        onTapCallBack: (key) {})),
              );
            } else if (state is GetIssueRepoErrorState &&
                context.read<GitRepoIssuesBloc>().reposIssues.isEmpty) {
              return Center(child: Text(state.message));
            }
            return Expanded(
              child: RefreshIndicator(
                  onRefresh: () => _onRefresh(context),
                  child: ReposLazyListWidget(
                      data: context.read<GitRepoIssuesBloc>().reposIssues,
                      loadMoreCallBack:() => _loadRepoIssues(),
                      childType: Issues,
                      hasMore: context.read<GitRepoIssuesBloc>().hasMoreData,
                      onTapCallBack: (key) {})),
            );
          },
        ),
      ],
    );
  }

  AppBar _buildAppBar() => AppBar(
      leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.close)),
      title: Text('${widget.fullName} Issues'));
}
