import 'package:flutter/material.dart';
import 'package:portal_news/model/article_model.dart';
import 'package:intl/intl.dart';

class NewsDetailPage extends StatelessWidget {
  final ArticleModel article;

  const NewsDetailPage({Key? key, required this.article}) : super(key: key);

  String _formatTime(String? time) {
    if (time == null) return "Unknown";
    return DateFormat("d MMM yyyy, h:mm a").format(DateTime.parse(time));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.share, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            article.urlToImage != null
                ? Image.network(
                  article.urlToImage!,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                )
                : Container(
                  width: double.infinity,
                  height: 250,
                  color: Colors.grey[900],
                  child: const Center(
                    child: Icon(Icons.image, color: Colors.white54, size: 50),
                  ),
                ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title ?? "No Title",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          article.author ?? "Unknown Author",
                          style: TextStyle(
                            color: Colors.teal[300],
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        _formatTime(article.publishedAt),
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(
                        Icons.visibility,
                        color: Colors.white54,
                        size: 16,
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        "2.5k",
                        style: TextStyle(color: Colors.white54, fontSize: 14),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  Text(
                    article.description ?? "No Description Available.",
                    style: const TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(height: 10),

                  Text(
                    article.content ?? "",
                    style: const TextStyle(color: Colors.white70, fontSize: 16),
                  ),

                  const SizedBox(height: 20),
                  const Divider(color: Colors.white24),
                  Wrap(
                    spacing: 10,
                    children: [
                      _buildTag("Politics"),
                      _buildTag("Corruption"),
                      _buildTag("Investigation"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.teal[700],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 14),
      ),
    );
  }
}
