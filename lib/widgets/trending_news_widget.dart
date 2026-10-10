import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portal_news/model/article_model.dart';
import 'package:portal_news/presentation/pages/detail_pages.dart';

class TrendingNewsWidget extends StatelessWidget {
  final List<ArticleModel> articles;

  const TrendingNewsWidget({Key? key, required this.articles})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];
          final randomViewCount =
              (10000 + (index * 5000) + (index * 700)).toString();
          final formattedViewCount =
              index < 2
                  ? "${(double.parse(randomViewCount) / 1000).toStringAsFixed(1)}K"
                  : "${(double.parse(randomViewCount) / 1000).toStringAsFixed(0)}K";

          final randomLikeCount = (1000 + (index * 200)).toString();
          final formattedLikeCount =
              "${(double.parse(randomLikeCount) / 1000).toStringAsFixed(1)}K";

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsDetailPage(article: article),
                ),
              );
            },
            child: Container(
              width: 300,
              margin: const EdgeInsets.only(left: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(article.urlToImage ?? ""),
                  fit: BoxFit.cover,
                  onError: (_, __) {},
                ),
              ),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                          Colors.black.withOpacity(0.9),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Spacer(),
                        Text(
                          article.title ?? "No Title",
                          style: GoogleFonts.urbanist(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 12),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 10,
                              backgroundColor:
                                  Colors.accents[index % Colors.accents.length],
                              child: Text(
                                (article.author?.isNotEmpty == true)
                                    ? article.author!.substring(
                                      0,
                                      article.author!.length > 2
                                          ? 2
                                          : article.author!.length,
                                    )
                                    : "NA",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                article.author ?? "Unknown Source",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              "${index + 1} days ago",
                              style: TextStyle(
                                color: Colors.white60,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(width: 16),
                            Icon(
                              Icons.remove_red_eye_outlined,
                              color: Colors.white60,
                              size: 14,
                            ),
                            SizedBox(width: 4),
                            Text(
                              formattedViewCount,
                              style: TextStyle(
                                color: Colors.white60,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(width: 16),
                            Icon(
                              Icons.thumb_up_outlined,
                              color: Colors.white60,
                              size: 14,
                            ),
                            SizedBox(width: 4),
                            Text(
                              formattedLikeCount,
                              style: TextStyle(
                                color: Colors.white60,
                                fontSize: 12,
                              ),
                            ),
                            Spacer(),
                            Icon(Icons.share, color: Colors.white60, size: 16),
                            SizedBox(width: 10),
                            Icon(
                              Icons.more_vert,
                              color: Colors.white60,
                              size: 16,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
