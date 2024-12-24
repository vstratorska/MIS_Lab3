

import '../models/types_model.dart';
import '../widgets/jokes.dart';

class JokeService {
  List<Joke> getJoke() {
    return jokesRawData.map((json) => Joke.fromJson(json)).toList();
  }
}
