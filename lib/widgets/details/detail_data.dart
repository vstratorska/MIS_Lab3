import 'package:flutter/material.dart';
import 'package:lab2/main.dart';
import 'package:lab2/models/types_model.dart';
import 'package:lab2/providers/joke_provider.dart';
import 'package:provider/provider.dart';

import '../../service/joke_service.dart';
import '../joke_item.dart';

class DetailData extends StatelessWidget {
  final int id;
  final JType type;
  final JokeService _jokeService = JokeService();
  late List<Joke> jokes = [];

  DetailData({super.key, required this.id, required this.type});


  @override
  Widget build(BuildContext context) {

    final jokes = context.watch<JokeProvider>().joke;
    final filteredJokes = jokes.where((joke) => joke.type == type.type).toList();

      return Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: Colors.white,),
          child: Column(
            children:   filteredJokes.map((joke)
            {
              return JokeItem(
                joke: joke,
              );
            }).toList(),
          ));
    }
  }


