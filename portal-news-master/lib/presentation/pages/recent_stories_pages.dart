import 'package:flutter/material.dart';
import 'package:portal_news/model/article_model.dart';
import 'package:portal_news/service/news.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RecentStoriesPage extends StatefulWidget {
  const RecentStoriesPage({Key? key, required List<ArticleModel> articles})
    : super(key: key);

  @override
  _RecentStoriesPageState createState() => _RecentStoriesPageState();
}

class _RecentStoriesPageState extends State<RecentStoriesPage> {
  String selectedCategory = "All";
  final List<String> categories = ["All", "Politics", "Technology", "Business"];
  List<ArticleModel> articles = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    setState(() {
      isLoading = true;
    });

    News newsService = News();
    await newsService.getNews(category: selectedCategory);

    setState(() {
      articles = newsService.news;
      isLoading = false;
    });
  }

  String _formatTime(String? time) {
    if (time == null) return "Unknown";
    return DateFormat("h:mm a").format(DateTime.parse(time));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Recent Stories",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                    categories.map((category) {
                      bool isSelected = category == selectedCategory;
                      return GestureDetector(
                        onTap: () {
                          if (category != selectedCategory) {
                            setState(() {
                              selectedCategory = category;
                            });
                            fetchNews();
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.teal : Colors.black,
                            border: Border.all(color: Colors.white30),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            category,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.white60,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),
          ),

          Expanded(
            child:
                isLoading
                    ? const Center(
                      child: CircularProgressIndicator(color: Colors.teal),
                    )
                    : articles.isEmpty
                    ? const Center(
                      child: Text(
                        "No recent stories found.",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    )
                    : ListView.builder(
                      padding: const EdgeInsets.all(10),
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        final article = articles[index];

                        return Card(
                          color: Colors.grey[900],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        article.title ?? "No Title",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          const Icon(
                                            FontAwesomeIcons.user,
                                            size: 12,
                                            color: Colors.white54,
                                          ),
                                          const SizedBox(width: 5),
                                          Expanded(
                                            child: Text(
                                              article.author ?? "Unknown",
                                              style: const TextStyle(
                                                color: Colors.white70,
                                                fontSize: 12,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          const Icon(
                                            FontAwesomeIcons.clock,
                                            size: 12,
                                            color: Colors.white54,
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            _formatTime(article.publishedAt),
                                            style: const TextStyle(
                                              color: Colors.white54,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    article.urlToImage ?? "",
                                    width: 100,
                                    height: 80,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: 100,
                                        height: 80,
                                        color: Colors.grey,
                                        child: const Icon(
                                          Icons.image,
                                          color: Colors.white,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Column(
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        FontAwesomeIcons.shareNodes,
                                        color: Colors.white54,
                                        size: 16,
                                      ),
                                      onPressed: () {},
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.more_vert,
                                        color: Colors.white54,
                                        size: 16,
                                      ),
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
