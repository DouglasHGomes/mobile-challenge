import 'package:bloc/bloc.dart';
import 'package:desafio/models/evolutions.dart';
import 'package:desafio/models/pokemon.dart';
import 'package:desafio/models/species.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  late List<PokemonModel> poke = <PokemonModel>[];
  late EvolutionsModel evo;
  late SpeciesModel species;
  late List<String> namePokemon = <String>[];

  SearchBloc(SearchState initialState) : super(SearchLoadingState()) {
    on<SearchEvent>((event, emit) async {
      if (event is SearchFetchList) {
        emit(SearchLoadingState());

        for (int i = 0; i < namePokemon.length; i++) {
          try {
            poke.add(await event.getPokemon(namePokemon.elementAt(i)));
            species = await event.getSpecies(poke.elementAt(i).id!);
            evo = await event.getEvolutions(species.evolutionChain!.url!);

            emit(SearchLoadedState(
                pokemon: poke, species: species, evolutions: evo));
          } catch (e) {
            emit(const SearchErrorState(
                message: 'Não foi possível encontrar o Pokémon!'));
          }
        }
      }
    });
  }
}
