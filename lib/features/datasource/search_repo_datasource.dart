import 'dart:convert';
import 'dart:developer';

import 'package:applaudo_second_round/core/error/failures.dart';
import 'package:applaudo_second_round/core/utils/constants.dart';
import 'package:applaudo_second_round/core/utils/http.dart';
import 'package:applaudo_second_round/features/search/data/datamodels/searchrepo/search_repo.dart';
import 'package:http/http.dart' as http;

abstract class SearchRepoDataSource {
  Future<Repos> getSearchRepos({required int pageNo, required String keyWords});
}

class SearchRepoDataSourceImpl extends SearchRepoDataSource {
  late final http.Client client;
  SearchRepoDataSourceImpl({required this.client});

  @override
  Future<Repos> getSearchRepos(
      {required int pageNo, required String keyWords}) async {
    try {
      final url =
          "${Constants.aDebugBaseUrl}${Constants.searchRepoUrl}?q=$keyWords&sort=name,direction=asc&page=$pageNo&per_page=${Constants.perPage}";
      final response = await HttpCalls.getApiCall(url: url);
      log("URL ${response.request!.url}");
      if (response.statusCode == 200) {
        Map<String, dynamic> resp = jsonDecode(response.body);
        return Repos.fromJson(resp);
      }
    } on NetworkConnectFailure {
      throw NetworkConnectFailure();
    } catch (exp) {
      log(exp.toString());
      throw Exception(exp);
    }
    throw Exception();
  }
}
