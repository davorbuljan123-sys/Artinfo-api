import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LandingPages extends StatefulWidget {
  const LandingPages({super.key});

  @override
  State<LandingPages> createState() => _LandingPagesState();
}

class _LandingPagesState extends State<LandingPages> {
  int _currentPage = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 40,
                  child: Container(
                    width: 320,
                    height: 650.16,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.8),
                          blurRadius: 50,
                          spreadRadius: 10,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  child: Container(
                    width: 320,
                    height: 650.16,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      image: const DecorationImage(
                        image: AssetImage("assets/images/mock.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Elevate Your News\nExperience Now!",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.playfair(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Join our vibrant community of news enthusiasts. Share your thoughts, and engage in meaningful discussions.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.urbanist(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        width: index == _currentPage ? 20 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color:
                              index == _currentPage
                                  ? Colors.teal
                                  : Colors.white30,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/home');
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          "Get Started",
                          style: GoogleFonts.urbanist(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
