import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lab2/providers/joke_provider.dart';
import 'package:lab2/screens/details.dart';
import 'package:lab2/screens/favorites_page.dart';
import 'package:lab2/screens/joke_of_the_day.dart';
import 'package:provider/provider.dart';

import '../firebase_options.dart';
import '../main.dart';
import '../models/joketype.dart';
import '../services/api_service.dart';
import '../widgets/joketype/joketype_grid.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );



  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<JokeProvider>(
          create: (_) => JokeProvider(),
        )
      ],
      child: const MyApp(),
    ),
   );


}



class MyApp extends StatelessWidget {

  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jokes',
      initialRoute: '/',
      routes: {
        '/' : (context) => const Home(),
        '/details': (context) => const Details(),
      },
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  int currentPageIndex = 0;
  List<JokeType> joketypes = [];

  @override
  void initState() {
    super.initState();
    getJokeTypeFromAPI();

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received message: ${message.notification?.title}');
    });

    _firebaseMessaging.getToken().then((token) {
      print("FCM Token: $token");
    });
  }



  void getJokeTypeFromAPI() async {
    ApiService.getTypeFromJokeTypeAPI().then((response) {
      var data = List.from(json.decode(response.body));
      setState(() {
        joketypes = data.asMap().entries.map<JokeType>((element) {
          return JokeType(
            id: element.key + 1, // Sequential ID starting from 1
            type: element.value, // Use the string from the API as 'type'
          );
        }).toList();
      });
    });
  }



  @override
  Widget build(BuildContext context) {

    final favoriteCount = context
        .watch<JokeProvider>()
        .joke
        .where((j) => j.isFavorite)
        .length;

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
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        destinations: [
          const NavigationDestination(icon: Icon(Icons.home), label: 'Jokes'),
          NavigationDestination(
              icon: Badge(
                label: Text("$favoriteCount"),
                child: const Icon(Icons.favorite),
              ),
              label: 'Favorites'),
        ],
        selectedIndex: currentPageIndex,
      ),
      body: [
        JokeTypeGrid(joketypes: joketypes),
        const FavoritesPage(),
      ][currentPageIndex],);
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Background message: ${message.notification?.title}");
}
