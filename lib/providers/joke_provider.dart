import 'package:flutter/material.dart';
import 'package:lab2/screens/details.dart';
import 'package:lab2/services/api_service.dart';

import '../models/types_model.dart';
import '../service/joke_service.dart';


class JokeProvider extends ChangeNotifier {
  final _jokeService = JokeService();
  late final List<Joke> joke;

  JokeProvider() {
    joke = _jokeService.getJoke();
  }


  void toggleFavorite(Joke joke) {
    joke.isFavorite = !joke.isFavorite;
    notifyListeners();
  }
}
