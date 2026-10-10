import 'package:flutter/material.dart';

class AppConstants {
  // Osnovni API URL za artinfo.ba
  static const String baseUrl = 'https://artinfo.ba/wp-json/wp/v2/';

  // Definicija kategorija i njihovih WordPress API endpointova
  // (Napomena: WordPress ID-jevi kategorija se prema potrebi mogu prilagoditi ovisno o ID-ju na CMS-u, 
  // ali se mogu pozivati i direktno preko slug/naziva ili mapiranih ruta)
  static const String allNews = '${baseUrl}posts?_embed';
  
  // Primjeri kategorija prema izborniku portala artinfo.ba
  static const String categoryVijesti = '${baseUrl}posts?categories=1&_embed'; // ID za Vijesti (primjer)
  static const String categorySport = '${baseUrl}posts?categories=2&_embed';    // ID za Sport (primjer)
  static const String categoryKultura = '${baseUrl}posts?categories=3&_embed';  // ID za Kultura (primjer)
  static const String categoryCrnaKronika = '${baseUrl}posts?categories=4&_embed'; // ID za Crnu kroniku
  static const String categoryPolitika = '${baseUrl}posts?categories=5&_embed';     // ID za Politiku
  static const String categoryZanimljivosti = '${baseUrl}posts?categories=6&_embed'; // ID za Zanimljivosti

  // Metoda za dinamičko generiranje linka prema ID-ju kategorije
  static String getPostsByCategory(int categoryId) {
    return '${baseUrl}posts?categories=$categoryId&_embed';
  }
}
