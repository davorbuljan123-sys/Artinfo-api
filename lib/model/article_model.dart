class ArticleModel {
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? content;
  final String? author;
  final String? publishedAt;

  ArticleModel({
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.content,
    this.author,
    this.publishedAt,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      title: json['title'],
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      content: json['content'],
      author: json['author'],
      publishedAt: json['publishedAt'],
    );
  }
}
