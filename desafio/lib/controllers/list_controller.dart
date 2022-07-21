import 'package:string_extensions/string_extensions.dart';

import '../models/pokemon.dart';

class ListController {
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
}
