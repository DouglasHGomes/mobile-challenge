import 'package:bloc/bloc.dart';
import 'package:desafio/models/evolutions.dart';
import 'package:desafio/models/pokemon.dart';
import 'package:desafio/models/species.dart';
import 'package:desafio/models/stream_prokemon_model.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  // Variaveis auxiliares que guardam a resposta da API.
  late PokemonModel pokemonModel;
  late EvolutionsModel evolutionsModel;
  late SpeciesModel speciesModel;

  // Vetor com os nomes dos pokemons.
  late List<String> pokemonSearchList = <String>[];

  // Objeto para inserir na Stream com a resposta da API.
  late List<StreamPokemonModel> pokemonList = <StreamPokemonModel>[];

  SearchBloc(SearchState initialState) : super(SearchLoadingState()) {
    on<SearchEvent>((event, emit) async {
      if (event is SearchFetchList) {
        emit(SearchLoadingState());

        pokemonList.clear();

        try {
          for (int i = 0; i < pokemonSearchList.length; i++) {
            pokemonModel = await event.getPokemon(
              pokemonSearchList.elementAt(i),
            );

            speciesModel = await event.getSpecies(
              pokemonModel.id!,
            );

            evolutionsModel = await event.getEvolutions(
              speciesModel.evolutionChain!.url!,
            );

            pokemonList.add(StreamPokemonModel(
              pokemon: pokemonModel,
              species: speciesModel,
              evolutions: evolutionsModel,
            ));
          }

          emit(SearchLoadedState(
            pokemons: pokemonList,
          ));
        } catch (e) {
          emit(const SearchErrorState(
            message: 'Não foi possível encontrar o Pokémon!',
          ));
        }
      }
    });
  }

  void setSearchList(List<String> list) {
    pokemonSearchList.clear();
    pokemonSearchList.addAll(list);
  }
}
