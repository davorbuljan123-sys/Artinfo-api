import 'package:flutter/material.dart';

import 'package:portal_news/model/article_model.dart';

import 'package:portal_news/presentation/pages/recent_stories_pages.dart';
import 'package:portal_news/presentation/pages/trending_pages.dart';
import 'package:portal_news/service/news.dart';
import 'package:portal_news/widgets/app_bar_widget.dart';
import 'package:portal_news/widgets/category_filter_widget.dart';
import 'package:portal_news/widgets/recent_stories_widget.dart';
import 'package:portal_news/widgets/section_header_widget.dart';
import 'package:portal_news/widgets/shimmer_loading_widget.dart';
import 'package:portal_news/widgets/trending_news_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<ArticleModel>> _newsFuture;
  String _selectedCategory = "All";
  final News _newsService = News();

  static const List<String> _categories = [
    "All",
    "Politics",
    "Technology",
    "Business",
  ];
  static const String _errorMessage = "No news found.";

  @override
  void initState() {
    super.initState();
    _newsFuture = _fetchNews();
  }

  Future<List<ArticleModel>> _fetchNews({String category = ""}) async {
    await _newsService.getNews(category: category);
    return _newsService.news;
  }

  void _changeCategory(String category) {
    if (_selectedCategory != category) {
      setState(() {
        _selectedCategory = category;
        _newsFuture = _fetchNews(category: category == "All" ? "" : category);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: buildAppBar(),
      body: SafeArea(
        child: FutureBuilder<List<ArticleModel>>(
          future: _newsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return ShimmerLoadingWidget();
            }

            if (snapshot.hasError ||
                !snapshot.hasData ||
                snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            final articles = snapshot.data!;
            return _buildNewsContent(articles);
          },
        ),
      ),
    );
  }

  Widget _buildNewsContent(List<ArticleModel> articles) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeaderWidget(
            title: "Trending",
            onViewAllPressed: () {
              _navigateToPage(TrendingPage(articles: articles));
            },
          ),
          const SizedBox(height: 10),
          TrendingNewsWidget(articles: articles.take(5).toList()),
          const SizedBox(height: 20),
          SectionHeaderWidget(
            title: "Recent Stories",
            onViewAllPressed: () {
              _navigateToPage(RecentStoriesPage(articles: articles));
            },
          ),
          CategoryFilterWidget(
            categories: _categories,
            selectedCategory: _selectedCategory,
            onCategoryChanged: _changeCategory,
          ),
          RecentStoriesWidget(articles: articles),
        ],
      ),
    );
  }

  void _navigateToPage(Widget page) {
    _newsFuture
        .then((articles) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        })
        .catchError((error) {
          print("Error fetching articles: $error");
        });
  }
}
