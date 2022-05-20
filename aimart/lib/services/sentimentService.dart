// import 'dart:developer';

import 'dart:developer';

import 'package:aimart/models/mySVM.dart';
import 'package:dio/dio.dart';

class SentimentService {
  /// Returns 0 - neutral, 1 - positive, -1 -- negative
  static Future<MySvm> getSentiment(String msg) async {
    var dio = Dio();
    Response response = await dio.post(
        'https://us-central1-aimart-1011.cloudfunctions.net/sentiment',
        data: {'data': msg});
    //  log(response.data.toString());
    log(response.data['sentiment'].toString());
    log(response.data['score'].toString());

    String sentiment = response.data['sentiment'].toString();
    String score = response.data['score'].toString();

    int senti = int.tryParse(sentiment) ?? 0;
    int scre = int.tryParse(score) ?? 2;

    return MySvm(score: scre.toDouble(), sentiment: senti);
  }
}
