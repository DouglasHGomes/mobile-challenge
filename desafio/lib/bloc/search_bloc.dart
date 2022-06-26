import 'package:bloc/bloc.dart';
import 'package:desafio/models/evolutions.dart';
import 'package:desafio/models/pokemon.dart';
import 'package:desafio/models/species.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {

  late PokemonModel poke;
  late EvolutionsModel evo;
  late SpeciesModel species;
  late String namePokemon;

  SearchBloc(SearchState initialState) : super(SearchLoadingState()) {
    on<SearchEvent>((event, emit) async {
      if (event is SearchFetchList) {
        emit(SearchLoadingState());
        try {
          poke = await event.getPokemon(namePokemon);
          species = await event.getSpecies(poke.id!);
          evo = await event.getEvolutions(species.evolutionChain!.url!);

          emit(SearchLoadedState(pokemon: poke, species: species, evolutions: evo));
        } catch (e) {
          emit(const SearchErrorState(message: 'Não foi possível encontrar o Pokémon!'));
        }
      }
    });
  }
}
