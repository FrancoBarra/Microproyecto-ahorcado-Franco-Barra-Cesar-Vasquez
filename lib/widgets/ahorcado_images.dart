import 'package:flutter/material.dart';

class AhorcadoImages extends StatelessWidget {
  // Parámetro que recibe: el número actual de fallos
  final int wrongGuesses;

  const AhorcadoImages({super.key, required this.wrongGuesses});

  @override
  Widget build(BuildContext context) {
    // 1. Determina el índice de la imagen a mostrar
    // El índice debe ir de 0 a 7, siendo 7 el peor caso.
    // Usamos el valor directamente de wrongGuesses

    // Aseguramos que el índice no exceda 7
    final int imageIndex = wrongGuesses.clamp(0, 7);

    // 2. Construye la ruta al archivo de imagen
    final String imagePath = 'assets/imagenes_ahorcado/ahorcado$imageIndex.png';

    // 3. Usa el widget Image.asset para mostrar la imagen
    return Container(
      // Padding para darle un poco de espacio
      padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
      height: 250, // Altura fija para que la UI no salte
      width: double.infinity,
      child: Image.asset(
        imagePath,
        fit: BoxFit.contain, // Asegura que la imagen se ajuste sin cortar
        // Puedes agregar un placeholder si la imagen no se carga (opcional)
        errorBuilder: (context, error, stackTrace) {
          return const Center(
            child: Text(
              'Falta la imagen del Ahorcado. Chequea assets/imagenes_ahorcado/',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.red),
            ),
          );
        },
      ),
    );
  }
}
