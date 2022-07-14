import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bloc/search/search_bloc.dart';
import '../controllers/history_controller.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  SharedPreferencesController spController = SharedPreferencesController();
  List<String>? lista = <String>[];
  final _textFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        leading: IconButton(
          onPressed: () => Navigator.pushNamed(context, '/'),
          icon: const Icon(Icons.arrow_back),
          color: const Color(0xFF02005B),
        ),
        title: const Text(
          'Pesquisar',
          style: TextStyle(
            color: Color(0xFF02005B),
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
                child: SizedBox(
              height: 43,
              width: 360,
              child: TextField(
                controller: _textFieldController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      _textFieldController.clear();
                    },
                    icon: const Icon(Icons.clear),
                    color: const Color(0xFFE0E0E0),
                  ),
                ),
                onSubmitted: (value) {
                  spController.setHistory(value);
                  BlocProvider.of<SearchBloc>(context).geral.clear();
                  BlocProvider.of<SearchBloc>(context).namePokemon = [
                    value.toLowerCase().trim()
                  ];
                  Navigator.pushNamed(
                    context,
                    '/search',
                    arguments: value,
                  );
                },
                style: const TextStyle(
                  color: Color(0xFF02005B),
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            )),
            Container(
                decoration: const BoxDecoration(
                    border: Border(
                  top: BorderSide(width: 1.5, color: Color(0xFFF2F2F2)),
                )),
                margin: EdgeInsets.only(
                    top: (MediaQuery.of(context).size.height * 0.5156)),
                child: Column(children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: const Padding(
                      padding: EdgeInsets.only(top: 18, left: 28.0, bottom: 8),
                      child: Text(
                        'Pesquisados recentemente',
                        style: TextStyle(
                          color: Color(0xFF02005B),
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  ListView.builder(
                      itemCount: lista!.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1.0, color: Color(0xFFE0E0E0)))),
                          child: ListTile(
                            contentPadding: const EdgeInsets.only(left: 28),
                            leading: Text(
                              lista!.elementAt(index),
                              style: const TextStyle(
                                color: Color(0xFF828282),
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                BlocProvider.of<SearchBloc>(context)
                                    .geral
                                    .clear();
                                BlocProvider.of<SearchBloc>(context)
                                    .namePokemon = [
                                  lista!.elementAt(index).toLowerCase().trim()
                                ];
                                Navigator.pushNamed(
                                  context,
                                  '/search',
                                  arguments: lista!
                                      .elementAt(index)
                                      .toLowerCase()
                                      .trim(),
                                );
                              },
                              icon: const Icon(Icons.history),
                            ),
                          ),
                        );
                      })
                ])),
          ],
        ),
      ),
    );
  }

  void getHistory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    lista = prefs.getStringList('lista');
    setState(() {});
  }
}
