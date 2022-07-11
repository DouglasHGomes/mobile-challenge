import 'package:desafio/models/pokemon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:string_extensions/string_extensions.dart';
import '../bloc/search/search_bloc.dart';
import '../controllers/favorites_controller.dart';
import '../controllers/search_controller.dart';
import 'details_page.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  SearchController search = SearchController();
  List<PokemonModel> favoritos = <PokemonModel>[];

  @override
  void initState() {
    super.initState();

    getAllFavorites();
  }

  Future<void> getAllFavorites() async {
    favoritos = await FavoritesController.instance.readAllPokemon();

    BlocProvider.of<SearchBloc>(context).namePokemon.clear();

    for (int i = 0; i < favoritos.length; i++) {
      BlocProvider.of<SearchBloc>(context).namePokemon.add(favoritos[i].name!);
    }

    BlocProvider.of<SearchBloc>(context).add(SearchFetchList());
  }

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
                  'Favoritos',
                  style: TextStyle(
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: Color(0xFF02005B),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: BlocConsumer<SearchBloc, SearchState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is SearchLoadedState) {
            if (state.pokemon.isEmpty) {
              return const Center(
                child: Text('Nenhum Pokémon favoritado!',
                    style: TextStyle(
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: Color(0xFF02005B),
                    )),
              );
            } else {
              return ListView.builder(
                itemCount: state.pokemon.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 1),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailsPage(
                                    geralModel:
                                        state.pokemon.elementAt(index))));
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
                                state.pokemon
                                    .elementAt(index)
                                    .pokemon
                                    .sprites!
                                    .frontDefault!,
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                          state.pokemon
                              .elementAt(index)
                              .pokemon
                              .name!
                              .capitalize!,
                          style: const TextStyle(
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Color(0xFFFD1A55),
                          ),
                        ),
                        subtitle: Text(
                          search.tipo(
                              state.pokemon.elementAt(index).pokemon.types!),
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
            }
          } else if (state is SearchLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SearchErrorState) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: Color(0xFF02005B),
                ),
              ),
            );
          } else {
            return const Center(
              child: Text(
                'Pokémon não encontrado!',
                style: TextStyle(
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: Color(0xFF02005B),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
