import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/search/search_bloc.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
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
        body: Column(
          children: [
            Center(
                child: SizedBox(
              width: 350,
              child: TextField(
                onSubmitted: (value) {
                  BlocProvider.of<SearchBloc>(context)
                      .namePokemon
                      .add(value.toLowerCase());
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
            ))
          ],
        ));
  }
}
