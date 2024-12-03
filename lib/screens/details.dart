import 'package:flutter/material.dart';
import 'package:lab2/models/joketype.dart';
import 'package:lab2/services/api_service.dart';

import '../models/types_model.dart';
import '../widgets/details/detail_back_button.dart';
import '../widgets/details/detail_data.dart';
import '../widgets/details/detail_title.dart';
import 'joke_of_the_day.dart';


class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  JType type = JType(jokes: []);
  String t = '';


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)?.settings.arguments as JokeType;
    t = arguments.type.toString();
    print("type: $t");
    if (t.isNotEmpty) {
      getJokes(t);
    }
  }

  void getJokes(String t) async {
    ApiService.getJokesForType(t).then((response){
      print("response: $response");
      setState(() {
        type = JType (
          type: t,
          jokes: List<Joke>.from(response.map((j) => Joke.fromJson(j))),
        );
      });
    }).catchError((error){
      print("Error: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as JokeType;
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(mainAxisSize: MainAxisSize.min,
          children: [
            DetailTitle(id: arguments.id, type: arguments.type),
            DetailData(id: arguments.id, type: type),
        ],
        ),
      ),
      floatingActionButton: const DetailBackButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
