import 'dart:convert';
import 'dart:developer';

import 'package:applaudo_second_round/core/error/failures.dart';
import 'package:applaudo_second_round/core/utils/constants.dart';
import 'package:applaudo_second_round/core/utils/http.dart';
import 'package:applaudo_second_round/features/issues/data/datamodels/issues/issues_repo.dart';
import 'package:http/http.dart' as http;

abstract class IssueRepoDataSource {
  Future<Issues> getSearchReposIssues(
      {required int pageNo, required String fullName});
}

class IssuesRepoDataSourceImpl extends IssueRepoDataSource {
  late final http.Client client;
  IssuesRepoDataSourceImpl({
    required this.client,
  });

  @override
  Future<Issues> getSearchReposIssues(
      {required int pageNo, required String fullName}) async {
    try {
      final url =
          "${Constants.aDebugBaseUrl}${Constants.searchRepoIssuesUrl}?q=$fullName&sort,order,per_page,page,order&page=$pageNo&per_page=${Constants.perPage}";
      final response = await HttpCalls.getApiCall(url: url);

      log("URL ${response.request!.url}");
      if (response.statusCode == 200) {
        Map<String, dynamic> resp = jsonDecode(response.body);
        return Issues.fromJson(resp);
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
