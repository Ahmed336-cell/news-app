import 'package:intl/intl.dart';

class NewsArt{
  final String title;
  final String author;
  final String url;
  final String description;
  final String urlToImage;
  final String publishedAt;

  NewsArt(
      {required this.title,
      required this.author,
      required this.url,
      required this.description,
      required this.urlToImage,
      required this.publishedAt});

  factory NewsArt.fromJson(Map<String, dynamic> json){

      DateTime parsedDate = DateTime.parse(json['publishedAt']);
      String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(parsedDate);

      return NewsArt(
        title: json['title'],
        author: json['author'] ??"Unknown",
        url: json['url'],
        description: json['description']?? 'No description available',
        urlToImage: json['urlToImage'] ?? 'https://ih1.redbubble.net/image.4905811447.8675/flat,750x,075,f-pad,750x1000,f8f8f8.jpg',
        publishedAt: formattedDate
    );
  }
}