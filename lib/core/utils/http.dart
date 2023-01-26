import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:applaudo_second_round/core/error/failures.dart';
import 'package:applaudo_second_round/core/utils/constants.dart';
import 'package:http/http.dart' as client;

class HttpCalls {
  //Get Api calls
  static Future<Response> getApiCall({required String url}) async {
    final bool connectionChecker =
        await InternetConnectionChecker().hasConnection;
    if (!connectionChecker) {
      throw NetworkConnectFailure();
    }
    final resp = await client.get(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      "Token": Constants.token
    });
    return resp;
  }

  //post call
  //put call
}
