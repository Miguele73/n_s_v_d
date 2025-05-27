import 'package:flutter/material.dart';

Future tripleWord(String userInput) async {
  await Future.delayed(Duration(seconds: 3));
  return userInput * 3;
}

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Triple Word Future',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const WordTripleScreen(),
    );
  }
}

class WordTripleScreen extends StatefulWidget {
  const WordTripleScreen({super.key});
  @override
  State<WordTripleScreen> createState() => _WordTripleScreenState();
}

class _WordTripleScreenState extends State<WordTripleScreen> {
  String _input = 'Go';
  bool _isLoading = false;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Triple Word Future')),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _input,
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            _isLoading
                ? const CircularProgressIndicator()
                : _errorMessage != null
                ? Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                  textAlign: TextAlign.center,
                )
                : const SizedBox.shrink(),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: _isLoading ? null : _duplicateText,
              child: const Text('Text verdreifachen'),
            ),
          ],
        ),
      ),
    );
  }

  void _duplicateText() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final String originalText = _input;

      final String tripledText = await tripleWord(originalText);

      setState(() {
        _input = tripledText;
      });
    } catch (e) {
      setState(() {
        _errorMessage = "Fehler aufgetreten: ${e.toString()}";
        debugPrint("Fehler beim Verdreifachen des Strings: $e");
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
