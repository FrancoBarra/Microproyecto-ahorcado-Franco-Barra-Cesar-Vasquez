import 'package:flutter/material.dart';

class WordDisplay extends StatelessWidget {
  // 1. Parámetros que recibe de GameScreen
  final String secretWord;
  final Set<String> guessedLetters;

  // 2. Constructor constante con el parámetro 'key' (buena práctica)
  const WordDisplay({
    super.key,
    required this.secretWord,
    required this.guessedLetters,
  });

  // Función para determinar qué letra mostrar (la lógica de GameScreen ahora vive aquí)
  String _getDisplayWord() {
    String display = '';
    // Itera sobre la palabra secreta
    for (int i = 0; i < secretWord.length; i++) {
      String letter = secretWord[i];

      // Si la letra ya fue adivinada, la muestra
      if (guessedLetters.contains(letter)) {
        display += '$letter ';
      }
      // Si no ha sido adivinada, muestra un guion bajo
      else {
        display += '_ ';
      }
    }
    return display;
  }

  @override
  Widget build(BuildContext context) {
    // 3. Muestra el resultado de la función en un widget Text con buen estilo
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        _getDisplayWord(),
        style: const TextStyle(
          fontSize: 36, // Tamaño grande para la palabra
          fontWeight: FontWeight.bold,
          letterSpacing: 8, // Espacio entre letras para mejor visualización
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
