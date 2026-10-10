import 'package:http/http.dart' as http;
import 'package:xml/xml.dart'; // Uvozimo xml paket
import 'package:portal_news/model/article_model.dart';
import 'package:portal_news/service/app_constants.dart';

class News {
  List<ArticleModel> news = [];

  Future<void> getNews({String? category}) async {
    try {
      final response = await http.get(Uri.parse(AppConstants.allNews));

      if (response.statusCode == 200) {
        // Parsiramo sirovi XML odgovor
        final document = XmlDocument.parse(response.body);
        
        // Dohvaćamo sve <item> elemente unutar RSS-a
        final items = document.findAllElements('item');

        news = items.map((item) {
          final title = item.findElements('title').firstOrNull?.innerText ?? 'Bez naslova';
          final description = item.findElements('description').firstOrNull?.innerText ?? '';
          final link = item.findElements('link').firstOrNull?.innerText ?? '';
          final pubDate = item.findElements('pubDate').firstOrNull?.innerText ?? '';

          // Pokušavamo izvući sliku iz enclosure tag-a ili iz opisa
          String imageUrl = '';
          final enclosure = item.findElements('enclosure').firstOrNull;
          if (enclosure != null && enclosure.getAttribute('url') != null) {
            imageUrl = enclosure.getAttribute('url')!;
          } else {
            // Tražimo prvu sliku unutar opisa (HTML-a)
            final regExp = RegExp(r'src="([^"]+)"');
            final match = regExp.firstMatch(description);
            if (match != null) {
              imageUrl = match.group(1) ?? '';
            }
          }

          return ArticleModel(
            title: title,
            description: description,
            url: link,
            urlToImage: imageUrl,
            publishedAt: pubDate,
          );
        }).toList();

      } else {
        throw Exception('Neuspješno dohvaćanje RSS feeda: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Greška prilikom parsiranja RSS-a: $e');
    }
  }
}
