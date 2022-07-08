import 'package:bloc/bloc.dart';
import 'package:desafio/models/evolutions.dart';
import 'package:desafio/models/geral.dart';
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
  late List<String> namePokemon = <String>[];
  late List<GeralModel> geral = <GeralModel>[];

  SearchBloc(SearchState initialState) : super(SearchLoadingState()) {
    on<SearchEvent>((event, emit) async {
      if (event is SearchFetchList) {
        emit(SearchLoadingState());

        try {
          for (int i = 0; i < namePokemon.length; i++) {
            poke = await event.getPokemon(namePokemon.elementAt(i));
            species = await event.getSpecies(poke.id!);
            evo = await event.getEvolutions(species.evolutionChain!.url!);

            GeralModel geralInstance =
                GeralModel(pokemon: poke, species: species, evolutions: evo);
            geral.add(geralInstance);
          }

          emit(SearchLoadedState(pokemon: geral));
        } catch (e) {
          emit(const SearchErrorState(
              message: 'Não foi possível encontrar o Pokémon!'));
        }
      }
    });
  }
}
