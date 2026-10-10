import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:portal_news/model/article_model.dart';

class News {
  List<ArticleModel> news = [];

  final String _apiKey = "YOUR_API_KEY";

  Future<void> getNews({String category = ""}) async {
    String url;
    switch (category) {
      case "Business":
        url =
            "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=$_apiKey";
        break;
      case "Technology":
        url =
            "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=$_apiKey";
        break;
      case "Politics":
        url =
            "https://newsapi.org/v2/everything?domains=wsj.com&apiKey=$_apiKey";
        break;
      default:
        url =
            "https://newsapi.org/v2/everything?q=apple&from=2025-03-15&to=2025-03-15&sortBy=popularity&apiKey=$_apiKey";
        break;
    }

    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode != 200) {
        throw Exception('Failed to load news: ${response.statusCode}');
      }

      var jsonData = jsonDecode(response.body);

      news.clear();

      if (jsonData['status'] == 'ok') {
        jsonData["articles"].forEach((element) {
          if (element["urlToImage"] != null) {
            ArticleModel articleModel = ArticleModel(
              title: element['title'],
              description: element['description'],
              url: element['url'],
              urlToImage: element['urlToImage'],
              content: element['content'],
              author: element['author'],
              publishedAt: element['publishedAt'],
            );
            news.add(articleModel);
          }
        });
      }
    } catch (e) {
      print("Error fetching news: $e");
    }
  }
}

class CategoryModel {
  final String? categoryName;
  final String? image;

  CategoryModel({this.categoryName, this.image});
}
