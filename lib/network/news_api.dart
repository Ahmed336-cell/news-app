import 'package:dio/dio.dart';
import 'package:news/model/news/news.dart';

class NewsApi{
  final String ApiKey = "4288b50766b64144af28c4801a47e195";
  final Dio dio =  Dio();
  Future<List<NewsArt>>fetchNews(String q)async{
    try{
      final response= await dio.get(
        "https://newsapi.org/v2/everything",
        queryParameters: {
          "q":q,
          "apiKey":ApiKey,
        }
      );
      switch (response.statusCode) {
        case 200:
          final List<dynamic> articles = response.data['articles'];
          return articles.map((json) => NewsArt.fromJson(json)).toList();
        case 400:
          throw Exception('Bad request');
        case 401:
          throw Exception('Unauthorized - Check your API key');
        case 500:
          throw Exception('Server error - Please try again later');
        default:
          throw Exception('Failed to load news: ${response.statusCode}');
      }
    }catch(e){
      throw Exception('Failed to load news: $e');
    }

  }
}