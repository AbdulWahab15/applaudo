import 'package:equatable/equatable.dart';
import 'package:applaudo_second_round/features/issues/data/datamodels/issues/issues_repo.dart';

abstract class GitRepoIssuesState extends Equatable {
  const GitRepoIssuesState();

  @override
  List<Object> get props => [];
}

class GitIssueRepoLoadingState extends GitRepoIssuesState {}

class GitIssueRepoSuccessState extends GitRepoIssuesState {
  final List<IssuesItems> reposItem;
  const GitIssueRepoSuccessState({required this.reposItem});
}

class GetIssueRepoErrorState extends GitRepoIssuesState {
  final String message;

  const GetIssueRepoErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
