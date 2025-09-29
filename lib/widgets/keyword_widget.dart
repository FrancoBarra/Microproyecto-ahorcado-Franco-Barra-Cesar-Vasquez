import 'package:flutter/material.dart';

class KeyboardWidget extends StatelessWidget {
  // 1. Parámetros que recibe:
  // onKeyPress: La función que GameScreen le pasa para manejar la lógica.
  final void Function(String) onKeyPress;
  // usedLetters: El Set de letras ya adivinadas (correctas o incorrectas)
  final Set<String> usedLetters;

  const KeyboardWidget({
    super.key,
    required this.onKeyPress,
    required this.usedLetters,
  });

  // El alfabeto en un formato que facilita la creación de filas (3 filas de 10, 10, 6)
  static const List<String> _alphabet = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z',
  ];

  // Define cuántos botones van en cada fila para un diseño limpio
  static const List<int> _rowLengths = [10, 10, 6];

  @override
  Widget build(BuildContext context) {
    List<Widget> rows =
        []; // Lista para almacenar los widgets Row (las filas del teclado)
    int startIndex = 0;

    // Itera para crear las filas
    for (int length in _rowLengths) {
      // 1. Obtiene el subconjunto de letras para la fila actual
      List<String> rowLetters = _alphabet.sublist(
        startIndex,
        startIndex + length,
      );

      // 2. Crea los botones para esta fila
      List<Widget> buttons = rowLetters.map((letter) {
        // Verifica si la letra ya fue utilizada para deshabilitar el botón
        final bool isUsed = usedLetters.contains(letter);

        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: ElevatedButton(
            // Si la letra ha sido usada, onPressed es null (botón deshabilitado)
            onPressed: isUsed ? null : () => onKeyPress(letter),

            style: ElevatedButton.styleFrom(
              minimumSize: const Size(35, 35), // Tamaño mínimo del botón
              // Si fue usada, darle un color diferente para indicarlo
              backgroundColor: isUsed ? Colors.grey : Colors.blueGrey,
              foregroundColor: Colors.white,
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            child: Text(letter),
          ),
        );
      }).toList();

      // 3. Envuelve los botones en un Row (organización horizontal)
      rows.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.center, // Centra los botones en la fila
            children: buttons,
          ),
        ),
      );

      startIndex += length; // Avanza el índice para la próxima fila
    }

    // 4. Envuelve todos los Rows en un Column (organización vertical del teclado)
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: rows,
      ),
    );
  }
}
