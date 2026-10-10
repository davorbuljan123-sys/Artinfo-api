import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart'; // Korištenje standardnog webfeed paketa
import 'package:portal_news/model/article_model.dart';
import 'package:portal_news/service/app_constants.dart';

class News {
  List<ArticleModel> news = [];

  Future<void> getNews({String? category}) async {
    try {
      final response = await http.get(Uri.parse(AppConstants.allNews));

      if (response.statusCode == 200) {
        // Parsiramo RSS XML pomoću WebFeed-a
        var channel = RssFeed.parse(response.body);

        news = channel.items?.map((item) {
          String? imageUrl;
          if (item.enclosure?.url != null) {
            imageUrl = item.enclosure!.url;
          } else if (item.description != null) {
            final regExp = RegExp(r'src="([^"]+)"');
            final match = regExp.firstMatch(item.description!);
            if (match != null) {
              imageUrl = match.group(1);
            }
          }

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
