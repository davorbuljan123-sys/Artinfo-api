import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:portal_news/model/article_model.dart';
import 'package:portal_news/service/app_constants.dart';

class NewsService {
  // Dohvat svih članaka s artinfo.ba
  Future<List<ArticleModel>> fetchArticles() async {
    try {
      final response = await http.get(Uri.parse(AppConstants.allNews));

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        List<ArticleModel> articles = body
            .map((dynamic item) => ArticleModel.fromJson(item))
            .toList();
        return articles;
      } else {
        throw Exception('Neuspješno dohvaćanje vijesti: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Greška prilikom spajanja na API: $e');
    }
  }

  // Dohvat članaka prema ID-ju specifične kategorije s artinfo.ba
  Future<List<ArticleModel>> fetchArticlesByCategory(int categoryId) async {
    try {
      final endpoint = AppConstants.getPostsByCategory(categoryId);
      final response = await http.get(Uri.parse(endpoint));

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        List<ArticleModel> articles = body
            .map((dynamic item) => ArticleModel.fromJson(item))
            .toList();
        return articles;
      } else {
        throw Exception('Neuspješno dohvaćanje kategorije: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Greška prilikom spajanja na API: $e');
    }
  }
}
