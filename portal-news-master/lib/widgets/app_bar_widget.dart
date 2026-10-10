import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar buildAppBar() {
  return AppBar(
    backgroundColor: Colors.black,
    elevation: 0,
    automaticallyImplyLeading: false,
    title: Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundImage: const NetworkImage(
            "https://upload.wikimedia.org/wikipedia/commons/c/c4/Mark_Zuckerberg_F8_2018_Keynote_%28cropped%29.jpg",
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Welcome back",
                    style: GoogleFonts.urbanist(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(width: 4),
                  Text("👋", style: TextStyle(fontSize: 14)),
                ],
              ),
              Text(
                "mark zuckerberg",
                style: GoogleFonts.playfair(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey[900],
            shape: BoxShape.circle,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              const Icon(
                Icons.notifications_outlined,
                color: Colors.white,
                size: 24,
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
