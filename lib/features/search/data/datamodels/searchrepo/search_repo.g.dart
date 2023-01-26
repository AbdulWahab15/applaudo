// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_repo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Repos _$ReposFromJson(Map<String, dynamic> json) => Repos(
      incompleteResults: json['incomplete_results'] as bool?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => Items.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: json['total_count'] as int?,
    );

Map<String, dynamic> _$ReposToJson(Repos instance) => <String, dynamic>{
      'total_count': instance.totalCount,
      'incomplete_results': instance.incompleteResults,
      'items': instance.items,
    };

Items _$ItemsFromJson(Map<String, dynamic> json) => Items(
      fullName: json['full_name'] as String?,
      name: json['name'] as String?,
      id: json['id'] as int?,
      owner: json['owner'] == null
          ? null
          : Owner.fromJson(json['owner'] as Map<String, dynamic>),
      gitUrl: json['git_url'] as String?,
      language: json['language'] as String?,
    );

Map<String, dynamic> _$ItemsToJson(Items instance) => <String, dynamic>{
      'name': instance.name,
      'full_name': instance.fullName,
      'id': instance.id,
      'owner': instance.owner,
      'git_url': instance.gitUrl,
      'language': instance.language,
    };

Owner _$OwnerFromJson(Map<String, dynamic> json) => Owner(
      login: json['login'] as String?,
    );

Map<String, dynamic> _$OwnerToJson(Owner instance) => <String, dynamic>{
      'login': instance.login,
    };
