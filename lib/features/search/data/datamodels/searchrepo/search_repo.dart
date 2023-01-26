import 'package:json_annotation/json_annotation.dart';

part 'search_repo.g.dart';

@JsonSerializable()
class Repos {
  @JsonKey(name: 'total_count')
  int? totalCount;

  @JsonKey(name: 'incomplete_results')
  bool? incompleteResults;

  @JsonKey(name: 'items')
  List<Items>? items;

  Repos({this.incompleteResults, this.items, this.totalCount});

  factory Repos.fromJson(Map<String, dynamic> json) => _$ReposFromJson(json);

  Map<String, dynamic> toJson() => _$ReposToJson(this);
}

@JsonSerializable()
class Items {
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'full_name')
  String? fullName;
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'owner')
  Owner? owner;
  @JsonKey(name: 'git_url')
  String? gitUrl;

  @JsonKey(name: 'language')
  String? language;

  Items(
      {this.fullName,
      this.name,
      this.id,
      this.owner,
      this.gitUrl,
      this.language});

  factory Items.fromJson(Map<String, dynamic> json) => _$ItemsFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsToJson(this);
}

@JsonSerializable()
class Owner {
  @JsonKey(name: 'login')
  String? login;

  Owner({this.login});

  factory Owner.fromJson(Map<String, dynamic> json) => _$OwnerFromJson(json);

  Map<String, dynamic> toJson() => _$OwnerToJson(this);
}
