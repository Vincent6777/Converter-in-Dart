import 'package:flutter/material.dart';
import 'converter_pagina.dart';
import 'resultaat_pagina.dart';
import 'instellingen_pagina.dart';

class Hoofdscherm extends StatefulWidget {
  const Hoofdscherm({super.key});

  @override
  State<Hoofdscherm> createState() => _HoofdschermState();
}

class _HoofdschermState extends State<Hoofdscherm> {
  int _geselecteerdeIndex = 0;
  bool heeftGeconverteerd = false;

  void zetGeconverteerdOpTrue() {
    setState(() {
      heeftGeconverteerd = true;
      _geselecteerdeIndex = 1;
    });
  }

  void gaNaarInstellingen() {
    setState(() {
      _geselecteerdeIndex = 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Check de huidige modus
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    // Dynamische kleuren voor de navigatiebalk
    final Color navBackgroundColor = isDark ? Colors.black : Colors.orange.shade50;
    final Color selectedItemColor = Colors.red;
    final Color unselectedItemColor = isDark ? Colors.white60 : Colors.orange.shade300;

    final List<Widget> schermen = [
      ConverterPagina(
          onConvert: zetGeconverteerdOpTrue,
          onSettings: gaNaarInstellingen
      ),
      const ResultaatPagina(),
      const InstellingenPagina(),
    ];

    return Scaffold(
      body: schermen[_geselecteerdeIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _geselecteerdeIndex,
        selectedItemColor: selectedItemColor,
        unselectedItemColor: unselectedItemColor,
        backgroundColor: navBackgroundColor,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 1 && heeftGeconverteerd == false) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Bereken eerst iets om het resultaat te zien!')),
            );
          } else {
            setState(() {
              _geselecteerdeIndex = index;
            });
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.calculate), label: 'Convert'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Resultaat'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Instellingen'),
        ],
      ),
    );
  }
}