part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchFetchList extends SearchEvent{
  
  final dio = Dio();
  SearchFetchList();

  Future<PokemonModel> getPokemon(String name) async {
    try {
      Response response =
        await dio.get("https://pokeapi.co/api/v2/pokemon/" + name);
      return PokemonModel.fromJson(response.data);
    } catch (e) {
      throw (const SearchErrorState(message: 'Não foi possível carregar os dados do Pokémon!'));
    }
  }

  Future<SpeciesModel> getSpecies(int id) async {
    try {
      Response response =
        await dio.get("https://pokeapi.co/api/v2/pokemon-species/" + id.toString());
      return SpeciesModel.fromJson(response.data);
    } catch (e) {
      throw (const SearchErrorState(message: 'Não foi possível carregar os dados das espécies!'));
    }
  }

  Future<EvolutionsModel> getEvolutions(String url) async {
    try {
      Response response =
        await dio.get(url);
      return EvolutionsModel.fromJson(response.data);
    } catch (e) {
      throw (const SearchErrorState(message: 'Não foi possível carregar os dados de evoluções!'));
    }
  }
}