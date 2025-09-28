import 'package:flutter/material.dart';

// Este será el contenedor de todo el juego y el manejador del estado
class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  // ===================================================
  // I. VARIABLES DE ESTADO (MEMORIA DEL JUEGO)
  // ===================================================
  final List<String> _words = [
    'FLUTTER',
    'DART',
    'WIDGET',
    'MERCADO',
    'PROGRAMACION',
  ];
  String _secretWord = '';
  Set<String> _guessedLetters = {}; // Almacena todas las letras ingresadas
  int _maxAttempts = 7;
  int _wrongGuesses = 0;
  // bool _gameIsOver = false;

  // Variables para los puntos extra
  int _wins = 0;
  int _losses = 0;

  @override
  void initState() {
    super.initState();
    // Aquí puedes cargar _wins y _losses desde SharedPreferences
    _startGame();
  }

  // ===================================================
  // II. LÓGICA DEL JUEGO
  // ===================================================

  void _startGame() {
    // Selecciona una palabra aleatoria al iniciar
    final int randomIndex = DateTime.now().second % _words.length;
    _secretWord = _words[randomIndex];

    // Resetea el estado
    _guessedLetters = {};
    _wrongGuesses = 0;
    // _gameIsOver = false;

    // Llama a setState para asegurar que la UI se actualice
    // si el método se llama DESPUÉS de la carga inicial
    if (mounted) {
      setState(() {});
    }
  }

  void _handleLetterGuess(String letter) {
    // La lógica que se ejecuta cuando el usuario presiona una letra
    if (_guessedLetters.contains(letter)) {
      return; // La letra ya fue usada, no hacer nada
    }

    // Usar setState para cambiar el estado y forzar la actualización de la UI
    setState(() {
      _guessedLetters.add(letter);

      if (!_secretWord.contains(letter)) {
        _wrongGuesses++; // Se dibuja una parte del ahorcado
      }

      // **TO-DO:** Agregar lógica para chequear si el jugador ganó o perdió
      // y si debe llamar a _wins++ o _losses++ y a _saveHighscores()
    });
  }

  // ===================================================
  // III. ESTRUCTURA DE LA UI (Método build)
  // ===================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Juego del Ahorcado'), // StatelessWidget (título)
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        // El Column principal (Estructura vertical obligatoria)
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // 1. Contador de Partidas / Intentos (Scoreboard Widget)
          Text('Intentos restantes: ${_maxAttempts - _wrongGuesses}'),

          // 2. Imagen del Ahorcado (HangmanImage Widget - basado en _wrongGuesses)
          const Placeholder(fallbackHeight: 200), // Placeholder para el dibujo
          // 3. Palabra a Adivinar (WordDisplay Widget - basado en _secretWord y _guessedLetters)
          Text(_getDisplayWord()), // TO-DO: Mover esto a un widget Stateless

          const Spacer(), // Empuja el teclado hacia el fondo
          // 4. Teclado de Letras (Keyboard Widget - llama a _handleLetterGuess)
          const Placeholder(fallbackHeight: 150), // Placeholder para el teclado
        ],
      ),
    );
  }

  // Función auxiliar para mostrar la palabra con guiones bajos
  String _getDisplayWord() {
    String display = '';
    for (int i = 0; i < _secretWord.length; i++) {
      String letter = _secretWord[i];
      if (_guessedLetters.contains(letter)) {
        display += '$letter ';
      } else {
        display += '_ ';
      }
    }
    return display;
  }
}
