import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Nodig voor NumberFormat
import 'data.dart';

class ResultaatPagina extends StatelessWidget {
  const ResultaatPagina({super.key});

  // Functie om getallen leesbaar te maken (bijv. 1.000.000)
  String formatGetal(String getalString) {
    double? getal = double.tryParse(getalString);
    if (getal == null) return getalString;

    // Formateert met punten als duizendtallen en maximaal 4 decimalen
    final formatter = NumberFormat("#,##0.####", "nl_NL");
    return formatter.format(getal);
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    final Color backgroundColor = isDark ? Colors.grey[900]! : Colors.amber[100]!;
    final Color containerColor = isDark ? Colors.grey[850]! : Colors.white;
    final Color textColor = isDark ? Colors.white : Colors.black;
    final Color subTextColor = isDark ? Colors.blueGrey[200]! : Colors.blueGrey;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
          title: const Text('Resultaat'),
          backgroundColor: isDark ? Colors.black : Colors.orange
      ),
      body: Center(
        child: Container(
          width: 320,
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: containerColor,
            border: Border.all(color: isDark ? Colors.white : Colors.black, width: 1),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Resultaat',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: textColor),
              ),
              const SizedBox(height: 30),

              // We gebruiken hier formatGetal voor zowel de invoer als de uitkomst
              Text(
                '${formatGetal(ingevuldGetal)} $gekozenEenheid1 is ${formatGetal(uitkomst)} $gekozenEenheid2',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: textColor),
              ),

              const SizedBox(height: 30),
              Text(
                'Gebruikte berekening:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: textColor),
              ),
              const SizedBox(height: 5),

              Text(
                berekeningTekst,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: subTextColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}