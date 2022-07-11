import 'package:shared_preferences/shared_preferences.dart';

final List<String> pesquisas = <String>['', '', ''];

class SharedPreferencesController {
  Future<void> setHistory(String nome) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (pesquisas.isEmpty) {
      pesquisas.add(nome);
    } else if (pesquisas.contains(nome)) {
      pesquisas.removeWhere((element) => element == nome);
      pesquisas.insert(0, nome);
    } else {
      pesquisas.insert(0, nome);
      pesquisas.removeLast();
    }
    prefs.setStringList('lista', pesquisas);
  }

  void getHistory(List<String> lista) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    lista = prefs.getStringList('lista')!;
  }
}
