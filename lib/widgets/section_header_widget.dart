import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SectionHeaderWidget extends StatelessWidget {
  final String title;
  final VoidCallback onViewAllPressed;

  const SectionHeaderWidget({
    Key? key,
    required this.title,
    required this.onViewAllPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.urbanist(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          GestureDetector(
            onTap: onViewAllPressed,
            child: Row(
              children: [
                Text(
                  "View All",
                  style: GoogleFonts.urbanist(color: Colors.teal, fontSize: 14),
                ),
                SizedBox(width: 4),
                Icon(Icons.chevron_right, color: Colors.teal, size: 18),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
