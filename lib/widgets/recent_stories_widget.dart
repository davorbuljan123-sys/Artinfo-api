import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portal_news/model/article_model.dart';
import 'package:portal_news/presentation/pages/detail_pages.dart';

class RecentStoriesWidget extends StatelessWidget {
  final List<ArticleModel> articles;

  const RecentStoriesWidget({Key? key, required this.articles})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: articles.length,
      itemBuilder: (context, index) {
        final article = articles[index];
        final viewCount = 100 + (index * 200) + (index * 70);
        String formattedViewCount = viewCount.toString();
        if (viewCount > 1000) {
          formattedViewCount = "${(viewCount / 1000).toStringAsFixed(1)}K";
        }

        final commentCount = index + 2;

        return Container(
          margin: EdgeInsets.only(bottom: 16),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsDetailPage(article: article),
                ),
              );
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                            SizedBox(height: 8),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 10,
                                  backgroundColor:
                                      Colors.primaries[index %
                                          Colors.primaries.length],
                                  child: Text(
                                    article.author?.substring(
                                          0,
                                          article.author!.length.clamp(1, 2),
                                        ) ??
                                        "?",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 8,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    article.author ?? "Unknown Author",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Text(
                                  "${index % 3 + 1} ${index % 3 == 0 ? "min" : "mins"} ago",
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
                                  Icons.chat_bubble_outline,
                                  color: Colors.white60,
                                  size: 14,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  commentCount.toString(),
                                  style: TextStyle(
                                    color: Colors.white60,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 16),
                      Container(
                        width: 96,
                        height: 96,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(article.urlToImage ?? ""),
                            fit: BoxFit.cover,
                            onError: (_, __) {},
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.share, color: Colors.white60, size: 18),
                      SizedBox(width: 16),
                      Icon(Icons.more_vert, color: Colors.white60, size: 18),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
