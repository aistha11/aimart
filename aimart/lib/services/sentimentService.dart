
// import 'dart:developer';

import 'package:dio/dio.dart';

class SentimentService {
 
 /// Returns 0 - neutral, 1 - positive, -1 -- negative
 static Future<int> getSentiment(String msg)async{

   var dio = Dio();
   Response response = await dio.post('https://us-central1-aimart-1011.cloudfunctions.net/sentiment',data: {'data': msg});
  //  log(response.data.toString());
  //  log(response.data['sentiment'].toString());
   return response.data['sentiment'];
 }

}