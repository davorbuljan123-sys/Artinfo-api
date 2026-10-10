import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:portal_news/model/article_model.dart';

class NewsService {
  // Postavljen službeni API izvor za artinfo.ba
  static const String baseUrl = 'https://artinfo.ba/wp-json/wp/v2/';

  Future<List<ArticleModel>> fetchArticles() async {
    try {
      final response = await http.get(Uri.parse('${baseUrl}posts?_embed'));

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

  Future<List<ArticleModel>> fetchArticlesByCategory(int categoryId) async {
    try {
      final response = await http.get(Uri.parse('${baseUrl}posts?categories=$categoryId&_embed'));

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
