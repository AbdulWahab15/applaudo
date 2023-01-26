import 'package:equatable/equatable.dart';

abstract class SearchRepoEvent extends Equatable {
  const SearchRepoEvent();

  @override
  List<Object> get props => [];
}
class SearchRepoInitialEvent extends SearchRepoEvent {

  const SearchRepoInitialEvent();
}
class SearchRepoPaginatedEvent extends SearchRepoEvent {
  final String? keyWords;
  const SearchRepoPaginatedEvent({this.keyWords});
}


