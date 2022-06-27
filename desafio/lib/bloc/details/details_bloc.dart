import 'package:desafio/models/evolutions.dart';
import 'package:desafio/models/pokemon.dart';
import 'package:string_extensions/string_extensions.dart';

class DetailsBloc {

  List<String>? evolucoes = <String>[];
  
  List<String> allEvolutions(Chain c) {
    
    if (c.evolvesTo!.isNotEmpty) { 
      evolucoes!.add(c.species!.name!);
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
        
        evolucoes!.add(evolvesTo.elementAt(i).species!.name!);
        recursive(evolvesTo.elementAt(i).evolvesTo!);
      }
    }
  }

  String tipo (List<Types> t){

    List<String> tipos = [];
    String resultado = '';

    for (int i=0; i<t.length; i++){

      tipos.add(t[i].type!.name!.capitalize!);
    }
    resultado = tipos.join(", ");

    if(t.length == 1){
      return 'Tipo: ' + resultado;
    }else{
      return 'Tipos: ' + resultado;
    }
  }

  List<int> status (List<Stats> s){

    List<int> status = [];

    for (int i=0; i<s.length; i++){

      status.add(s[i].baseStat!);
    }
    return status;
  }

  List<String> moves (List<Moves> m){

    List<String> moves = [];

    for (int i=0; i<m.length; i++){

      moves.add(m[i].move!.name!.capitalize!);
    }
    return moves;
  }
}