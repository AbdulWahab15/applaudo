// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issues_repo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Issues _$IssuesFromJson(Map<String, dynamic> json) => Issues(
      incompleteResults: json['incomplete_results'] as bool?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => IssuesItems.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: json['total_count'] as int?,
    );

Map<String, dynamic> _$IssuesToJson(Issues instance) => <String, dynamic>{
      'total_count': instance.totalCount,
      'incomplete_results': instance.incompleteResults,
      'items': instance.items,
    };

IssuesItems _$IssuesItemsFromJson(Map<String, dynamic> json) => IssuesItems(
      htmlUrl: json['html_url'] as String?,
      score: (json['score'] as num?)?.toDouble(),
      title: json['title'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      gitUrl: json['git_url'] as String?,
    );

Map<String, dynamic> _$IssuesItemsToJson(IssuesItems instance) =>
    <String, dynamic>{
      'html_url': instance.htmlUrl,
      'title': instance.title,
      'score': instance.score,
      'user': instance.user,
      'git_url': instance.gitUrl,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      avatarURL: json['avatar_url'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'avatar_url': instance.avatarURL,
    };
