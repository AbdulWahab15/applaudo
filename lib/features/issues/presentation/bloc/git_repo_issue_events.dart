import 'package:equatable/equatable.dart';

abstract class GitRepoIssuesEvent extends Equatable {
  const GitRepoIssuesEvent();

  @override
  List<Object> get props => [];
}

class GitRepoIssuesEventInitialEvent extends GitRepoIssuesEvent {
  const GitRepoIssuesEventInitialEvent();
}

class GitRepoIssuesPaginatedIssuesEvent extends GitRepoIssuesEvent {
  final String? fullName;
  const GitRepoIssuesPaginatedIssuesEvent({this.fullName});
}
