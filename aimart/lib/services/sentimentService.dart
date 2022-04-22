
// import 'dart:developer';

import 'dart:developer';

import 'package:aimart/models/mySVM.dart';
import 'package:dio/dio.dart';

class SentimentService {
 
 /// Returns 0 - neutral, 1 - positive, -1 -- negative
 static Future<MySvm> getSentiment(String msg)async{

   var dio = Dio();
   Response response = await dio.post('https://us-central1-aimart-1011.cloudfunctions.net/sentiment',data: {'data': msg});
  //  log(response.data.toString());
   log(response.data['sentiment'].toString());
   log(response.data['score'].toString());

   return MySvm(score: response.data['score'], sentiment: response.data['sentiment']??0);
 }

}