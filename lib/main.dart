import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/// The app extends StatelessWidget, which makes the app itself a widget
/// The Scaffold widget, from the Material library, provides a defaut app bar, a title, and a body
/// Property that holds the widget tree for the home screen.
/// Awidget's main job is to provide a build method that describes how to display the widget in
/// terms of other. lower-level widgets.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Startup Name Generator',
      home: RandomWords(),
    );
  }
}

/// Boiler plate code for a stateful widget
class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  // for saving suggested word pairing
  final _suggestions = <WordPair>[];
  // for making the font size larger
  final _biggerFont = const TextStyle(fontSize: 18);

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16),
        // The itemBuilder callback is called once per suggested word pairing,
        // and places each suggestion into a ListTile row.
        // For even rows, the function adds a ListTile row for the word pairing
        // For odd rows, the function adds a Divider widget to visually separate the entries.
        // Note that the divider may be difficult to see on smaller devices.
        itemBuilder: (context, i) {
          // Add a one-pixel-high divider widget before each row in the ListView
          if (i.isOdd) {
            return const Divider();
          }

          // The syntax "i ~/ 2" divides i by 2 and returns an integer result.
          // for example: 1, 2, 3, 4, 5 becomes 0, 1, 1, 2, 2.
          // This calculates the actual number of word pairings in the ListView, minus the divider widgets.
          final index = i ~/ 2;

          // if you've reached the end of the available word pairings
          if (index >= _suggestions.length) {
            // ... then generate 10 more and add them to the suggestions list
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold implements the the basic Material Design visual layout
    return Scaffold(
      appBar: AppBar(
        title: const Text('Startup Name Generator'),
      ),
      body: _buildSuggestions(),
    );
  }
}
