import 'package:flutter/material.dart';
import 'data.dart'; // Importeer het centrale kladblok

class ConverterPagina extends StatefulWidget {
  final VoidCallback onConvert;
  final VoidCallback onSettings;

  const ConverterPagina({super.key, required this.onConvert, required this.onSettings});

  @override
  State<ConverterPagina> createState() => _ConverterPaginaState();
}

class _ConverterPaginaState extends State<ConverterPagina> {
  final TextEditingController hoeveelController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Check de huidige modus
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    // Kleuren voor de dynamische modus
    final Color backgroundColor = isDark ? Colors.grey[900]! : Colors.amber[100]!;
    final Color containerColor = isDark ? Colors.grey[850]! : Colors.white;
    final Color textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: backgroundColor,

      appBar: AppBar(
        title: const Text('Convert'),
        backgroundColor: isDark ? Colors.black : Colors.orange,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: widget.onSettings,
          ),
        ],
      ),

      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),

            Container(
              margin: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: containerColor,
                border: Border.all(color: isDark ? Colors.white : Colors.black),
              ),
              child: Column(
                children: [
                  Text('Converter', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor)),
                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // 1. LINKER PULLDOWN
                      DropdownButton<String>(
                        value: gekozenEenheid1,
                        dropdownColor: containerColor,
                        style: TextStyle(color: textColor),
                        items: <String>['Joule', 'KiloJoule', 'Calorie', 'Kilowattuur']
                            .map((String value) => DropdownMenuItem(value: value, child: Text(value)))
                            .toList(),
                        onChanged: (String? newValue) {
                          setState(() { gekozenEenheid1 = newValue!; });
                        },
                      ),

                      IconButton(
                        icon: Icon(Icons.swap_horiz, size: 28, color: textColor),
                        onPressed: () {
                          setState(() {
                            String temp = gekozenEenheid1;
                            gekozenEenheid1 = gekozenEenheid2;
                            gekozenEenheid2 = temp;
                          });
                        },
                      ),

                      // 2. RECHTER PULLDOWN
                      DropdownButton<String>(
                        value: gekozenEenheid2,
                        dropdownColor: containerColor,
                        style: TextStyle(color: textColor),
                        items: <String>['Joule', 'KiloJoule', 'Calorie', 'Kilowattuur']
                            .map((String value) => DropdownMenuItem(value: value, child: Text(value)))
                            .toList(),
                        onChanged: (String? newValue) {
                          setState(() { gekozenEenheid2 = newValue!; });
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Invoerveld
                  Row(
                    children: [
                      SizedBox(
                        width: 120,
                        child: TextField(
                          controller: hoeveelController,
                          keyboardType: TextInputType.number,
                          style: TextStyle(color: textColor),
                          decoration: InputDecoration(
                            hintText: 'hoeveel',
                            hintStyle: TextStyle(color: textColor.withOpacity(0.5)),
                            border: const OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: textColor)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Convert knop
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () {
                        ingevuldGetal = hoeveelController.text;
                        double invoer = double.tryParse(ingevuldGetal) ?? 0;
                        double resultaatNummer = 0;

                        // Logica voor alle combinaties
                        if (gekozenEenheid1 == gekozenEenheid2) {
                          resultaatNummer = invoer;
                          berekeningTekst = "$ingevuldGetal = $resultaatNummer";
                        }

                        // JOULE BEREKENINGEN
                        else if (gekozenEenheid1 == 'Joule') {
                          if (gekozenEenheid2 == 'KiloJoule') { resultaatNummer = invoer / 1000; berekeningTekst = "$ingevuldGetal / 1000 = $resultaatNummer"; }
                          else if (gekozenEenheid2 == 'Calorie') { resultaatNummer = invoer / 4.184; berekeningTekst = "$ingevuldGetal / 4.184 = $resultaatNummer"; }
                          else if (gekozenEenheid2 == 'Kilowattuur') { resultaatNummer = invoer / 3600000; berekeningTekst = "$ingevuldGetal / 3600000 = $resultaatNummer"; }
                        }

                        // KILOJOULE BEREKENINGEN
                        else if (gekozenEenheid1 == 'KiloJoule') {
                          if (gekozenEenheid2 == 'Joule') { resultaatNummer = invoer * 1000; berekeningTekst = "$ingevuldGetal * 1000 = $resultaatNummer"; }
                          else if (gekozenEenheid2 == 'Calorie') { resultaatNummer = invoer * 239.006; berekeningTekst = "$ingevuldGetal * 239.006 = $resultaatNummer"; }
                          else if (gekozenEenheid2 == 'Kilowattuur') { resultaatNummer = invoer / 3600; berekeningTekst = "$ingevuldGetal / 3600 = $resultaatNummer"; }
                        }

                        // CALORIE BEREKENINGEN
                        else if (gekozenEenheid1 == 'Calorie') {
                          if (gekozenEenheid2 == 'Joule') { resultaatNummer = invoer * 4.184; berekeningTekst = "$ingevuldGetal * 4.184 = $resultaatNummer"; }
                          else if (gekozenEenheid2 == 'KiloJoule') { resultaatNummer = invoer / 239.006; berekeningTekst = "$ingevuldGetal / 239.006 = $resultaatNummer"; }
                          else if (gekozenEenheid2 == 'Kilowattuur') { resultaatNummer = invoer / 860421; berekeningTekst = "$ingevuldGetal / 860421 = $resultaatNummer"; }
                        }

                        // KILOWATTUUR BEREKENINGEN
                        else if (gekozenEenheid1 == 'Kilowattuur') {
                          if (gekozenEenheid2 == 'Joule') { resultaatNummer = invoer * 3600000; berekeningTekst = "$ingevuldGetal * 3600000 = $resultaatNummer"; }
                          else if (gekozenEenheid2 == 'KiloJoule') { resultaatNummer = invoer * 3600; berekeningTekst = "$ingevuldGetal * 3600 = $resultaatNummer"; }
                          else if (gekozenEenheid2 == 'Calorie') { resultaatNummer = invoer * 860421; berekeningTekst = "$ingevuldGetal * 860421 = $resultaatNummer"; }
                        }

                        uitkomst = resultaatNummer.toStringAsFixed(4);
                        heeftGeconverteerd = true;
                        widget.onConvert();
                      },
                      child: const Text('Convert knop', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}