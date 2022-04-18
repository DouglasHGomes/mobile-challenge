
import 'package:desafio/pages/details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:string_extensions/string_extensions.dart';

import '../bloc/search_bloc.dart';
import '../models/pokemon.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key, required this.pokemonName}) : super(key: key);
  final String pokemonName;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
          color: const Color(0xFF02005B),
        ),
        title: Column(
          children: [
            Row(
              children: const [
                Text(
                  'Resultado da Pesquisa',
                  style: TextStyle(
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: Color(0xFF02005B),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const SizedBox(),
                Text(
                  widget.pokemonName,
                  style: const TextStyle(
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Color(0xFF828282),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: BlocConsumer<SearchBloc, SearchState>(
        listener: (context, state) {
        },
        builder: (context, state) {
          if(state is SearchLoadedState){
            return ListView.builder(
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailsPage(pokemonModel: state.pokemon)));
                    },
                    child: ListTile(
                      leading: Container(
                        height: 52,
                        width: 52,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              width: 2, color: const Color(0xFFFD1A55)),
                          image: DecorationImage(
                            image: NetworkImage(
                              state.pokemon.sprites!.frontDefault!,
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        state.pokemon.name.capitalize!,
                        style: const TextStyle(
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Color(0xFFFD1A55),
                        ),
                      ),
                      subtitle: Text(
                        tipo(state.pokemon.types!),
                        style: const TextStyle(
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Color(0xFF4F4F4F),
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_circle_right_sharp,
                        color: Color(0xFFFD1A55),
                      ),
                    ),
                  ),
                );
              },
            );
          }else if (state is SearchLoadingState){
            return const Center(child: CircularProgressIndicator());
          }else{
            return const Text(
              'Pokémon não encontrado!',
              style: TextStyle(
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: Color(0xFF02005B),
              ),
            );
          }
        },
      ),
    );
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
}
