
class SentimentService {
 
 /// Returns 0 - neutral, 1 - positive, -1 -- negative
 static Future<int> getSentiment(String msg)async{
   Future.delayed(Duration(milliseconds: 300));
   return 1;
 }

}