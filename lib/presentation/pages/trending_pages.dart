import 'package:flutter/material.dart';
import 'package:portal_news/model/article_model.dart';
import 'package:intl/intl.dart';

class TrendingPage extends StatelessWidget {
  final List<ArticleModel> articles;

  const TrendingPage({Key? key, required this.articles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Trending',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white, size: 28),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 12),
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];
          return _buildArticleItem(context, article);
        },
      ),
    );
  }

  Widget _buildArticleItem(BuildContext context, ArticleModel article) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        article.title ?? "No Title",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          height: 1.3,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        _buildSourceIcon(article.author),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            article.author ?? "Unknown",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _buildMetadataRow(article),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  width: 120,
                  height: 120,
                  child:
                      article.urlToImage != null &&
                              article.urlToImage!.isNotEmpty
                          ? Image.network(
                            article.urlToImage!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                            errorBuilder:
                                (context, error, stackTrace) => Image.asset(
                                  'assets/placeholder.jpg',
                                  fit: BoxFit.cover,
                                ),
                          )
                          : Image.asset(
                            'assets/placeholder.jpg',
                            fit: BoxFit.cover,
                          ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.share_outlined, color: Colors.white),
                onPressed: () {},
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              IconButton(
                icon: const Icon(Icons.more_vert, color: Colors.white),
                onPressed: () {},
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          const Divider(color: Colors.grey, height: 24),
        ],
      ),
    );
  }

  Widget _buildSourceIcon(String? author) {
    Widget icon;

    if (author == null || author.isEmpty) {
      icon = CircleAvatar(
        radius: 12,
        backgroundColor: Colors.grey,
        child: const Text(
          "?",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      );
    } else {
      icon = CircleAvatar(
        radius: 12,
        backgroundColor: Colors.blue,
        child: Text(
          author[0].toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      );
    }

    return icon;
  }

  Widget _buildMetadataRow(ArticleModel article) {
    String timeAgo = "Unknown";
    if (article.publishedAt != null) {
      try {
        final publishDate = DateTime.parse(article.publishedAt!);
        final now = DateTime.now();
        final difference = now.difference(publishDate);

        if (difference.inDays < 1) {
          timeAgo = "Today";
        } else {
          timeAgo = "${difference.inDays} days ago";
        }
      } catch (e) {
        timeAgo = "Invalid date";
      }
    }
    final viewCount = (article.publishedAt?.hashCode.abs() ?? 0) % 300 + 100;
    final formattedViews = NumberFormat.compact().format(viewCount * 1000);

    final commentCount = (article.title?.hashCode.abs() ?? 0) % 5 + 1;
    final formattedComments = NumberFormat.compact().format(
      commentCount * 1000,
    );

    return Row(
      children: [
        Text(timeAgo, style: const TextStyle(color: Colors.grey, fontSize: 14)),
        const SizedBox(width: 12),
        const Icon(Icons.visibility_outlined, color: Colors.grey, size: 18),
        const SizedBox(width: 4),
        Text(
          formattedViews,
          style: const TextStyle(color: Colors.grey, fontSize: 14),
        ),
        const SizedBox(width: 12),
        const Icon(Icons.chat_bubble_outline, color: Colors.grey, size: 16),
        const SizedBox(width: 4),
        Text(
          formattedComments,
          style: const TextStyle(color: Colors.grey, fontSize: 14),
        ),
      ],
    );
  }
}
