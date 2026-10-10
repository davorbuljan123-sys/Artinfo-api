import 'package:flutter/material.dart';

BottomNavigationBar buildBottomNavigationBar() {
  return BottomNavigationBar(
    backgroundColor: Colors.black,
    selectedItemColor: Colors.teal,
    unselectedItemColor: Colors.white54,
    type: BottomNavigationBarType.fixed,
    currentIndex: 0,
    items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
      BottomNavigationBarItem(icon: Icon(Icons.explore), label: "Discover"),
      BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: "Bookmark"),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
    ],
  );
}
