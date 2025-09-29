import 'package:flutter/material.dart';
import '../widgets/word_display.dart';
import '../widgets/scoreboard_widget.dart';
import '../widgets/keyword_widget.dart';
import '../widgets/ahorcado_images.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final List<String> _words = [
    'CIEL0',
    'NARANJA',
    'PUENTE',
    'LUZ',
    'VIAJE',
    'TORMENTA',
    'SOMBRA',
    'ORIGEN',
    'TRUENO',
    'PLUMA',
    'ROCA',
    'SABIO',
    'OCÉANO',
    'RÍO',
    'HOJA',
    'AURORA',
    'ESPEJO',
    'ARENA',
    'LLAVE',
    'VIENTO',
    'CRISTAL',
    'LLUVIA',
    'PUERTA',
    'LAGO',
    'BRUMA',
    'FUEGO',
    'CUERDA',
    'DESTINO',
    'NUBE',
    'RELOJ',
  ];
  String _secretWord = '';
  Set<String> _guessedLetters = {};
  final int _maxAttempts = 6;
  int _wrongGuesses = 0;
  int _wins = 0;
  int _losses = 0;

  @override
  void initState() {
    super.initState();
    _startGame();
  }

  void _startGame() {
    final int randomIndex = DateTime.now().second % _words.length;
    _secretWord = _words[randomIndex];
    _guessedLetters = {};
    _wrongGuesses = 0;
    if (mounted) {
      setState(() {});
    }
  }

  void _handleLetterGuess(String letter) {
    if (_guessedLetters.contains(letter)) {
      return;
    }
    setState(() {
      _guessedLetters.add(letter);
      if (!_secretWord.contains(letter)) {
        _wrongGuesses++;
      }
      if (_wrongGuesses >= _maxAttempts) {
        _losses++;
        _showResultDialog(false);
      } else if (_isWordGuessed()) {
        _wins++;
        _showResultDialog(true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Juego del Ahorcado'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ScoreboardWidget(
            wins: _wins,
            losses: _losses,
            wrongGuesses: _wrongGuesses,
            attemptsRemaining: _maxAttempts - _wrongGuesses,
          ),
          AhorcadoImages(wrongGuesses: _wrongGuesses),
          WordDisplay(secretWord: _secretWord, guessedLetters: _guessedLetters),

          const Spacer(),
          KeyboardWidget(
            onKeyPress: _handleLetterGuess,
            usedLetters: _guessedLetters,
          ),
        ],
      ),
    );
  }

  bool _isWordGuessed() {
    for (int i = 0; i < _secretWord.length; i++) {
      String letter = _secretWord[i];
      if (!_guessedLetters.contains(letter)) {
        return false;
      }
    }
    return true;
  }

  void _showResultDialog(bool won) {
    // Aseguramos que el diálogo se muestre en la UI
    showDialog(
      context: context,
      barrierDismissible:
          false, // El usuario debe presionar un botón para salir
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            won ? '¡VICTORIA! 🎉' : '¡DERROTA! 😫',
            style: TextStyle(
              color: won ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            won
                ? '¡Felicidades! Adivinaste la palabra.'
                : 'Perdiste. La palabra secreta era: $_secretWord',
            style: const TextStyle(fontSize: 16),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Jugar de Nuevo',
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
                _startGame(); // Reinicia el juego
              },
            ),
          ],
        );
      },
    );
  }

  // Función auxiliar para mostrar la palabra con guiones bajos
}
