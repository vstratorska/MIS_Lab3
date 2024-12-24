import 'package:flutter/material.dart';
import 'package:lab2/providers/joke_provider.dart';
import 'package:lab2/widgets/details/detail_data.dart';
import 'package:lab2/widgets/joke_item.dart';
import 'package:provider/provider.dart';



class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<JokeProvider>().joke.where(
          (j) => j.isFavorite,
        );

    return favorites.isEmpty
        ? const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.heart_broken),
                SizedBox(
                  height: 10,
                ),
                Text("You've no favorites yet."),
              ],
            ),
          )
        : Container(
        margin: const EdgeInsets.all(10),
        child: Column(
            children: favorites.map(
              (joke) {
                return JokeItem(
                  joke: joke,
                );
              },
            ).toList(),
          ));
  }
 }
