import 'package:flutter/material.dart';
import 'package:lab2/models/types_model.dart';

import '../services/api_service.dart';
import '../widgets/details/detail_back_button.dart';



class JokeOfTheDay extends StatefulWidget {
  const JokeOfTheDay({super.key});

  @override
  State<JokeOfTheDay> createState() => _JokeOfTheDayState();
}

class _JokeOfTheDayState extends State<JokeOfTheDay> {
   Joke joke = Joke();

  @override
  void initState() {
    super.initState();
    getJokeFromAPI();
  }

  void getJokeFromAPI() async {
    ApiService.getJokeOfTheDayAPI().then((response){
      print("response: $response");
      setState(() {
        joke = Joke.fromJson(response);
      });
    }).catchError((error){
      print("Error: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const JokeOfTheDay()),
              );
            },
            icon: const Icon(Icons.today, color: Colors.amber, size: 24)),
        title: const Text("Jokes", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.settings, color: Colors.amber, size: 24))],
      ),
      body:
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align title to the left
            children: [
              const Text("Random Joke of the Day", style: TextStyle(color: Colors.greenAccent, fontSize: 24, fontWeight: FontWeight.bold,)),
              Card(
                color: Colors.greenAccent,
                child: ListTile(
                  title: Text(joke.setup,
                      style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500)),
                  subtitle: Text(joke.punchline,
                      style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500)),
                ),
              )
            ]
        )
    ),
      floatingActionButton: const DetailBackButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,);
  }
}
