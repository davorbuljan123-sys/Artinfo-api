import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:portal_news/model/article_model.dart';
import 'package:portal_news/service/app_constants.dart';

class News {
  // Lista članaka koju stranice direktno čitaju preko `newsService.news`
  List<ArticleModel> news = [];

  // Metoda koju stranice pozivaju (npr. _newsService.getNews(category: ...))
  Future<void> getNews({String? category}) async {
    try {
      String url = AppConstants.allNews;
      
      // Ako je proslijeđena kategorija, možemo prilagoditi url ili ID
      if (category != null && category.isNotEmpty && category != 'All' && category != 'Sve') {
        // Možeš prilagoditi logiku ako ti kategorija dolazi kao naziv ili ID
        // Ovdje provjeravamo je li proslijeđen broj (ID) ili koristimo opći endpoint
        int? categoryId = int.tryParse(category);
        if (categoryId != null) {
          url = AppConstants.getPostsByCategory(categoryId);
        }
      }

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        news = body
            .map((dynamic item) => ArticleModel.fromJson(item))
            .toList();
      } else {
        throw Exception('Neuspješno dohvaćanje vijesti: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Greška prilikom spajanja na API: $e');
    }
  }
}
