import 'package:bloc/bloc.dart';
import 'package:desafio/models/evolutions.dart';
import 'package:desafio/models/geral.dart';
import 'package:desafio/models/pokemon.dart';
import 'package:desafio/models/species.dart';
import 'package:desafio/models/list.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'search_events.dart';
part 'search_states.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  late PokemonModel poke;
  late EvolutionsModel evo;
  late SpeciesModel species;
  late ListModel all;
  late String url;
  late List<String> namePokemon = <String>[];
  late List<String> nameResults = <String>[];
  late List<GeralModel> geral = <GeralModel>[];

  SearchBloc(SearchState initialState) : super(SearchLoadingState()) {
    on<SearchEvent>((event, emit) async {
      if (event is SearchFetchList) {
        emit(SearchLoadingState());
        try {
          for (int i = 0; i < namePokemon.length; i++) {
            nameResults =
                await event.searchAllPokemon(namePokemon.elementAt(i));
            for (int j = 0; j < nameResults.length; j++) {
              poke = await event.getPokemon(nameResults.elementAt(j));
              species = await event.getSpecies(poke.species!.url!);
              evo = await event.getEvolutions(species.evolutionChain!.url!);

              geral.add(
                  GeralModel(pokemon: poke, species: species, evolutions: evo));
            }
          }

          emit(SearchLoadedState(pokemon: geral));
        } catch (e) {
          emit(const SearchErrorState(
              message: 'Não foi possível encontrar o Pokémon!'));
        }
      }
      if (event is ListFetchList) {
        emit(SearchLoadingState());

        try {
          all = await event.getList(url);

          for (int i = 0; i < all.results!.length; i++) {
            poke = await event.getPokemon(all.results!.elementAt(i).name!);
            species = await event.getSpecies(poke.id!);
            evo = await event.getEvolutions(species.evolutionChain!.url!);

            geral.add(
                GeralModel(pokemon: poke, species: species, evolutions: evo));
          }
          emit(ListLoadedState(all: all, pokemon: geral));
        } catch (e) {
          emit(const SearchErrorState(
              message: 'Não foi possível carregar a lista de Pokémon!'));
        }
      }
    });
  }
}
