import 'package:desafio/models/evolutions.dart';
import 'package:desafio/models/pokemon.dart';
import 'package:string_extensions/string_extensions.dart';

class DetailsController {
  List<String>? evolucoes = <String>[];
  List<String>? ids = <String>[];

  List<String> statNames = [
    'ATTACK',
    'SPEED',
    'DEF',
    'HP',
  ];

  List<String> allEvolutions(Chain c) {
    if (c.evolvesTo!.isNotEmpty) {
      evolucoes!.add(c.species!.name!);

      Uri uri = Uri.parse(c.species!.url!);
      ids!.add(uri.pathSegments.last);

      for (int i = 0; i < c.evolvesTo!.length; i++) {
        evolucoes!.add(c.evolvesTo!.elementAt(i).species!.name!);
        recursive(c.evolvesTo!.elementAt(i).evolvesTo!);
      }
    }
    return evolucoes!;
  }

  void recursive(List<EvolvesTo> evolvesTo) {
    if (evolvesTo.isNotEmpty) {
      for (int i = 0; i < evolvesTo.length; i++) {
        Uri uri = Uri.parse(evolvesTo.elementAt(i).species!.url!);
        ids!.add(uri.pathSegments.last);

        evolucoes!.add(evolvesTo.elementAt(i).species!.name!);
        recursive(evolvesTo.elementAt(i).evolvesTo!);
      }
    }
  }

  String tipo(List<Types> t) {
    List<String> tipos = [];
    String resultado = '';

    for (int i = 0; i < t.length; i++) {
      tipos.add(t[i].type!.name!.capitalize!);
    }
    resultado = tipos.join(", ");

    if (t.length == 1) {
      return 'Tipo: ' + resultado;
    } else {
      return 'Tipos: ' + resultado;
    }
  }

  String tipoEvo(List<Types> t) {
    List<String> tipos = [];
    String resultado = '';

    for (int i = 0; i < t.length; i++) {
      tipos.add(t[i].type!.name!.capitalize!);
    }
    resultado = tipos.join(", ");

    return resultado;
  }

  List<double> stats(List<Stats> s) {
    List<int> pos = [0, 1, 2, 5];
    List<double> stats = [];

    for (int i = 0; i < 4; i++) {
      stats.add(s[pos[i]].baseStat!.toDouble());
    }
    return stats;
  }

  List<String> moves(List<Moves> m) {
    List<String> moves = [];

    for (int i = 0; i < m.length; i++) {
      moves.add(m[i].move!.name!.capitalize!);
    }
    return moves;
  }
}
