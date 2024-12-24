import 'package:flutter/material.dart';
import 'package:lab2/providers/joke_provider.dart';

import 'package:provider/provider.dart';

import '../models/types_model.dart';

class JokeItem extends StatefulWidget {
  const JokeItem({super.key, required this.joke});
  final Joke joke;

  @override
  State<JokeItem> createState() => _JokeItemState();
}

class _JokeItemState extends State<JokeItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.greenAccent,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(widget.joke.setup, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500)),
                Text(widget.joke.punchline, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500))
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              // color: Colors.red,
              onPressed: () {
                context.read<JokeProvider>().toggleFavorite(widget.joke);
              },
              color: widget.joke.isFavorite ? Colors.red : Colors.blueGrey,
              icon: const Icon(Icons.favorite),
            ),
          ),
        ],
      ),
    );
  }
}
