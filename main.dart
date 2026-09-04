import 'package:energieconverterapp/hoofdscherm.dart';
import 'package:flutter/material.dart';
import 'instellingen_pagina.dart';

// 1. Houdt bij of de Dark Mode aan of uit staat
ValueNotifier<bool> isDarkModeNotifier = ValueNotifier<bool>(false);

void main() {
  runApp(const MijnEnergieApp());
}

class MijnEnergieApp extends StatelessWidget {
  const MijnEnergieApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 2. Zorgt dat de app direct reageert als de switch wordt omgezet
    return ValueListenableBuilder<bool>(
      valueListenable: isDarkModeNotifier,
      builder: (context, isDarkMode, child) {
        return MaterialApp(
          title: 'Energie Converter',
          debugShowCheckedModeBanner: false,

          // 3. Hier bepalen we het thema op basis van de switch
          themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,

          // Licht thema
          theme: ThemeData(
            brightness: Brightness.light,
            scaffoldBackgroundColor: Colors.amber[100],
            appBarTheme: const AppBarTheme(backgroundColor: Colors.orange),
          ),

          // Donker thema
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: Colors.grey[900],
            appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
          ),

          home: const Hoofdscherm(),
        );
      },
    );
  }
}