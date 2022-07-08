//import 'package:desafio/pages/details_page.dart';
import 'package:desafio/route_generator.dart';
//import 'package:desafio/pages/search_page.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokedéx',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: const HomePage(title: 'Pokedéx',),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
