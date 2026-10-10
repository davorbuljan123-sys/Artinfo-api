class AppConstants {
  // Osnovni API URL za artinfo.ba
  static const String baseUrl = 'https://artinfo.ba/wp-json/wp/v2/';

  // Endpoint za sve vijesti
  static const String allNews = '${baseUrl}posts?_embed';

  // Metoda za dinamičko generiranje linka prema ID-ju kategorije
  static String getPostsByCategory(int categoryId) {
    return '${baseUrl}posts?categories=$categoryId&_embed';
  }
}
