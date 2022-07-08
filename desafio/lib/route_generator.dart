import 'package:desafio/models/evolutions.dart';
import 'package:desafio/models/pokemon.dart';
import 'package:desafio/pages/home_page.dart';
import 'package:desafio/pages/details_page.dart';
import 'package:desafio/pages/history_page.dart';
import 'package:desafio/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/search/search_bloc.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final name = settings.arguments;
    final poke = settings.arguments;
    final evo = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => const HomePage(
                  title: 'Pokedéx',
                ));
      case '/search':
        if (name is String) {
          return MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                  value: BlocProvider.of<SearchBloc>(context)
                    ..add(SearchFetchList()),
                  child: SearchPage(
                    pokemonName: name,
                  )));
          /*builder: (_) => SearchPage(
                    pokemonName: name,
                  ));*/
        }
        return noSuchRoute();
      case '/details':
        if (poke is PokemonModel && evo is EvolutionsModel) {
          return MaterialPageRoute(
            builder: (_) => DetailsPage(
              pokemonModel: poke,
              evolutionsModel: evo,
            ),
          );
        }
        return noSuchRoute();
      case '/history':
        return MaterialPageRoute(
          builder: (_) => const HistoryPage(),
        );

      default:
        return noSuchRoute();
    }
  }

  static Route<dynamic> noSuchRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('ERRO'),
        ),
        body: const Center(
          child: Text('Esta página não existe!'),
        ),
      );
    });
  }
}
