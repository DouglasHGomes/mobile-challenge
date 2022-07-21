import 'package:desafio/models/geral.dart';
import 'package:desafio/pages/favorites_page.dart';
import 'package:desafio/pages/home_page.dart';
import 'package:desafio/pages/details_page.dart';
import 'package:desafio/pages/history_page.dart';
import 'package:desafio/pages/list_page.dart';
import 'package:desafio/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/search_bloc.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final name = settings.arguments;
    final geral = settings.arguments;

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
        }
        return noSuchRoute();
      case '/details':
        if (geral is GeralModel) {
          return MaterialPageRoute(
            builder: (_) => DetailsPage(
              geralModel: geral,
            ),
          );
        }
        return noSuchRoute();
      case '/favorites':
        return MaterialPageRoute(builder: (_) => const FavoritesPage());
      case '/history':
        return MaterialPageRoute(
          builder: (_) => const HistoryPage(),
        );
      case '/list':
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: BlocProvider.of<SearchBloc>(context)..add(ListFetchList()),
            child: const ListPage(),
          ),
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
