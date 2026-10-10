import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';
import 'package:portal_news/model/article_model.dart';
import 'package:portal_news/service/app_constants.dart';

class News {
  List<ArticleModel> news = [];

  Future<void> getNews({String? category}) async {
    try {
      final response = await http.get(Uri.parse(AppConstants.allNews));

      if (response.statusCode == 200) {
        final document = XmlDocument.parse(response.body);
        
        // Podržavamo i <item> (RSS) i <entry> (Atom feed) za svaki slučaj
        var elements = document.findAllElements('item').toList();
        if (elements.isEmpty) {
          elements = document.findAllElements('entry').toList();
        }

        news = elements.map((node) {
          // Pomoćna funkcija za sigurno traženje teksta u tagovima
          String getElementText(String name) {
            try {
              return node.findElements(name).firstOrNull?.innerText ?? '';
            } catch (_) {
              return '';
            }
          }

          final title = getElementText('title');
          final description = getElementText('description').isEmpty 
              ? getElementText('summary') 
              : getElementText('description');
              
          // Link može biti element ili atribut u <link href="...">
          String link = getElementText('link');
          if (link.isEmpty) {
            try {
              link = node.findElements('link').firstOrNull?.getAttribute('href') ?? '';
            } catch (_) {}
          }

          final pubDate = getElementText('pubDate').isEmpty 
              ? getElementText('updated') 
              : getElementText('pubDate');

          // Traženje slike
          String imageUrl = '';
          try {
            final enclosure = node.findElements('enclosure').firstOrNull;
            if (enclosure != null) {
              imageUrl = enclosure.getAttribute('url') ?? '';
            }
          } catch (_) {}

          if (imageUrl.isEmpty) {
            try {
              final media = node.findElements('media:content').firstOrNull;
              if (media != null) {
                imageUrl = media.getAttribute('url') ?? '';
              }
            } catch (_) {}
          }

          if (imageUrl.isEmpty && description.isNotEmpty) {
            final regExp = RegExp(r'src="([^"]+)"');
            final match = regExp.firstMatch(description);
            if (match != null) {
              imageUrl = match.group(1) ?? '';
            }
          }

          return ArticleModel(
            title: title.isNotEmpty ? title.trim() : 'Bez naslova',
            description: description.replaceAll(RegExp(r'<[^>]*>'), '').trim(),
            url: link.trim(),
            urlToImage: imageUrl.trim(),
            publishedAt: pubDate.trim(),
          );
        }).toList();

      }
    } catch (e) {
      print('Greška: $e');
      news = [];
    }
  }
}
