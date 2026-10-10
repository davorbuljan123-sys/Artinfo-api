import 'package:flutter/material.dart';

class AppConstants {
  static const Color primaryColor = Colors.teal;
  static const Color backgroundColor = Colors.black;
  static const Color cardBackgroundColor = Color(0xFF212121);
  static const Color secondaryTextColor = Colors.white60;

  static const TextStyle headerTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle titleTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle subtitleTextStyle = TextStyle(
    color: Colors.white70,
    fontSize: 14,
  );

  static const TextStyle captionTextStyle = TextStyle(
    color: Colors.white60,
    fontSize: 12,
  );

  static const List<String> newsCategories = [
    "All",
    "Politics",
    "Technology",
    "Business",
  ];

  static const String noNewsErrorMessage = "No news found.";
  static const String networkErrorMessage = "Network error. Please try again.";

  static const Duration transitionDuration = Duration(milliseconds: 300);

  static const double cardBorderRadius = 12.0;
  static const EdgeInsets defaultPadding = EdgeInsets.all(16.0);
}
