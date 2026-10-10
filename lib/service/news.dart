import 'package:http/http.dart' as http;
import 'package:webfeed_revived/webfeed.dart'; // Paket za parsiranje RSS-a
import 'package:portal_news/model/article_model.dart';
import 'package:portal_news/service/app_constants.dart';

class News {
  // Lista članaka koju stranice čitaju preko `newsService.news`
  List<ArticleModel> news = [];

  // Metoda koju stranice pozivaju
  Future<void> getNews({String? category}) async {
    try {
      final response = await http.get(Uri.parse(AppConstants.allNews));

      if (response.statusCode == 200) {
        // Parsiramo RSS XML pomoću WebFeed-a
        var channel = RssFeed.parse(response.body);

        // Pretvaramo RSS stavke u tvoj ArticleModel
        news = channel.items?.map((item) {
          // Pokušavamo izvući sliku iz description-a ili enclosure-a ako postoji
          String? imageUrl;
          if (item.enclosure?.url != null) {
            imageUrl = item.enclosure!.url;
          } else if (item.description != null) {
            // Jednostavno traženje tag-a <img src="..."> unutar teksta ako postoji
            final regExp = RegExp(r'src="([^"]+)"');
            final match = regExp.firstMatch(item.description!);
            if (match != null) {
              imageUrl = match.group(1);
            }
          }

          // Ovdje mapiramo na tvoj ArticleModel konstruktor
          // Prilagodi imena polja (title, description, url, urlToImage) prema svom modelu!
          return ArticleModel(
            title: item.title ?? 'Bez naslova',
            description: item.description ?? '',
            url: item.link ?? '',
            urlToImage: imageUrl ?? '',
            publishedAt: item.pubDate?.toString() ?? '',
          );
        }).toList() ?? [];

      } else {
        throw Exception('Neuspješno dohvaćanje RSS feeda: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Greška prilikom parsiranja RSS-a: $e');
    }
  }
}
