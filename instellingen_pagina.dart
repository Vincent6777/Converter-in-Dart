import 'package:flutter/material.dart';
import 'main.dart'; // Verbinding met de isDarkModeNotifier

class InstellingenPagina extends StatelessWidget {
  const InstellingenPagina({super.key});

  @override
  Widget build(BuildContext context) {
    // We kijken hier of de app op dit moment in dark mode staat
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      // Achtergrond: Amber in light mode, donkergrijs in dark mode
      backgroundColor: isDark ? Colors.grey[900] : Colors.amber[100],

      appBar: AppBar(
        title: const Text('Instellingen'),
        // AppBar: Zwart in dark mode, oranje in light mode
        backgroundColor: isDark ? Colors.black : Colors.orange,
      ),

      body: Center(
        child: Container(
          width: 360,
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            // De grote box wordt donkergrijs in dark mode, wit in light mode
            color: isDark ? Colors.grey[850] : Colors.white,
            // De rand wordt wit in dark mode, zwart in light mode
            border: Border.all(color: isDark ? Colors.white : Colors.black, width: 1.5),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // VAK 1: FORMULES
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: isDark ? Colors.grey[700]! : Colors.grey.shade400, width: 1.5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Formules',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: isDark ? Colors.white : Colors.black),
                      ),
                      const SizedBox(height: 4),
                      Divider(color: isDark ? Colors.grey[700] : Colors.grey),
                      const SizedBox(height: 8),

                      _FormuleRij(eenheid: 'Joule:', formule1: 'kJ = invoer / 1000', formule2: 'cal = invoer / 4.184', formule3: 'kWh = invoer / 3600000', isDark: isDark),
                      const SizedBox(height: 12),

                      _FormuleRij(eenheid: 'KiloJoule:', formule1: 'J = invoer * 1000', formule2: 'cal = invoer * 239.006', formule3: 'kWh = invoer / 360', isDark: isDark),
                      const SizedBox(height: 12),

                      _FormuleRij(eenheid: 'Calorie:', formule1: 'J = invoer * 4.184', formule2: 'kJ = invoer / 239.006', formule3: 'kWh = invoer / 860421', isDark: isDark),
                      const SizedBox(height: 12),

                      _FormuleRij(eenheid: 'kWh:', formule1: 'J = invoer * 3600000', formule2: 'kJ = invoer * 3600', formule3: 'cal = invoer * 860421', isDark: isDark),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // VAK 2: DEFINITIES
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: isDark ? Colors.grey[700]! : Colors.grey.shade400, width: 1.5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Definities',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: isDark ? Colors.white : Colors.black),
                      ),
                      const SizedBox(height: 4),
                      Divider(color: isDark ? Colors.grey[700] : Colors.grey),
                      const SizedBox(height: 8),

                      _DefinitieTekst(titel: 'Joule', tekst: 'Internationale standaardeenheid voor energie.', isDark: isDark),
                      const SizedBox(height: 8),
                      _DefinitieTekst(titel: 'KiloJoule', tekst: 'Gelijk aan 1000 Joule. Veel gebruikt voor voeding.', isDark: isDark),
                      const SizedBox(height: 8),
                      _DefinitieTekst(titel: 'Calorie', tekst: 'Oude eenheid voor warmte, nu voor voedingswaarde.', isDark: isDark),
                      const SizedBox(height: 8),
                      _DefinitieTekst(titel: 'kWh', tekst: 'Eenheid voor elektrisch energieverbruik.', isDark: isDark),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // LIGHT/DARK TOGGLE RIJ
                ValueListenableBuilder<bool>(
                  valueListenable: isDarkModeNotifier,
                  builder: (context, isDarkMode, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Light/dark toggle',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: isDark ? Colors.white : Colors.black),
                        ),
                        Switch(
                          value: isDarkMode,
                          activeColor: Colors.orange,
                          onChanged: (bool newValue) {
                            isDarkModeNotifier.value = newValue;
                          },
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// zorgt deze code ervoor dat elke formule-rij automatisch dezelfde opmaak,kleuren en witruimte krijgt. Als ik iets wil veranderen, hoeft dat maar op één plek.

class _FormuleRij extends StatelessWidget {
  final String eenheid;
  final String formule1;
  final String formule2;
  final String formule3;
  final String? formule4;
  final bool isDark;

  const _FormuleRij({
    required this.eenheid,
    required this.formule1,
    required this.formule2,
    required this.formule3,
    this.formule4,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    // Koptekstkleur blijft oranje, tenzij in dark mode (dan iets lichter oranje voor leesbaarheid)
    final Color eenheidKleur = isDark ? Colors.orangeAccent : Colors.orange;
    // Tekstkleur switcht tussen wit en zwart
    final Color tekstKleur = isDark ? Colors.white : Colors.black;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 85,
          child: Text(
            eenheid,
            style: TextStyle(fontWeight: FontWeight.bold, color: eenheidKleur, fontSize: 14),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(formule1, style: TextStyle(fontSize: 13, height: 1.3, color: tekstKleur)),
              Text(formule2, style: TextStyle(fontSize: 13, height: 1.3, color: tekstKleur)),
              Text(formule3, style: TextStyle(fontSize: 13, height: 1.3, color: tekstKleur)),
              if (formule4 != null) Text(formule4!, style: TextStyle(fontSize: 13, height: 1.3, color: tekstKleur)),
            ],
          ),
        ),
      ],
    );
  }
}

class _DefinitieTekst extends StatelessWidget {
  final String titel;
  final String tekst;
  final bool isDark;

  const _DefinitieTekst({required this.titel, required this.tekst, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final Color tekstKleur = isDark ? Colors.white : Colors.black;

    return RichText(
      text: TextSpan(
        style: TextStyle(color: tekstKleur, fontSize: 13, height: 1.3),
        children: [
          TextSpan(text: '$titel: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: tekst),
        ],
      ),
    );
  }
}