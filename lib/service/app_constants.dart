class AppConstants {
  // Alternativni Joomla RSS feed link
  static const String allNews = 'https://artinfo.ba/index.php?option=com_content&view=category&format=feed&type=rss';
  
  static String getPostsByCategory(int categoryId) {
    return 'https://artinfo.ba/index.php?option=com_content&view=category&id=$categoryId&format=feed&type=rss';
  }
}
