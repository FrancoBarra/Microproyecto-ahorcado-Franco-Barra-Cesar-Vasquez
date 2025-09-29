import 'package:flutter/material.dart';

class ScoreboardWidget extends StatelessWidget {
  // Parámetros que recibe de GameScreen (el estado del juego)
  final int wins;
  final int losses;
  final int attemptsRemaining;
  final int wrongGuesses; // Usaremos este como el "dibujo" temporal

  const ScoreboardWidget({
    super.key,
    required this.wins,
    required this.losses,
    required this.attemptsRemaining,
    required this.wrongGuesses,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          // 1. Puntuación Global (Wins / Losses)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('🏆 Ganadas: $wins', style: const TextStyle(fontSize: 18)),
              Text('❌ Perdidas: $losses', style: const TextStyle(fontSize: 18)),
            ],
          ),

          const SizedBox(height: 20),

          // 2. Contador de Errores e Intentos Restantes
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Muestra los errores (temporalmente reemplaza el dibujo del ahorcado)
              Text(
                'Intentos Fallidos: $wrongGuesses',
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 30),
              // Muestra los intentos que le quedan al usuario
              Text(
                'Restantes: $attemptsRemaining',
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          // Indicador visual de la barra de progreso de errores (opcional)
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value:
                wrongGuesses /
                (wrongGuesses + attemptsRemaining), // Calcula el progreso
            backgroundColor: Colors.green[100],
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}
