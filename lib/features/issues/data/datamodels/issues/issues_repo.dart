import 'package:json_annotation/json_annotation.dart';

part 'issues_repo.g.dart';

@JsonSerializable()
class Issues {
  @JsonKey(name: 'total_count')
  int? totalCount;

  @JsonKey(name: 'incomplete_results')
  bool? incompleteResults;

  @JsonKey(name: 'items')
  List<IssuesItems>? items;

  Issues({this.incompleteResults, this.items, this.totalCount});

  factory Issues.fromJson(Map<String, dynamic> json) => _$IssuesFromJson(json);

  Map<String, dynamic> toJson() => _$IssuesToJson(this);
}

@JsonSerializable()
class IssuesItems {
  @JsonKey(name: 'html_url')
  String? htmlUrl;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'score')
  double? score;
  @JsonKey(name: 'user')
  User? user;
  @JsonKey(name: 'git_url')
  String? gitUrl;

  IssuesItems({
    this.htmlUrl,
    this.score,
    this.title,
    this.user,
    this.gitUrl,
  });

  factory IssuesItems.fromJson(Map<String, dynamic> json) =>
      _$IssuesItemsFromJson(json);

  Map<String, dynamic> toJson() => _$IssuesItemsToJson(this);
}

@JsonSerializable()
class User {
  @JsonKey(name: 'avatar_url')
  String? avatarURL;

  User({this.avatarURL});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
