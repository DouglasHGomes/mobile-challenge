import 'package:desafio/bloc/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  runApp(MultiBlocProvider(providers: [
    BlocProvider<SearchBloc>(
        create: (context) => SearchBloc(SearchLoadingState())),
  ], child: const App()));
}
